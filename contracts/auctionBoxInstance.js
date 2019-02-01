import web3 from './web3';

const address = ''; // HERE is contract address
const abi = []; // HERE is ABI

const instance = new web3.eth.Contract(abi, address);

export default instance;
