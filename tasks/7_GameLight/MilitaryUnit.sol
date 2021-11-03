

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

//import 'BaseStationInterface.sol';
import 'GameObjectInterface.sol';
//import 'GameObject.sol';

contract MilitaryUnit is GameObjectInterface{
   
    int public powerAttack;
    int public powerProtected;
    int public health;

    constructor() public {
        tvm.accept();
        health = 100;
    }

    function attack(GameObjectInterface addressEnemy) virtual public {
        tvm.accept();
        addressEnemy.takeAttack(this, powerAttack);
    }
    
    function getPowerAttack() virtual public returns(int){
        tvm.accept();
        return powerAttack;
    }
    function getPowerProtected() virtual public returns(int){
        tvm.accept();
        return powerProtected;
    }
    function getHealth() virtual public returns(int){
        tvm.accept();
        return health;
    }
    
    function takeAttack(address addr, int pwrAttack) virtual public override{
        tvm.accept();
        int damage;
        damage = pwrAttack - powerProtected;
        health = health - damage;
        if(health <= 0 ) {
            sendBooty(addr);
        }
    }

    function sendBooty(address addr) public {
        tvm.accept();
        addr.transfer(1, true, 160);
    }
    
}
