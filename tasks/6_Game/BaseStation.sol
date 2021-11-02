
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObject.sol';
import 'BaseStationInterface.sol';

contract BaseStation is GameObject {
   
    mapping(address => uint8) public playerAddresses;
    address public baseAddress;
    uint8 count;

    constructor(uint8 _powerProtected) public {
        powerProtected = _powerProtected;
        //addMilitaryUnit(this);
        //baseAddress = address(this);
    }

    function addMilitaryUnit(address Address) virtual public {
        tvm.accept();
        playerAddresses[Address] = count++;
        //return Address;
    }

    function delMilitaryUnit(address Address) virtual public {
        tvm.accept();
        delete playerAddresses[Address];
    }
    
   
}
