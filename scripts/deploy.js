const hre = require("hardhat");

async function main() {
  console.log("Deploying StudentManagement contract...");

  // Get the contract factory
  const StudentManagement = await hre.ethers.getContractFactory(
    "StudentManagement"
  );

  // Deploy the contract
  const studentManagement = await StudentManagement.deploy();

  // Log the deployment transaction hash
  console.log(
    "Deployment transaction hash:",
    studentManagement.deployTransaction.hash
  );

  // Wait for the contract to be mined
  console.log("Waiting for the contract deployment...");
  const deploymentReceipt = await studentManagement.deployTransaction.wait(); // Wait for the transaction to be mined

  console.log(`✅ Contract deployed at: ${studentManagement.address}`);
}

// Run the deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
