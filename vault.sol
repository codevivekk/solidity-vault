// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    address public owner ;
    mapping(address => uint) deposits ;

    constructor () {
        owner = msg.sender;
    }

   function deposit()  external payable  {
    require(msg.value > 0 , "Deposite must be greater than 0");
    deposits[msg.sender] = msg.value;
   }

   function withdraw(uint amount) external returns (bool)   {
      if(amount <= address(this).balance) {
        payable(msg.sender).transfer(amount);
          return true;  
     } else {
       revert("Insufficient funds in the contract.");
     }
   }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

   function withdrawAll() external {
    require(msg.sender == owner, "Only owner can withdraw all funds");
    payable(owner).transfer(address(this).balance);
   }

}
