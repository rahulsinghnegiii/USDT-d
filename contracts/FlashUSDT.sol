// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FlashUSDT is ERC20, Ownable {
    uint256 public immutable deploymentTime;
    uint256 public constant EXPIRY_DURATION = 90 days;

    constructor() ERC20("FlashUSDT", "FUSDT") Ownable(msg.sender) {
        deploymentTime = block.timestamp;
        // Mint 100,000 tokens (with 18 decimals)
        _mint(msg.sender, 100_000 * 10 ** decimals());
    }

    // Modifier to check if token is expired
    modifier notExpired() {
        require(block.timestamp <= deploymentTime + EXPIRY_DURATION, "Token transfers expired");
        _;
    }

    // Override transfer
    function _update(address from, address to, uint256 value) internal override notExpired {
        super._update(from, to, value);
    }
} 