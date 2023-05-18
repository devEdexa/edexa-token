// SPDX-License-Identifier: MIT

/*

                                                                                                 
                                dddddddd                                                         
                                d::::::d                  XXXXXXX       XXXXXXX                  
                                d::::::d                  X:::::X       X:::::X                  
                                d::::::d                  X:::::X       X:::::X                  
                                d:::::d                   X::::::X     X::::::X                  
    eeeeeeeeeeee        ddddddddd:::::d     eeeeeeeeeeee  XXX:::::X   X:::::XXX  aaaaaaaaaaaaa   
  ee::::::::::::ee    dd::::::::::::::d   ee::::::::::::ee   X:::::X X:::::X     a::::::::::::a  
 e::::::eeeee:::::ee d::::::::::::::::d  e::::::eeeee:::::ee  X:::::X:::::X      aaaaaaaaa:::::a 
e::::::e     e:::::ed:::::::ddddd:::::d e::::::e     e:::::e   X:::::::::X                a::::a 
e:::::::eeeee::::::ed::::::d    d:::::d e:::::::eeeee::::::e   X:::::::::X         aaaaaaa:::::a 
e:::::::::::::::::e d:::::d     d:::::d e:::::::::::::::::e   X:::::X:::::X      aa::::::::::::a 
e::::::eeeeeeeeeee  d:::::d     d:::::d e::::::eeeeeeeeeee   X:::::X X:::::X    a::::aaaa::::::a 
e:::::::e           d:::::d     d:::::d e:::::::e         XXX:::::X   X:::::XXXa::::a    a:::::a 
e::::::::e          d::::::ddddd::::::dde::::::::e        X::::::X     X::::::Xa::::a    a:::::a 
 e::::::::eeeeeeee   d:::::::::::::::::d e::::::::eeeeeeeeX:::::X       X:::::Xa:::::aaaa::::::a 
  ee:::::::::::::e    d:::::::::ddd::::d  ee:::::::::::::eX:::::X       X:::::X a::::::::::aa:::a
    eeeeeeeeeeeeee     ddddddddd   ddddd    eeeeeeeeeeeeeeXXXXXXX       XXXXXXX  aaaaaaaaaa  aaaa
                                                                                                 
*/

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract edeXa is ERC20, ERC20Burnable, Pausable, Ownable {
    
    uint256 public constant MAX_SUPPLY = 10_000_000_000 * 10**18; // Maximum supply: 10 billion tokens

    constructor() ERC20("edeXa", "EDX") {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds maximum supply of 10 billion");
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
