

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'BaseStationInterface.sol';
import 'GameObjectInterface.sol';
import 'GameObject.sol';

contract MilitaryUnit is GameObject{
   
    int public powerAttack;
    address public bAddress;

    constructor(BaseStationInterface base) public {
        tvm.accept();
        base.addMilitaryUnit(base);
        bAddress = base;
    }

    function attack(GameObjectInterface addressEnemy) virtual public {
        tvm.accept();
        addressEnemy.takeAttack(this, powerAttack);
    }
    
    function getPowerAttack() virtual public returns(int){
        tvm.accept();
        return powerAttack;
    }
    
}
