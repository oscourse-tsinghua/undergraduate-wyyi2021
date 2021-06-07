//Traffic contract

var trafficContractAccount = '0x6B25e93efedf7E802d660DC40f92D9489A6C5467'; 
var trafficContractAddress = '0xD512c10E6ce36eDE2F039768adEbFE9E0BA01fBf';
var trafficContractServer = 'http://localhost:8545';
var trafficContract;
var trafficContractAbi = [
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "string",
          "name": "uuid",
          "type": "string"
        },
        {
          "internalType": "int256",
          "name": "lastTime",
          "type": "int256"
        }
      ],
      "name": "initUser",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "int256",
          "name": "dividee",
          "type": "int256"
        },
        {
          "internalType": "int256",
          "name": "divider",
          "type": "int256"
        }
      ],
      "name": "divide",
      "outputs": [
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        }
      ],
      "payable": false,
      "stateMutability": "pure",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "string",
          "name": "uuid",
          "type": "string"
        },
        {
          "internalType": "int256",
          "name": "time",
          "type": "int256"
        },
        {
          "internalType": "bool",
          "name": "result",
          "type": "bool"
        },
        {
          "internalType": "bool",
          "name": "isTest",
          "type": "bool"
        }
      ],
      "name": "revalueByValidation",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "string",
          "name": "uuid",
          "type": "string"
        }
      ],
      "name": "clearValidation",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "string",
          "name": "uuid",
          "type": "string"
        }
      ],
      "name": "getQuality",
      "outputs": [
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "internalType": "string",
          "name": "uuid",
          "type": "string"
        }
      ],
      "name": "getInterval",
      "outputs": [
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        },
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        },
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        },
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        },
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        },
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ];
