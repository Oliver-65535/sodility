pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "ShoppingListDebot.sol";

contract FillShoppingListDebot is ShoppingListDebot {
    
    
    function menu() virtual public override {
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
                MenuItem("Add product","",tvm.functionId(addProduct)),
                MenuItem("Show product list","",tvm.functionId(showProducts)),
                //MenuItem("Buy product","",tvm.functionId(buyProduct)),
                MenuItem("Delete product","",tvm.functionId(deleteProduct))
            ]
        );
    }

    function addProduct(uint32 index) public {
        index = index;
        Terminal.input(tvm.functionId(addProductName), "Enter product name :", false);
    }
    
    function addProductName(string value) public {
        m_name = string(value);
        Terminal.input(tvm.functionId(addProductAmount), "Enter product amount :", false);
    }

    function addProductAmount(string value) public view {
        (uint256 num,) = stoi(value);
        uint32 amount = uint32(num);
        optional(uint256) pubkey = 0;
        ShoppingListInterface(m_address).addProduct{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(m_name, amount);
    }

}