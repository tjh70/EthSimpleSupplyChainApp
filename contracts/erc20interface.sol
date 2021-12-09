//------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPS/blob/master/EIPS/eip-20.md
//------------------------------------------------------------------

pragma solidity ^0.5.9;

contract ERC20Interface {
    uint256 totSupply;

    function totalSupply() public view returns (uint);
    function balanceOf() public view returns (uint balance);
    function allowance() public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value)
    

}

