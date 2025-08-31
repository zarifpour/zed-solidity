# Solidity Language Support for Zed

This is a community-maintained fork of the original [zed-solidity](https://github.com/zarifpour/zed-solidity) extension by Daniel Zarifpour. Since the original repository is no longer actively maintained, this fork continues development with new features and updates.

Provides syntax highlighting and language server integration for Solidity, including diagnostics, formatting, go-to definition, and more.

- Tree Sitter: [tree-sitter-solidity](https://github.com/JoranHonig/tree-sitter-solidity)
- Language Server: [@nomicfoundation/solidity-language-server](https://github.com/NomicFoundation/hardhat-vscode/tree/main/server)

## 🛠️ Development Setup

### 1. Clone the repository

```shell
git clone https://github.com/czepluch/zed-solidity
```

### 2. Uninstall the existing extension

If you have the existing extension installed, you need to uninstall it before installing the development version.

### 3. Load the extension

- Open `zed: extensions`.
- Click `Install Dev Extension`.
- Select the `zed-solidity` directory.

### 4. Rebuild the extension as needed

As you make changes to the extension, you may need to rebuild it. To do so:

- Open `zed: extensions`.
- Click the `Rebuild` button next to the extension.

## 🎸 Contributing

Contributions are welcome!

To contribute:

1. Fork the repo and create a new branch.
2. Make changes and test them.
3. Submit a pull request with a clear description.

Check open issues for areas needing improvement. Thanks for helping improve Solidity support in Zed!

<a href="https://github.com/czepluch/zed-solidity/graphs/contributors">
  <img alt="contrib.rocks" src="https://contrib.rocks/image?repo=czepluch/zed-solidity" />
</a>

## 🏆 Acknowledgments

- [@JoranHonig](https://github.com/JoranHonig) for providing the [tree-sitter-solidity](https://github.com/JoranHonig/tree-sitter-solidity) repository.
- [@meetmangukiya](https://github.com/meetmangukiya) and [@tomholford](https://github.com/tomholford) for inspiration with their PRs to the main Zed repo.

---

<div align=center>

**Community-maintained by Jacob Czepluch**

*Originally created with 🩵 by [Daniel Zarifpour](https://zarifpour.xyz)*

</div>
