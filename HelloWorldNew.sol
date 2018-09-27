pragma solidity ^0.4.17;
contract HelloWorldNew{
    
    string private _hello;
    address public _owner;
    
    constructor(string hello) public payable{
        _hello = hello;
        _owner = msg.sender;
    }
    
    function getMessage() public view returns(string){
        return _hello;
    }
    
    function setMessage(string hello) public payable{
        require(msg.value >= 1 ether);
        _hello = hello;
    }
    
    function sendOwner() public{
        _owner.transfer(this.balance);
    }
    
    function getBalance() public view returns(uint){
        return this.balance;
    }  
}
