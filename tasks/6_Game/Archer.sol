
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilitaryUnit.sol";

 contract Archer is MilitaryUnit {

    constructor(BaseStationInterface bs, int _powerAttack, int _powerProtected) MilitaryUnit(bs) public {
        tvm.accept();
        bs.addMilitaryUnit(this);
        powerAttack = _powerAttack;
        powerProtected = _powerProtected;
    }

}