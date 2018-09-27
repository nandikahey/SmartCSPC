pragma solidity ^0.4.17;

contract MultiAuth{
    
    address public _requester;
    address public _receiver; 
    approval[] public _approvers;
    int n;
    
    constructor(address[] approversList, address receivedBy) public payable {
        
        _requester = msg.sender;
        _receiver = receivedBy;
        for(uint256 i=0;i<approversList.length;i++)
        {
            approval a;
            a.approver = approversList[i];
            a.isApproved = false;
            
            _approvers.push(a);
        }
    }  

    function approve() public payable{
        bool isAllApproved=true;
        for(uint256 i=0;i<_approvers.length;i++)
        {
            if(_approvers[i].approver == msg.sender)
                _approvers[i].isApproved = true;
            
            if(!_approvers[i].isApproved)
                isAllApproved = false;
                
            
        }
        if(isAllApproved)   
              _receiver.transfer(this.balance);  
    } 
    
    function getContractBalance() constant public returns(uint) {
     return this.balance;
    }
    struct approval{
        address approver;
        bool isApproved;
    }
}






