
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilitaryUnit.sol";

 contract Warrior is MilitaryUnit {

    constructor(int _powerAttack, int _powerProtected) public {
        tvm.accept();
        powerAttack = _powerAttack;
        powerProtected = _powerProtected;
    }

}