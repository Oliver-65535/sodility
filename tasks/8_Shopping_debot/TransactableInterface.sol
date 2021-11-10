pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;

interface TransactableInterface {
   function sendTransaction(address dest, uint128 value, bool bounce, uint8 flags, TvmCell payload  ) external;
}