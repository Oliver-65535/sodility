
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

// 0:0a44196e7758d68efae43fa069ed73bf3a69b00d672084c2ec13af36cadc3f4a
// 0:9a47397d167979ac9b06516f71e437497d78fa4e08a86e00381b5de9c42c7c3d



// 0:53d6bdbc4c0f26413fa3b4021d0f616ed421d57ae94f78be3bac65bdcba0c14e
// 0:4f40de9ff4d91daf5ca4a453fd24a91fcb1529aa5f5723e99b016ca17c7008f2
