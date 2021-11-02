
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilitaryUnit.sol";

 contract Warrior is MilitaryUnit {

    constructor(BaseStationInterface base, int _powerAttack, int _powerProtected) MilitaryUnit(base) public {
        tvm.accept();
        base.addMilitaryUnit(this);
        powerAttack = _powerAttack;
        powerProtected = _powerProtected;
    }

}