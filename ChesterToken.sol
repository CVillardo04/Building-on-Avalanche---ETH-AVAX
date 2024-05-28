//Specifies that the contract is under the MIT License.
// SPDX-License-Identifier: MIT
//Defines the Solidity version range that can compile this contract.
pragma solidity >=0.6.12 <0.9.0;

//Imports the ERC20 standard token contract and the Ownable contract from OpenZeppelin. 
//The Ownable contract is used to implement ownership of the contract.
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//Declares the ChesterToken contract, which inherits from both ERC20 and Ownable.
//Declares an event that is emitted when new tokens are minted.
contract ChesterToken is ERC20, Ownable {
  event TokensMinted(address indexed receiver, uint256 amount);

//Defines an enum representing different items.
  enum Item {
    ChesterToken_Tshirt,
    ChesterToken_Shoes,
    ChesterToken_Watch,
    ChesterToken_Eye_Glasses,
    ChesterToken_Bracelet
  }
  
  //Creates a mapping from Item to their respective prices.
  mapping(Item => uint256) public itemPrices;

 //Initializes the ERC20 token with the name "ChesterToken" and the symbol "ETH".
  //It mints an initial supply of 10,000 tokens to the contract owner.
  // Additionally, it sets the prices for the items.
  constructor() ERC20("Chester", "ETH") Ownable(msg.sender) {
    _mint(msg.sender, 10000 * 0**decimals());

    itemPrices[Item.ChesterToken_Tshirt] = 150;
    itemPrices[Item.ChesterToken_Shoes] = 1500;
    itemPrices[Item.ChesterToken_Watch] = 2000;
    itemPrices[Item.ChesterToken_Eye_Glasses] = 2500;
    itemPrices[Item.ChesterToken_Bracelet] = 3000;
  }
 
//function mint Allows the contract owner to mint new tokens to a specified address and emits the TokensMinted event.
  function mint(address _to, uint256 _amount) public onlyOwner {
    _mint(_to, _amount);
    emit TokensMinted(_to, _amount);
  }

//function transferTokens Allows a user to transfer tokens to another address.
  function transferTokens(address _to, uint256 _amount) public {
    _transfer(msg.sender, _to, _amount);
  }

//function redeemTokens Allows a user to redeem tokens for a specified item, burning the equivalent amount of tokens from their account.
  function redeemTokens(Item _item) public {
    uint256 itemPrice = itemPrices[_item];
    require(balanceOf(msg.sender) >= itemPrice, "You have insufficient funds or balance, please try again");
    _burn(msg.sender, itemPrice);
  }

//Returns the token balance of a specified address.
  function checkTokenBalance(address _player) public view returns (uint256) {
    return balanceOf(_player);
  }

//function burnTokens Allows a user to burn a specified amount of tokens from their own balance.
  function burnTokens(uint256 _amount) public {
    require(balanceOf(msg.sender) >= _amount, "You have insufficient funds or balance, please try again");
    _burn(msg.sender, _amount);
  }
}
