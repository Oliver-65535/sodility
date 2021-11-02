

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObjectInterface.sol';

 contract GameObject is GameObjectInterface {
   
    int public powerProtected;
    //uint8 public state;
    uint8 public livesCount;
    
    struct Enemy{
        address addr;
        int powerAttack;    
    }



    Enemy public enemy;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

        livesCount = 5;
    }

    function getPowerProtected() virtual view public returns(int){
        tvm.accept();
        return powerProtected;
    }

    function takeAttack(address addr, int powerAttack) virtual public override{
        tvm.accept();
        
        powerProtected = powerAttack - powerProtected;
        if(powerProtected <= 0 ) {
            sendBooty(addr);
        }
    }

    function checkLiveObject() private returns(bool){
        bool res;
        if(msg.value > 0) res = true;
            else res = false;
    }

    function sendBooty(address addr) private {
        tvm.accept();
        addr.transfer(1, true, 160);
    }

    function clearAddressEnemy() private{
        tvm.accept();
        delete enemy;
    }                       
    
}