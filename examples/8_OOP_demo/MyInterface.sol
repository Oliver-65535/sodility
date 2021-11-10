
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface MyInterface {
    function myPublicFunction(uint value) external;
    //function myPrivateFunction(uint value) private;
    function myExternalFunction(uint value) external;
    //function myInternalFunction(uint value) internal; 
}
