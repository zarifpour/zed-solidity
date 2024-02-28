# Define variables for repository and file names
REPO_URL=https://github.com/JoranHonig/tree-sitter-solidity
REPO_BRANCH=5cb506ae419c4ad620c77210fd47500d3d169dbc
CLONE_DIR=tree-sitter-solidity
WASM_FILE=solidity.wasm

# Target for setting up the WASM build environment and creating the WASM
build-wasm:
	git clone $(REPO_URL) $(CLONE_DIR); \
	cd $(CLONE_DIR); \
	git checkout $(REPO_BRANCH); \
	tree-sitter build-wasm; \
	mv tree-sitter-solidity.wasm ../grammars/$(WASM_FILE); \
	cd ..; \
	rm -rf grammars/solidity.toml

# Default target if no arguments are provided to 'make'
all: build-wasm
