# 💠 Solidity Language Support for Zed

Enhance your Zed editor with Solidity language support through this extension.

## 🛠️ Development Setup

**1. Clone the repository**:

```shell
git clone https://github.com/zarifpour/zed-solidity
```

**2. Load the extension**:

Move the `zed-solidity` directory to `~/Library/Application Support/Zed/extensions/installed`.

**3. Installation Options:**

- Directly run `make` (ensure Docker is running) within the cloned directory, **OR**
- Manually set up by following these steps:

  1. Navigate to the repository:

     ```shell
     cd zed-solidity
     ```

  2. Clone the `tree-sitter-solidity` repository:

     ```shell
     git clone https://github.com/parmanuxyz/tree-sitter-solidity
     ```

  3. Move into the `tree-sitter-solidity` directory:

     ```shell
     cd tree-sitter-solidity
     ```

  4. Build the WebAssembly (WASM) file (ensure Docker is running):

     ```shell
     tree-sitter build-wasm
     ```

  5. Rename the generated WASM file to `solidity.wasm`.

  6. Relocate the `solidity.wasm` file to the `zed-solidity/grammars` directory within this repository.

**Important Note:**
While this setup has not been fully tested, the grammar has been successfully built, and the extension has been observed to load correctly.
