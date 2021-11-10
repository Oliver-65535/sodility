

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'Registable.sol';

contract Bank is Registable {
   
    uint public tvmPubkey;
    uint public msgPubkey;

    address public msgAddress;
    address public incomeAddress;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    function registerCar(address carAddress) public override{
        tvm.accept();
        tvmPubkey = tvm.pubkey();
        msgPubkey = msg.pubkey();

        msgAddress = msg.sender;
        incomeAddress = carAddress;
    }
    
    function anotherRegist() public {
         tvm.accept();
        tvmPubkey = tvm.pubkey();
        msgPubkey = msg.pubkey();

        msgAddress = msg.sender;
    }
    
}