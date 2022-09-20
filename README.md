# ERC223-Implementation

##The ERC223.sol file has the main implementation of mint() and burn() functions for the ERC223 Token.
It is inheriting contracts 
1. Address.sol: For validity of addresses
2. IERC223.sol: For interface of ERC223 to later implement these functions in ERC223.sol
3. recipient.sol: This is a reciever contract which is made to recieve ERC223 tokens.

