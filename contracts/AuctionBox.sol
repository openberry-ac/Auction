// We will be using Solidity version 0.5.3
pragma solidity 0.5.3;
// Importing OpenZeppelin's SafeMath Implementation
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract AuctionBox{
    Auction[] public auctions; 
   
    function createAuction (
        string memory _title,
        uint _startPrice,
        string memory _description
        ) public{
        require(_startPrice > 0);
        // set the new instanc
        Auction newAuction = new Auction(msg.sender, _title, _startPrice, _description);
        // push the auction address to auctions array
        auctions.push(newAuction);
    }
    
    function returnAllAuctions() public view returns(Auction[] memory){
        return auctions;
    }
}

contract Auction {
    
    using SafeMath for uint256;
    
    address payable private owner; 
    string title;
    uint startPrice;
    string description;

    enum State{Default, Running, Finalized}
    State public auctionState;

    uint public highestPrice;
    address payable public highestBidder;
    mapping(address => uint) public bids;
    
    /** @dev constructor to creat an auction
      * @param _owner who call createAuction() in AuctionBox contract
      * @param _title the title of the auction
      * @param _startPrice the start price of the auction
      * @param _description the description of the auction
      */
      
    constructor(
        address payable _owner,
        string memory _title,
        uint _startPrice,
        string memory _description
        
        ) public {
        // initialize auction
        owner = _owner;
        title = _title;
        startPrice = _startPrice;
        description = _description;
        auctionState = State.Running;
    }
    
    modifier notOwner(){
        require(msg.sender != owner);
        _;
    }
    
    /** @dev Function to place a bid
      * @return true
      */
    
    function placeBid() public payable notOwner returns(bool) {
        require(auctionState == State.Running);
        require(msg.value > 0);
        // update the current bid
        // uint currentBid = bids[msg.sender] + msg.value;
        uint currentBid = bids[msg.sender].add(msg.value);
        require(currentBid > highestPrice);
        // set the currentBid links with msg.sender
        bids[msg.sender] = currentBid;
        // update the highest price
        highestPrice = currentBid;
        highestBidder = msg.sender;
        
        return true;
    }
    
    function finalizeAuction() public{
        //the owner and bidders can finalize the auction.
        require(msg.sender == owner || bids[msg.sender] > 0);
        
        address payable recipiant;
        uint value;
        
        // owner can get highestPrice
        if(msg.sender == owner){
            recipiant = owner;
            value = highestPrice;
        }
        // highestBidder can get no money
        else if (msg.sender == highestBidder){
            recipiant = highestBidder;
            value = 0;
        }
        // Other bidders can get back the money 
        else {
            recipiant = msg.sender;
            value = bids[msg.sender];
        }
        // initialize the value
        bids[msg.sender] = 0;
        recipiant.transfer(value);
        auctionState = State.Finalized;
    }
    
    /** @dev Function to return the contents od the auction
      * @return the title of the auction
      * @return the start price of the auction
      * @return the description of the auction
      * @return the state of the auction 
      */    
    
    function returnContents() public view returns(        
        string memory,
        uint,
        string memory,
        State
        ) {
        return (
            title,
            startPrice,
            description,
            auctionState
        );
    }
    
}