 # OnChain Media

## Project Overview

OnChain Media is a decentralized social media backend built entirely on Solidity smart contracts. It supports user registration, post creation, likes, and comments, all on-chain. By storing content directly on an Ethereum-compatible blockchain, OnChain Media ensures transparency, immutability, and censorship resistance for user-generated content.

## Features

* **Fully On-Chain**: User profiles, posts, likes, and comments are stored entirely on-chain with no centralized backend.
* **User Registration**: Users can register unique usernames with an optional bio, establishing an on-chain identity.
* **Post Creation**: Registered users can create posts. Each post records the author's address and timestamp on-chain.
* **Likes & Unlikes**: Users can like or unlike posts. Each action is validated on-chain to prevent duplicates and ensure integrity.
* **Comments**: Users can comment on posts. Comments include the commenter's username and are stored on-chain.
* **Comprehensive Testing**: 100% test coverage with unit tests and fuzz testing using Foundry. All contract functions are thoroughly verified to ensure reliability.

## Test Coverage

&#x20;This project maintains 100% test coverage. Foundry’s `forge test` suite covers every contract function with both unit tests and fuzz tests. Robust testing guarantees that all code paths are validated, ensuring high code quality and reliability.

## Deployment

To deploy the OnChain Media contracts, ensure you have Foundry installed (see the [Foundry Book](https://book.getfoundry.sh) for instructions) and configure the necessary environment variables. You’ll need an `RPC_URL` (e.g., an Infura or Alchemy endpoint) and a `PRIVATE_KEY` for your deployment account.

Example deployment command:

```bash
forge create --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> src/OpenMedia.sol:OpenMedia
```

Replace `<RPC_URL>` and `<PRIVATE_KEY>` with your endpoint and private key. This command compiles and deploys the `OpenMedia` contract (from `src/OpenMedia.sol`) to the specified network.

## Running Tests

After setting up Foundry, run the full test suite with:

```bash
forge test
```

This will compile the contracts and execute all unit and fuzz tests. Ensure any local blockchain (e.g., Anvil) is running if required by the tests.

## Getting Started

1. **Clone the repository**:

   ```bash
   git clone https://github.com/YourUsername/OnChainMedia.git
   cd OnChainMedia
   ```
2. **Install Foundry & dependencies**:

   ```bash
   forge install
   forge build
   ```
3. **Run tests**:

   ```bash
   forge test
   ```
4. **Deploy the contract** (optional):

   ```bash
   forge create --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> src/OpenMedia.sol:OpenMedia
   ```

## Contributing

Contributions and ideas are welcome! Please feel free to open issues for bug reports or feature requests. If you have suggestions or want to improve the code, submit a pull request. Your feedback and enhancements help make OnChain Media better for everyone.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

* GitHub: [YourUsername](https://github.com/YourUsername)
* LinkedIn: [Your Name](https://www.linkedin.com/in/yourprofile)
Thanks! I’ll put together a professional README for **OnChain Media** that appeals to developers, recruiters, and clients. It will include:

* A clear project description and feature summary.
* A test coverage badge.
* Deployment instructions using `forge create`.
* Sections on usage, contribution, and licensing.

I’ll let you know as soon as it’s ready.


# OnChain Media

## Project Overview

OnChain Media is a decentralized social media backend built entirely on Solidity smart contracts. It supports user registration, post creation, likes, and comments, all on-chain. By storing content directly on an Ethereum-compatible blockchain, OnChain Media ensures transparency, immutability, and censorship resistance for user-generated content.

## Features

* **Fully On-Chain**: User profiles, posts, likes, and comments are stored entirely on-chain with no centralized backend.
* **User Registration**: Users can register unique usernames with an optional bio, establishing an on-chain identity.
* **Post Creation**: Registered users can create posts. Each post records the author's address and timestamp on-chain.
* **Likes & Unlikes**: Users can like or unlike posts. Each action is validated on-chain to prevent duplicates and ensure integrity.
* **Comments**: Users can comment on posts. Comments include the commenter's username and are stored on-chain.
* **Comprehensive Testing**: 100% test coverage with unit tests and fuzz testing using Foundry. All contract functions are thoroughly verified to ensure reliability.

## Test Coverage

&#x20;This project maintains 100% test coverage. Foundry’s `forge test` suite covers every contract function with both unit tests and fuzz tests. Robust testing guarantees that all code paths are validated, ensuring high code quality and reliability.

## Deployment

To deploy the OnChain Media contracts, ensure you have Foundry installed (see the [Foundry Book](https://book.getfoundry.sh) for instructions) and configure the necessary environment variables. You’ll need an `RPC_URL` (e.g., an Infura or Alchemy endpoint) and a `PRIVATE_KEY` for your deployment account.

Example deployment command:

```bash
forge create --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> src/OpenMedia.sol:OpenMedia
```

Replace `<RPC_URL>` and `<PRIVATE_KEY>` with your endpoint and private key. This command compiles and deploys the `OpenMedia` contract (from `src/OpenMedia.sol`) to the specified network.

## Running Tests

After setting up Foundry, run the full test suite with:

```bash
forge test
```

This will compile the contracts and execute all unit and fuzz tests. Ensure any local blockchain (e.g., Anvil) is running if required by the tests.

## Getting Started

1. **Clone the repository**:

   ```bash
    git clone https://github.com/YourUsername/OnChainMedia.git
    cd OnChainMedia
   ```
2. **Install Foundry & dependencies**:

   ```bash
    forge install
    forge build
   ```
3. **Run tests**:

   ```bash
    forge test
   ```
4. **Deploy the contract** (optional):

   ```bash
   forge create --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> src/OpenMedia.sol:OpenMedia
   ```
  To check coverage run:
  ```bash
  forge coverage
  ```

## Contributing

Contributions and ideas are welcome! Please feel free to open issues for bug reports or feature requests. If you have suggestions or want to improve the code, submit a pull request. Your feedback and enhancements help make OnChain Media better for everyone.

 

## Author

* Gmail : [YourUsername](https://github.com/YourUsername)
 
