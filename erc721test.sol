// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importing OpenZeppelin's ERC20 and ERC721 contracts
import "./node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

// ERC20 Token Contract
contract MyERC20Token is ERC20 {
    // Constructor to initialize the token with a name and symbol, and mint an initial supply
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Function to mint new tokens, can be called externally
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    // Function to burn tokens, can be called externally
    function burn(address from, uint256 amount) external {
        _burn(from, amount);
    }
}

// Echidna Test Contract for MyERC20Token
contract EchidnaTestERC20 {
    MyERC20Token token; // Instance of MyERC20Token
    uint256 public initialSupply; // Variable to store the initial supply

    // Constructor to deploy a new MyERC20Token and store its initial supply
    constructor() {
        token = new MyERC20Token();
        initialSupply = token.totalSupply();
    }

    // Invariant test: total supply should remain constant
    function echidna_test_total_supply() public view returns (bool) {
        return token.totalSupply() == initialSupply;
    }

    // Function to test token transfers
    function testTransfer(address to, uint256 amount) public {
        uint256 balance = token.balanceOf(address(this));
        if (balance >= amount) {
            token.transfer(to, amount);
        }
    }

    // Function to test minting new tokens
    function testMint(address to, uint256 amount) public {
        token.mint(to, amount);
    }

    // Function to test burning tokens
    function testBurn(address from, uint256 amount) public {
        uint256 balance = token.balanceOf(from);
        if (balance >= amount) {
            token.burn(from, amount);
        }
    }
}

// ERC721 Token Contract
contract MyERC721Token is ERC721 {
    uint256 private _tokenIdCounter; // Counter for token IDs

    // Constructor to initialize the token with a name and symbol
    constructor() ERC721("MyNFT", "MNFT") {
        _tokenIdCounter = 0;
    }

    // Function to mint new NFTs, increments the token ID counter
    function mint(address to) external {
        _tokenIdCounter += 1;
        _mint(to, _tokenIdCounter);
    }

    // Function to get the total supply of NFTs minted
    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter;
    }
}

// Echidna Test Contract for MyERC721Token
contract EchidnaTestERC721 {
    MyERC721Token token; // Instance of MyERC721Token
    uint256 public initialSupply; // Variable to store the initial supply

    // Constructor to deploy a new MyERC721Token and store its initial supply
    constructor() {
        token = new MyERC721Token();
        initialSupply = token.totalSupply();
    }

    // Invariant test: total supply should remain constant
    function echidna_test_total_supply() public view returns (bool) {
        return token.totalSupply() == initialSupply;
    }

    // Function to test NFT transfers
    function testTransfer(address to, uint256 tokenId) public {
        if (token.ownerOf(tokenId) == address(this)) {
            token.transferFrom(address(this), to, tokenId);
        }
    }

    // Function to test minting new NFTs
    function testMint(address to) public {
        uint256 previousSupply = token.totalSupply();
        token.mint(to);
        uint256 newSupply = token.totalSupply();
        assert(newSupply == previousSupply + 1); // Check if total supply increased by 1
    }
}
