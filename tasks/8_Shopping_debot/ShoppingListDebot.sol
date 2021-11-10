pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "lib/Debot.sol";
import "lib/Terminal.sol";
import "lib/Menu.sol";
import "lib/AddressInput.sol";
import "lib/ConfirmInput.sol";
import "lib/Upgradable.sol";
import "lib/Sdk.sol";

import "ShoppingListInterface.sol";
import "TransactableInterface.sol";

abstract contract AShoppingList {
   constructor(uint256 pubkey) public {}
}


abstract contract ShoppingListDebot is Debot, Upgradable {
    bytes m_icon;

    TvmCell m_ShoppingListCode; // contract code
    address m_address;  // contract address
    Stat m_stat;        // Statistics
    uint32 m_productId;    // Product id
    string m_name;
    uint32 m_price;
    uint256 m_masterPubKey; // User pubkey
    address m_msigAddress;  // User wallet address

    uint32 INITIAL_BALANCE =  200000000;  // Initial contract balance


    function setShoppingListCode(TvmCell code) public {
        require(msg.pubkey() == tvm.pubkey(), 101);
        tvm.accept();
        m_ShoppingListCode = code;
    }

    /// @notice Returns Metadata about DeBot.
    function getDebotInfo() public functionID(0xDEB) override view returns(
        string name, string version, string publisher, string key, string author,
        address support, string hello, string language, string dabi, bytes icon
    ) {
        name = "Shopping list DeBot";
        version = "0.1.0";
        publisher = "Oleg Tarasov";
        key = "Shopping list manager";
        author = "Oleg Tarasov";
        support = address.makeAddrStd(0, 0x915976c216f71540ff43e23dd131239bdfe1df42f98a2c7adc3bc4741a349d0f);
        hello = "Hi, i'm a Shopping list DeBot.";
        language = "en";
        dabi = m_debotAbi.get();
        icon = m_icon;
    }

    function getRequiredInterfaces() public view override returns (uint256[] interfaces) {
        return [ Terminal.ID, Menu.ID, AddressInput.ID, ConfirmInput.ID ];
    }
    
    function start() public override {
        Terminal.input(tvm.functionId(setPublicKey),"Please enter your public key",false);
    }
    
    function onSuccess() public view {
        getStat(tvm.functionId(showStat));
    }
    
    function onError(uint32 sdkError, uint32 exitCode) public {
        Terminal.print(0, format("Operation failed. sdkError {}, exitCode {}", sdkError, exitCode));
        menu();
    }


    function setPublicKey(string value) public {
        (uint res, bool status) = stoi("0x"+value);
        if (status) {
            m_masterPubKey = res;

            Terminal.print(0, "Checking exist shopping list ...");
            TvmCell deployState = tvm.insertPubkey(m_ShoppingListCode, m_masterPubKey);
            m_address = address.makeAddrStd(0, tvm.hash(deployState));
            Terminal.print(0, format( "Your contract address- {}", m_address));
            Sdk.getAccountType(tvm.functionId(checkAccountStatus), m_address);

        } else {
            Terminal.input(tvm.functionId(setPublicKey),"Error. Try again public key",false);
        }
    }


    function checkAccountStatus(int8 acc_type) public {
        if (acc_type == 1) { // acc is active and  contract is already deployed
            getStat(tvm.functionId(showStat));

        } else if (acc_type == -1)  { // acc is inactive
            Terminal.print(0, "Deploy...");
            AddressInput.get(tvm.functionId(creditAccount),"Select a wallet for payment");
        
        } else  if (acc_type == 0) { // acc is uninitialized
            Terminal.print(0, format("Deploying new contract"));
            deploy();
        
        } else if (acc_type == 2) {  // acc is frozen
            Terminal.print(0, format(" Account {} is frozen", m_address));
        }
    }


    function creditAccount(address value) public {
        m_msigAddress = value;
        optional(uint256) pubkey = 0;
        TvmCell empty;
        TransactableInterface(m_msigAddress).sendTransaction{
            abiVer: 2,
            extMsg: true,
            sign: true,
            pubkey: pubkey,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(waitBeforeDeploy),
            onErrorId: tvm.functionId(onErrorRepeatCredit)  // Just repeat if something went wrong
        }(m_address, INITIAL_BALANCE, false, 3, empty);
    }

    function onErrorRepeatCredit(uint32 sdkError, uint32 exitCode) public {
        sdkError;
        exitCode;
        creditAccount(m_msigAddress);
    }


    function waitBeforeDeploy() public  {
        Sdk.getAccountType(tvm.functionId(checkLoadAccount), m_address);
    }

    function checkLoadAccount(int8 acc_type) public {
        if (acc_type ==  0) {
            deploy();
        } else {
            waitBeforeDeploy();
        }
    }


    function deploy() private view {
            TvmCell image = tvm.insertPubkey(m_ShoppingListCode, m_masterPubKey);
            optional(uint256) none;
            TvmCell deployMsg = tvm.buildExtMsg({
                abiVer: 2,
                dest: m_address,
                callbackId: tvm.functionId(onSuccess),
                onErrorId:  tvm.functionId(waitDeploy),    // Just repeat if something went wrong
                time: 0,
                expire: 0,
                sign: true,
                pubkey: none,
                stateInit: image,
                call: {AShoppingList, m_masterPubKey}
            });
            tvm.sendrawmsg(deployMsg, 1);
    }


    function waitDeploy(uint32 sdkError, uint32 exitCode) public view {
        sdkError;
        exitCode;
        deploy();
    }

    function showStat(Stat stat) public {
        m_stat = stat;
        menu();
    }

    function menu() virtual public {
     string sep = '----------------------------------------';
         Menu.select(
             format(
                 "You have: Paid - {}| notPaid- {} | Full price-{}",
                     m_stat.amountPaid,
                     m_stat.amountNotPaid,
                     m_stat.amountPrice
             ),
             sep,
             [
                 //MenuItem("Add product","",tvm.functionId(addProduct)),
                 MenuItem("Show product list","",tvm.functionId(showProducts)),
                 //MenuItem("Buy product","",tvm.functionId(buyProduct)),
                 MenuItem("Delete product","",tvm.functionId(deleteProduct))
             ]
         );
     }

    

    function showProducts(uint32 index) public view {
        index = index;
        optional(uint256) none;
        ShoppingListInterface(m_address).getProducts{
            abiVer: 2,
            extMsg: true,
            sign: false,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(showProducts_),
            onErrorId: 0
        }();
    }

    function showProducts_( Product[] products ) public {
        uint32 i;
        if (products.length > 0 ) {
            Terminal.print(0, "Your shopping list:");
            for (i = 0; i < products.length; i++) {
                Product product = products[i];
                string paid;
                if (product.isPaid) {
                    paid = '✓';
                } else {
                    paid = ' ';
                }
                Terminal.print(0, format("{} | {} | name:{} | amount:{} |  price:{}", product.id, paid, product.name, product.sum, product.price));
            }
        } else {
            Terminal.print(0, "Your shopping list is empty");
        }
        menu();
    }

    


    function deleteProduct(uint32 index) public {
        index = index;
        if (m_stat.amountPaid + m_stat.amountNotPaid > 0) {
            Terminal.input(tvm.functionId(deleteProduct_), "Enter product id:", false);
        } else {
            Terminal.print(0, "Your shopping list is empty");
            menu();
        }
    }

    function deleteProduct_(string value) public view {
        (uint256 num,) = stoi(value);
        optional(uint256) pubkey = 0;
        ShoppingListInterface(m_address).deleteProduct{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(uint32(num));
    }

    function getStat(uint32 answerId) private view {
        optional(uint256) none;
        ShoppingListInterface(m_address).getStat{
            abiVer: 2,
            extMsg: true,
            sign: false,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: answerId,
            onErrorId: 0
        }();
    }

    function onCodeUpgrade() internal override {
        tvm.resetStorage();
    }
}
