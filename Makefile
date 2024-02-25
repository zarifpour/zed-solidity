# Define variables for repository and file names
REPO_URL=https://github.com/parmanuxyz/tree-sitter-solidity
CLONE_DIR=tree-sitter-solidity
WASM_FILE=solidity.wasm

# Target for setting up the WASM build environment and creating the WASM
build-wasm:
	git clone $(REPO_URL) $(CLONE_DIR); \
	cd $(CLONE_DIR); \
	tree-sitter build-wasm; \
	mv tree-sitter-solidity.wasm ../grammars/$(WASM_FILE); \
	cd ..; \
	rm -rf $(CLONE_DIR)

# Default target if no arguments are provided to 'make'
all: build-wasm
