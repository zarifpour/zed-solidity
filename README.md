# 💠 Solidity Language Support for Zed

Enhance your Zed editor with Solidity language support through this extension.

## 🛠️ Development Setup

### 1. Clone the repository

```shell
git clone https://github.com/zarifpour/zed-solidity
```

### 2. Load the extension

Move the `zed-solidity` directory to `~/Library/Application Support/Zed/extensions/installed`.

### 3. Installation Options (ensure Docker is running)

First, navigate to the relocated repository in `~/Library/Application Support/Zed/extensions/installed`:

```shell
cd zed-solidity
```

#### Option 1: Automated

Run the following command:

```shell
make
```

> That was easy!
>
#### Option 2: Manual

1. Clone the `tree-sitter-solidity` repository:

```shell
git clone https://github.com/JoranHonig/tree-sitter-solidity
```

2. Checkout the commit specified in `grammars/solidity.toml`:

```shell
git checkout 5cb506ae419c4ad620c77210fd47500d3d169dbc
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

7. Remove the `solidity.toml` file from the `zed-solidity/grammars` directory.

## 🎸 Contributing

Contributions are welcome! Note that some features, like 'Go to Definition', are not fully supported yet. We encourage enhancements and fixes.

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
