

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'Registable.sol';

// This is class that describes you smart contract.
contract Car {
   
    uint public doors;

    //uint static public carNumber;

    uint public tvmPubkey;
    uint public msgPubkey;

    address public msgAddress;
    address public incomeAddress;

    constructor(uint _doors) public {
        tvm.accept();
        doors = _doors;
    }

    function sendCarToGibdd(Registable gibddAddress) public {
        tvm.accept();
        gibddAddress.registerCar(this);
    }
    
    function checkKeysAndAddress() public {
        tvm.accept();
        tvmPubkey = tvm.pubkey();
        msgPubkey = msg.pubkey();

        //msgAddress = msg.sender;
        //incomeAddress = carAddress;
    }
    
}

// 0:d76c01366b39accd03e2705e361bb9080eeee298e954432ac4df90d641bb0395

// Gibdd 0:86d86bf831e852071d2db534fd3f352eec7a3a51a4ab63924da04741d9309e3a

// 0:957734946b2c15154db2fcf269c52e319d3f88c1c52240978de5557d4d28d0bc

//0:2f13cc4c39d03e60cb036b8f8df8acb502ebe8cee999b7df4420ccfa1659d3a4