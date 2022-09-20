// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


import "./recipient.sol";
import "./IERC223.sol";
import "./Address.sol";

contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

 contract ERC223Token is IERC223, IERC223Recipient, SafeMath {
string  private _name;
    string  private _symbol;
    uint8   private _decimals;
    uint256 private _totalSupply;
    
    mapping(address => uint256) public balances; 

  
     
    constructor(string memory new_name, string memory new_symbol, uint256 total_supply)
    {
        _name     = new_name;
        _symbol   = new_symbol;
        _decimals = 18;
        _totalSupply = total_supply;
        balances[msg.sender] = _totalSupply;


    }

     function name() public view override returns (string memory)
    {
        return _name;
    }

     function symbol() public view override returns (string memory)
    {
        return _symbol;
    }

     function decimals() public view override returns (uint8)
    {
        return _decimals;
    }

     function totalSupply() public view override returns (uint256)
    {
        return _totalSupply;
    }

     function balanceOf(address _owner) public view override returns (uint256)
    {
        return balances[_owner];
    }

        function transfer(address _to, uint _value, bytes calldata _data) public override returns (bool success)
    {
        // Standard function transfer similar to ERC20 transfer with no _data .
        // Added due to backwards compatibility reasons .
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = safeAdd(balances[_to], _value);
        if(Address.isContract(_to)) {
            IERC223Recipient(_to).tokenReceived(msg.sender, _value, _data);
        }
        emit Transfer(msg.sender, _to, _value);
        emit TransferData(_data);
        return true;
    }

     function mint(address account, uint256 amount) public returns (bool) {
        balances[account] = balances[account] + amount;
        _totalSupply = safeAdd(_totalSupply, amount);
        emit Transfer(address(0),account, amount);
        return true;
    }

     function burn(uint256 _amount) public {
        balances[msg.sender] = balances[msg.sender] - _amount;
        _totalSupply = safeSub(_totalSupply,_amount);
        emit Transfer(msg.sender, address(0), _amount);
    }



 
}