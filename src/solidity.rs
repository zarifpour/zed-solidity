use std::{env, fs};
use zed::LanguageServerId;
use zed_extension_api::{self as zed, Result};

// Debug logging macro
macro_rules! debug_log {
    ($msg:expr) => {
        eprintln!("[SOLIDITY DEBUG] {}", $msg);
    };
    ($fmt:expr, $($arg:tt)*) => {
        eprintln!("[SOLIDITY DEBUG] {}", format!($fmt, $($arg)*));
    };
}

const SERVER_PATH: &str = "node_modules/@nomicfoundation/solidity-language-server/out/index.js";
const PACKAGE_NAME: &str = "@nomicfoundation/solidity-language-server";

struct SolidityExtension {
    did_find_server: bool,
}

impl SolidityExtension {
    fn server_exists(&self) -> bool {
        fs::metadata(SERVER_PATH).map_or(false, |stat| stat.is_file())
    }

    fn server_script_path(
        &mut self,
        language_server_id: &LanguageServerId,
        _worktree: &zed::Worktree,
    ) -> Result<String> {
        debug_log!("server_script_path called");
        let server_exists = self.server_exists();
        debug_log!("server_exists: {}", server_exists);

        if self.did_find_server && server_exists {
            debug_log!("returning cached server path: {}", SERVER_PATH);
            return Ok(SERVER_PATH.to_string());
        }

        debug_log!("checking for updates for package: {}", PACKAGE_NAME);
        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::CheckingForUpdate,
        );
        let version = zed::npm_package_latest_version(PACKAGE_NAME)?;
        debug_log!("latest version found: {}", version);

        let installed_version = zed::npm_package_installed_version(PACKAGE_NAME)?;
        debug_log!("installed version: {:?}", installed_version);

        if !server_exists || installed_version.as_ref() != Some(&version) {
            debug_log!(
                "installing/updating package {} version {}",
                PACKAGE_NAME,
                version
            );
            zed::set_language_server_installation_status(
                language_server_id,
                &zed::LanguageServerInstallationStatus::Downloading,
            );
            let result = zed::npm_install_package(PACKAGE_NAME, &version);
            match result {
                Ok(()) => {
                    if !self.server_exists() {
                        Err(format!(
                            "installed package '{PACKAGE_NAME}' did not contain expected path '{SERVER_PATH}'",
                        ))?;
                    }
                }
                Err(error) => {
                    if !self.server_exists() {
                        Err(error)?;
                    }
                }
            }
        }

        self.did_find_server = true;
        debug_log!("successfully resolved server path: {}", SERVER_PATH);
        Ok(SERVER_PATH.to_string())
    }
}

impl zed::Extension for SolidityExtension {
    fn new() -> Self {
        debug_log!("SolidityExtension::new() called");
        Self {
            did_find_server: false,
        }
    }

    fn language_server_command(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        debug_log!(
            "language_server_command called for language_server_id: {:?}",
            language_server_id
        );
        // debug_log!("worktree path: {:?}", worktree.path()); // path() method not available

        let server_path = self.server_script_path(language_server_id, worktree)?;
        debug_log!("server_path resolved to: {}", server_path);

        let node_path = zed::node_binary_path()?;
        debug_log!("node_binary_path: {}", node_path);

        let server_full_path = env::current_dir()
            .unwrap()
            .join(&server_path)
            .to_string_lossy()
            .to_string();
        debug_log!("full server path: {}", server_full_path);

        Ok(zed::Command {
            command: node_path,
            args: vec![server_full_path, "--stdio".to_string()],
            env: Default::default(),
        })
    }
}

zed::register_extension!(SolidityExtension);
