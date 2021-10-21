pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;



contract MoneyTranfer {
    /*
     Exception codes:
      100 - message sender is not a wallet owner.
      101 - invalid transfer value.
     */
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    uint16 constant TAKE_COMMISION_FROM_SENDER = 1;
    uint16 constant TAKE_COMMISION_FROM_RECIPIENT = 0;
    uint16 constant SEND_ALL_AND_DESTROY_SENDER_ACCOUNT = 160;
    bool constant BOUNCE = true;
    

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    function sendWithComissionFromRecipient(address dest, uint128 nanotons) 
        public pure checkOwnerAndAccept {
            dest.transfer(nanotons, BOUNCE, TAKE_COMMISION_FROM_RECIPIENT);
    }
    function sendWithComissionFromSender(address dest, uint128 nanotons) 
        public pure checkOwnerAndAccept {
            dest.transfer(nanotons, BOUNCE, TAKE_COMMISION_FROM_SENDER);
    }
    function sendAllAndDestroySenderAccount(address dest) 
        public pure checkOwnerAndAccept {
            dest.transfer(1, BOUNCE, SEND_ALL_AND_DESTROY_SENDER_ACCOUNT);
    }
}