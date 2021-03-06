//Implements EIP20 token standard:  https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
//I followed a tutorial for this code and do not own it

pragma solidity >=0.4.21 < 0.6.0;

import "./erc20Interface.sol";

contract ERC20Token is ERC20Interface {

    //define some values
    uint256 constant private MAX_UINT256 = 2**256-1; //maximum value of 256 bit uint
    mapping (address => uint256) public balances;    //mapp of addresses to balances             
    mapping (address => mapping (address => uint256)) public allowed;  //map address of account tokens to be spent from to spending account to value of tokens                                                                 
    uint256 public totSupply;  //total Supply of the coing
    string public name;  //name of the token
    uint8 public decimals;  //number of decimals of token
    string public symbol;  //short name of token

    //create the new token and assign initial values including the initial amount
    constructor(
        //parameters
        uint256 _initialAmount,
        string memory _tokenName,
        uint8 _decimalUnits,
        string memory _tokenSymbol
    )public{
        balances[msg.sender] = _initialAmount;      //the creator owns all initial tokens
        totSupply = _initialAmount;                 //Update total token supply
        name = _tokenName;                          //store the token name
        decimals = _decimalUnits;                   //store the number of decimals
        symbol = _tokenSymbol;                      //store the token symbol
    }

    //function to transfer _value number of tokens from msg.sender to _to address
    function transfer(address _to, uint _value) public returns (bool success){

        //check msg.sender has enough tokens to send
        require(balances[msg.sender] >= _value, "Insufficient funds tot transfer"); //parameters are commonly underscores
        
        //change token amounts of sender and receiver 
        balances[msg.sender] -= _value;
        balances[msg.sender] += _value;
        
        //emit is an event (sends message out to client)
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        
        //return success
        return true;
    }
    
    //function transfers token from 1 address to another
    function transferFrom(address _from, address _to, uint _tokens) public returns (bool success){
        //max uint value
        uint256 allowedVal = allowed[_from][msg.sender];
        
        //check from has the tokens and also msg.sender is allowed to transfer (second val is a return val)
        require(balances[_from] >= _tokens && allowedVal >= _tokens, "Insufficient funds allowed for transfer from address");
        
        //add and subtract token vals
        balances[_from] -= _tokens;
        balances[_to] += _tokens;
        
        //checks that allowance isnt set to maximum
        if (allowedVal < MAX_UINT256){
            allowed[_from][msg.sender] -= _tokens;
        }

        //event emission to client
        emit Transfer(_from, _to, _tokens); //solhint-disable-line indent, no-unused-vars
        
        //return success
        return true;
    }

    //function approves transaction from 1 address of tokens number of tokens
    function approve(address _spender, uint _tokens) public returns (bool success) {
        //check that msg.sender has enough tokens to be allow _spender to spend (not necessary)
        require(balances[msg.sender] >= _tokens, "Insufficient tokens to allow transfer");

        //allow spender to transfer tokens from msg.sender
        allowed[msg.sender][_spender] += _tokens;

        emit Approval(msg.sender, _spender, _tokens);
        
        //return success
        return true;
    }

    //function to return total supply of tokens
    function totalSupply() public view returns (uint) {
        return totSupply;
    }

    //function returns the balace of tokenOwner address
    function balanceOf(address _tokenOwner) public view returns (uint balance) {
        return balances[_tokenOwner];
    }
    
    //function that returns the remaing allowance of token owner (number of tokens remaining that were approved for transfer)
    function allowance(address _tokenOwner, address _spender) public view returns (uint remaining) {
        return allowed[_tokenOwner][_spender];
    }
}
