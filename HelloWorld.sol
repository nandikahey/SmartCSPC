pragma solidity ^0.4.17;

contract HelloWorld{
    
    string private _hello;
    
    constructor(string hello) public payable{
        _hello = hello;
    }
    
    function getMessage() public view returns(string){
        return _hello;
    }
    
    function setMessage(string hello) public {
        _hello = hello;
    }
}


