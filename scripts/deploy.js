// scripts/deploy.js
// Deploys the FlashUSDT contract

const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with account:", deployer.address);

  const FlashUSDT = await ethers.getContractFactory("FlashUSDT");
  const flashUSDT = await FlashUSDT.deploy();
  await flashUSDT.waitForDeployment();

  console.log("FlashUSDT deployed to:", await flashUSDT.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 