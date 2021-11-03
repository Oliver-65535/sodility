
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObject.sol';
import 'BaseStationInterface.sol';


contract BaseStation is GameObject {
   
    uint8 count;

    constructor(uint8 _powerProtected) public {
        powerProtected = _powerProtected;
    }

    function addMilitaryUnit(address Address) virtual public {
        tvm.accept();
        playerAddresses[count++] = Address;
    }

    function delMilitaryUnit(uint8 id) virtual public {
        tvm.accept();
        delete playerAddresses[id];
    }

   
}
