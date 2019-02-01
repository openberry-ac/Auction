import web3 from './web3';

const address = '0x2c65a8e0e59b72b0f4207d28daa986c719753ae9'; // THE CONTRACT ADDRESS
const abi = [
  {
    constant: false,
    inputs: [
      {
        name: '_title',
        type: 'string'
      },
      {
        name: '_startPrice',
        type: 'uint256'
      },
      {
        name: '_description',
        type: 'string'
      }
    ],
    name: 'createAuction',
    outputs: [],
    payable: false,
    stateMutability: 'nonpayable',
    type: 'function'
  },
  {
    constant: true,
    inputs: [
      {
        name: '',
        type: 'uint256'
      }
    ],
    name: 'auctions',
    outputs: [
      {
        name: '',
        type: 'address'
      }
    ],
    payable: false,
    stateMutability: 'view',
    type: 'function'
  },
  {
    constant: true,
    inputs: [],
    name: 'returnAllAuctions',
    outputs: [
      {
        name: '',
        type: 'address[]'
      }
    ],
    payable: false,
    stateMutability: 'view',
    type: 'function'
  }
]; // THE ABI

const instance = new web3.eth.Contract(abi, address);

export default instance;
