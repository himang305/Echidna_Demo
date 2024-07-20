# Echidna Testing for Solidity Contracts

This README provides step-by-step instructions to install Docker, Node.js (with npm), Slither, and Echidna, and run tests on Solidity contracts using Echidna. The tests include invariant checks for ERC20 and ERC721 tokens.

## Prerequisites

- Docker installed on your machine.
- Node.js and npm installed on your machine.
- Basic knowledge of Solidity and smart contract testing.

## Steps

### 1. Install Docker

1. **Download Docker:**
   - Go to the [Docker download page](https://www.docker.com/products/docker-desktop) and download Docker Desktop for your operating system.

2. **Install Docker:**
   - Follow the installation instructions specific to your operating system.

3. **Verify Docker Installation:**
   - Open a terminal or command prompt and run:
     ```sh
     docker --version
     ```
   - You should see the Docker version information.

### 2. Install Node.js and npm

1. **Download Node.js:**
   - Go to the [Node.js download page](https://nodejs.org/) and download the LTS version for your operating system.

2. **Install Node.js:**
   - Follow the installation instructions specific to your operating system.

3. **Verify Node.js and npm Installation:**
   - Open a terminal or command prompt and run:
     ```sh
     node --version
     npm --version
     ```
   - You should see the Node.js and npm version information.

### 3. Setup Solidity Project

1. **Create a Solidity Project Directory:**
   - Create a directory for your Solidity project. For example:
     ```sh
     mkdir -p ~/solidity-project
     cd ~/solidity-project
     ```

2. **Initialize npm:**
   - Run the following command to initialize a new npm project:
     ```sh
     npm init -y
     ```

3. **Install OpenZeppelin Contracts:**
   - Install the OpenZeppelin contracts library:
     ```sh
     npm install @openzeppelin/contracts
     ```

4. **Add Your Solidity Code:**
   - Save the following Solidity code in a file named `erc721test.sol`:


### 4. Install and Run Echidna

1. **Run Echidna in Docker:**
   - Use the following command to run Echidna and test your Solidity code:
     ```sh
     docker run --rm -it -v "$(pwd):/src" trailofbits/echidna bash -c "solc-select install 0.8.20 && solc-select use 0.8.20 && echidna --contract EchidnaTestERC721 /src/erc721test.sol"
     ```

2. **Install Solc-Select:**
   - Ensure Solidity compiler version 0.8.20 is installed and used:
     ```sh
     solc-select install 0.8.20
     solc-select use 0.8.20
     ```

3. **Run Echidna:**
   - Run the Echidna tests:
     ```sh
     echidna --contract EchidnaTestERC721 /src/erc721test.sol
     ```

## Screenshots

Please refer to the provided screenshots for each step:

1. **Docker Installation Verification:**
   - ![Docker Installation](https://i.postimg.cc/GhXMTMG8/Screenshot-2024-07-12-124831.png)

2. **Solidity Project Setup:**
   - ![Project Directory](https://i.postimg.cc/BnZddLcD/Screenshot-2024-07-12-124508.png)

3. **Running Echidna:**
   - ![Echidna Running](https://i.postimg.cc/7LFtYf7K/Screenshot-2024-07-12-124716.png)

4. **Echidna Test Result without minting :**
   - ![Test Results Without Minting](https://i.postimg.cc/HxPG2p75/Screenshot-2024-07-12-115705.png)

5. **Echidna Test Result with minting :**
   - ![Test Results With Minting](https://i.postimg.cc/pV4b5LvM/Screenshot-2024-07-12-115416.png)

## Understanding the Results

### Invariant (Total Supply)

Invariants are conditions that must remain true throughout the execution of a program. In this context, the invariant being tested ensures that the total supply of tokens (either ERC20 or ERC721) remains constant after the contract's initial setup.

### Failure Without Minting Test

- **Reason:** Initially, without the `testMint` function, the total supply of tokens does not change after deployment because no new tokens are minted.
- **Result:** The invariant check succeeds because the total supply remains consistent with its initial value.

### Failure With Minting Test

- **Reason:** Upon adding the `testMint` function, new tokens are minted during testing.
- **Result:** This action increases the total supply, which violates the invariant that requires the total supply to remain constant. As a result, the invariant check fails.

### Correction

To address this issue and maintain the invariant (total supply consistency):

- Adjust the `testMint` function or any other minting logic to ensure that changes to the total supply are properly managed and do not violate the expected invariant.
- Implement additional checks or modify the contract logic to enforce the invariant condition during minting or burning operations.

### Some FAQs

## What is Echidna?

Echidna is a powerful property-based fuzzer for Ethereum smart contracts. It is developed by Trail of Bits and is used for automated testing and analysis of Solidity contracts. Echidna works by generating random inputs to test for vulnerabilities, edge cases, and compliance with specified properties or invariants within the smart contracts.

Echidna helps developers and auditors identify security vulnerabilities such as reentrancy bugs, integer overflows, and other unexpected behaviors that could compromise the security and correctness of smart contracts.

