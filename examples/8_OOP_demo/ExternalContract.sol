
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MyInterface.sol";

contract ExternalContract {
    
    uint32 public myParam;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function callToPublic(MyInterface myAddress, uint value) public pure checkOwnerAndAccept {
        myAddress.myPublicFunction(value);        
    }
    
    function callToExternal(MyInterface myAddress, uint value) public pure checkOwnerAndAccept {
        myAddress.myExternalFunction(value);        
    }    
}
