// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RentalAgreement {
    address public landlord;
    address public tenant;
    uint256 public rentAmount;
    uint256 public securityDeposit;
    uint256 public leaseDuration;
    uint256 public leaseStart;
    bool public isActive;

    event AgreementCreated(address indexed landlord, address indexed tenant, uint256 rentAmount);
    event RentPaid(address indexed tenant, uint256 amount);
    event AgreementTerminated(address indexed terminatedBy);

    constructor(address _tenant, uint256 _rentAmount, uint256 _securityDeposit, uint256 _leaseDuration) {
        landlord = msg.sender;
        tenant = _tenant;
        rentAmount = _rentAmount;
        securityDeposit = _securityDeposit;
        leaseDuration = _leaseDuration;
        leaseStart = block.timestamp;
        isActive = true;

        emit AgreementCreated(landlord, tenant, rentAmount);
    }

    modifier onlyLandlord() {
        require(msg.sender == landlord, "Hanya pemilik yang dapat memanggil fungsi ini");
        _;
    }

    modifier onlyTenant() {
        require(msg.sender == tenant, "Hanya penyewa yang dapat memanggil fungsi ini");
        _;
    }

    modifier agreementActive() {
        require(isActive, "Perjanjian sewa sudah tidak aktif");
        _;
    }

    function payRent() external payable onlyTenant agreementActive {
        require(msg.value == rentAmount, "Jumlah sewa tidak sesuai");
        payable(landlord).transfer(msg.value);
        emit RentPaid(tenant, msg.value);
    }

    function terminateAgreement() external {
        require(msg.sender == landlord || msg.sender == tenant, "Hanya pemilik atau penyewa yang dapat mengakhiri perjanjian");
        require(isActive, "Perjanjian sudah diakhiri");

        if (block.timestamp >= leaseStart + leaseDuration) {
            // Perjanjian berakhir secara normal
            payable(tenant).transfer(securityDeposit);
        } else if (msg.sender == tenant) {
            // Penyewa mengakhiri lebih awal, kehilangan deposit
            payable(landlord).transfer(securityDeposit);
        } else {
            // Pemilik mengakhiri lebih awal, mengembalikan deposit
            payable(tenant).transfer(securityDeposit);
        }

        isActive = false;
        emit AgreementTerminated(msg.sender);
    }

    function getAgreementDetails() external view returns (
        address, address, uint256, uint256, uint256, uint256, bool
    ) {
        return (landlord, tenant, rentAmount, securityDeposit, leaseDuration, leaseStart, isActive);
    }
}