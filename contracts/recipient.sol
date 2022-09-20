// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


abstract contract IERC223Recipient {


 struct ERC223Metadata
    {
        address token_contract;
        address sender;
        uint256 value;
        bytes   data;
    }
    
    ERC223Metadata private tkn;
    

    function tokenReceived(address _from, uint _value, bytes memory _data) public virtual
    {

        tkn.token_contract = msg.sender;
        tkn.sender         = _from;
        tkn.value          = _value;
        tkn.data           = _data;
        
        // ACTUAL CODE
    }
}