
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MyInterface.sol";

contract BaseContract is MyInterface {

    uint public myParam;
    address public callerAddress;

    function myPublicFunction(uint v) virtual public override {
        tvm.accept();
        myParam = v;
        callerAddress = msg.sender;        
    }

    function myExternalFunction(uint v) virtual external override {
        tvm.accept();
        myParam = v;
        callerAddress = msg.sender;        
    }
    function myInternalFunction(uint v) virtual internal {
        tvm.accept();
        myParam = v;
        callerAddress = msg.sender;        
    }
    function myPrivateFunction(uint v) private {
        tvm.accept();
        myParam = v;
        callerAddress = msg.sender;        
    }
    
    function myGetParam() virtual public view returns (uint){
        tvm.accept();
        return myParam;        
    }

    function myGetAddress() virtual public view returns (address){
        tvm.accept();
        return callerAddress;        
    }

    function checkPrivate(uint v) public {
        tvm.accept();
        myPrivateFunction(v);        
    }

    function checkExternal(uint v) public {
        tvm.accept();
        this.myExternalFunction(v);        
    }

    function checkInternal(uint v) public {
        tvm.accept();
        myInternalFunction(v);        
    }

    function checkPublic(uint v) public {
        tvm.accept();
        myPublicFunction(v);        
    }
}
