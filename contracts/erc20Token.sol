//Implements EIP20 token standard:  https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md

pragma solidity >=0.4.21 < 0.6.0;

import "./erc20Interface.sol";

contract ERC20Token is ERC20Interface {

    //define some values
    uint256 constant private MAX_UINT256 = 2**256-1; //maximum value of 256 bit uint
    mapping (address => uint256) public balances;    //mapp of addresses to balances             
    mapping (address => mapping (address => uint256)) public allowed;  //map of sender address to map of reciever address to authorized tokens 
                                                                    //sender has authorized to be transfferred?
    uint256 public totSupply;  //total Supply of the coing
    string public name;  //name of the token
    uint8 public decimals;  //number of decimals of token
    string public symbol;  //short name of token

    //create the new token and assign initial values including the initial amount
    constructor(
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
         
        return false;
    }
    
    //function transfers token from 1 address to another
    function transferFrom(address _from, address _to, uint tokens) public returns (bool success){
        return false;
    }

    //function approves transaction from 1 address of tokens number of tokens
    function approve(address _spender, uint _tokens) public returns (bool success) {
        return false;
    }

    //function to return total supply of tokens
    function totalSupply() public view returns (uint) {
        return totSupply;
    }

    //function returns the balace of tokenOwner address
    function balanceOf(address _tokenOwner) public view returns (uint balance) {
        return balance[_tokenOwner];
    }
    
    //function that returns the remaing allowance of token owner (number of tokens remaining that were approved for transfer)
    function allowance(address _tokenOwner) public view returns (uint remaining) {
        return allowance(_tokenOwner);
    }

    //function to approve transaction of _token tokens from _spender address?
    function approve(address _spender, uint tokens) public returns (bool success){
        //likely something like below
        //probably need to check if tokenOwner is msg.sender and also that they have that amount of tokens
        allowance[_spender] += tokens;
        return true;
    }






}
