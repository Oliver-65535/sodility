

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObjectInterface.sol';

 contract GameObject is GameObjectInterface {
   
    int public powerProtected;
    uint8 livesCount;
    mapping(uint8 => address) public playerAddresses;

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
        powerProtected = powerProtected - powerAttack;
        if(powerProtected <= 0 ) {
            sendBooty(addr);
        }
    }

    //function checkDied(address addr) private returns(bool){
    //    return
    //}

    function sendBooty(address addr) public {
        tvm.accept();
        addr.transfer(1, true, 160);
    }
                     
    
}