
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface GameObjectInterface{
    function takeAttack(address addressEnemy, int pwr) external;
    //function takeBaseAttack(address addressEnemy, int pwr) external;
    //function addMilitaryUnit(address Address) external;
}