
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "BaseContract.sol";

contract ChildContract is BaseContract {

    function myPublicFunction(uint v) public override {
        tvm.accept();
        myParam = v + 1;
        callerAddress = msg.sender;        
    }

    function myExternalFunction(uint v) virtual external override {
        tvm.accept();
        myParam = v + 1;
        callerAddress = msg.sender;        
    }
    function myInternalFunction(uint v) internal override {
        tvm.accept();
        myParam = v + 1;
        callerAddress = msg.sender;        
    }  
}