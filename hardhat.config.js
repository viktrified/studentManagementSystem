require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.API_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
