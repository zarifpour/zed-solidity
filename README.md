# 💠 Solidity Language Support for Zed

Enhance Zed with Solidity language support, including syntax highlighting and language server features such as diagnostics and more!

## Features

### Solidity (`.sol`)

- Syntax highlighting via [tree-sitter-solidity](https://github.com/JoranHonig/tree-sitter-solidity)
- Diagnostics, completions, go-to-definition, and other LSP features via [@nomicfoundation/solidity-language-server](https://github.com/NomicFoundation/hardhat-vscode/tree/main/server)
- Code outline, indentation, and bracket matching

### Yul (`.yul`)

- Syntax highlighting via [tree-sitter-yul](https://github.com/czepluch/tree-sitter-yul), including recognition of EVM builtins
- Code outline, indentation, and bracket matching
- No LSP support (the Nomic Foundation language server does not support standalone `.yul` files)

> [!Tip]
> For the best experience, it is highly recommended to use [XY-Zed](https://github.com/zarifpour/xy-zed). This extension has been built on top of the XY-Zed theme, ensuring that all colors are thoughtfully chosen to provide intelligent syntax highlighting.

---

![CleanShot 2024-02-28 at 02 40 51 on Zed — example sol — zed-solidity@2x](public/screenshot.png)

---

## 🛠️ Development Setup

### 1. Clone the repository

```shell
git clone https://github.com/zarifpour/zed-solidity
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

<a href="https://github.com/zarifpour/zed-solidity/graphs/contributors">
  <img alt="contrib.rocks" src="https://contrib.rocks/image?repo=zarifpour/zed-solidity" />
</a>

## 🏆 Acknowledgments

- [@JoranHonig](https://github.com/JoranHonig) for providing the [tree-sitter-solidity](https://github.com/JoranHonig/tree-sitter-solidity) repository.
- [@meetmangukiya](https://github.com/meetmangukiya) and [@tomholford](https://github.com/tomholford) for inspiration with their PRs to the main Zed repo.

---

<div align=center>

Made with 🩵 by <a href="https://zarifpour.xyz">Daniel Zarifpour</a>

<a href="https://www.buymeacoffee.com/zarifpour"><img src="https://img.buymeacoffee.com/button-api/?text=Help me love&emoji=♥️&slug=zarifpour&button_colour=ffbbb6&font_colour=000000&font_family=Cookie&outline_colour=FF0000&coffee_colour=FFDD00" /></a>

</div>
