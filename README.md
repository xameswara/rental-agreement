# Automated Rental Agreements Smart Contract

An Ethereum smart contract for automating property rental agreements.

## Description

The RentalAgreement smart contract allows property owners (landlords) to create digital rental agreements with tenants using the Ethereum blockchain. This contract handles rent payments, security deposits, and automatic agreement termination.

## Key Features

- Creation of digital rental agreements
- Rent payments via cryptocurrency
- Security deposit management
- Automatic agreement termination
- Transparency of agreement details

## Requirements

- Solidity ^0.8.0
- Ethereum wallet (such as MetaMask)
- Ethereum development environment (like Remix, Truffle, or Hardhat)

## Usage

1. Deploy the RentalAgreement contract to the Ethereum network.
2. The property owner creates an agreement by providing the tenant's address, rent amount, security deposit, and lease duration.
3. The tenant can pay rent using the `payRent()` function.
4. Either party can terminate the agreement using the `terminateAgreement()` function.
5. Anyone can view the agreement details using the `getAgreementDetails()` function.

## Main Functions

- `constructor`: Creates a new rental agreement
- `payRent()`: Allows the tenant to pay rent
- `terminateAgreement()`: Terminates the rental agreement
- `getAgreementDetails()`: Displays the agreement details

## Security

This contract uses modifiers to restrict access to certain functions. Ensure to conduct a security audit before using in a production environment.

## Further Development

Some ideas for further development:
- Implementation of automatic rent payments
- Addition of agreement extension features
- Integration with oracles for real-time rental prices
- Implementation of dispute resolution mechanisms

## License

This project is licensed under the MIT License.
