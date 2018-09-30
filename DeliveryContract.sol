pragma solidity ^0.4.17;
contract DeliveryContract{
    address public _customer;
    address private _creator;
    address private _delivaryBike;
    string private _destination;
    string private _curentLocation;
    uint private _tempThreshold = 70;
    uint private _createdTime;
    uint private _durationThreshold = 1200;
    uint private _currentTemp;
    bool private _isCompleted;
    
    constructor(address customer, address creator,address deliveryBike, string destination, uint currentTemp) public payable{
        _customer = customer;
        _creator = creator;
        _delivaryBike = deliveryBike;
        _destination = destination;
        _createdTime = now;
        _currentTemp = currentTemp;
        _isCompleted = false;
    }
    
    
    function verfiy(address deliveryBike, string currentLocation, uint currentTime, uint currentTemp){
        uint timeLapsed = currentTime - _createdTime;
        _curentLocation = currentLocation;
        if(_delivaryBike == deliveryBike){
            if(_tempThreshold > currentTemp || timeLapsed > _durationThreshold){
                verifyContract(false);
            }
            else if(stringsEqual(_curentLocation, _destination)){
                verifyContract(true);
            }
        }
    }
    
    function verifyContract(bool isCompleted) public payable{
        if(isCompleted == false){
            _customer.transfer(this.balance/10);
            _creator.transfer((this.balance/10)*9);
            selfdestruct(_creator);
        }
        else{
            _creator.transfer(this.balance);
            selfdestruct(_creator);
        }
    }
    
    function getContractBalance() constant public returns(uint) {
        return this.balance;
    }
    
    function stringsEqual(string storage _a, string storage _b) internal returns (bool) {
		bytes storage a = bytes(_a);
		bytes memory b = bytes(_b);
		if (a.length != b.length)
			return false;
		// @todo unroll this loop
		for (uint i = 0; i < a.length; i ++)
			if (a[i] != b[i])
				return false;
		return true;
	}
}