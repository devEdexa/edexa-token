require("@nomiclabs/hardhat-ethers");
require("dotenv").config();
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
// const ALCHEMY_API_KEY = "qlVE3s_fr24167eFapgGnbbFNPX0PyxL";
const { task } = require("hardhat/config");
const {
  API_URL_ETHEREUM,
  API_URL_POLYGON,
  API_URL_BINANCE,
  PRIVATE_KEY,
} = process.env;

module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {},
    ethereum: {
      url: API_URL_ETHEREUM,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    polygon: {
      url: API_URL_POLYGON,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    binance: {
      url: API_URL_BINANCE,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};



task("account", "returns nonce and balance for specified address on multiple networks")
  .addParam("address")
  .setAction(async address => {
    const web3Ethereum = createAlchemyWeb3(API_URL_ETHEREUM);
    const web3Polygon = createAlchemyWeb3(API_URL_POLYGON);
    const web3Bnb = createAlchemyWeb3(API_URL_BINANCE);
    
    const networkIDArr = ["Ethereum :", "Polygon  :", "edeXa:", "Binance:"]
    const providerArr = [web3Ethereum, web3Polygon, web3Bnb];
    const resultArr = [];
    
    for (let i = 0; i < providerArr.length; i++) {
      const nonce = await providerArr[i].eth.getTransactionCount(address.address, "latest");
      const balance = await providerArr[i].eth.getBalance(address.address)
      resultArr.push([networkIDArr[i], nonce, parseFloat(providerArr[i].utils.fromWei(balance, "ether")).toFixed(2) + "ETH"]);
    }
    resultArr.unshift(["  |NETWORK|   |NONCE|   |BALANCE|  "])
    console.log(resultArr);
  });