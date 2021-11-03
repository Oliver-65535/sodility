
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilitaryUnit.sol";

 contract Archer is MilitaryUnit {

    constructor(int _powerAttack, int _powerProtected) public {
        tvm.accept();
        powerAttack = _powerAttack;
        powerProtected = _powerProtected;
    }

}

//0:5d1dbc66c1f65d65527ec02ccf3634de17e3123161813167eb4e0dcd2004c76f

//0:6fb34f968255256c7662efb70521d775734bb0b0822b00b8351d767ccdfa82b6