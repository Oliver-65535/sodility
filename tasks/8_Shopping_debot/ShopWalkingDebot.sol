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
                //MenuItem("Add product","",tvm.functionId(addProduct)),
                MenuItem("Show product list","",tvm.functionId(showProducts)),
                MenuItem("Buy product","",tvm.functionId(buyProduct)),
                MenuItem("Delete product","",tvm.functionId(deleteProduct))
            ]
        );
    }

    function buyProduct(uint32 index) public {
        index = index;
        if (m_stat.amountPaid + m_stat.amountNotPaid > 0) {
            Terminal.input(tvm.functionId(buyProductId), "Enter product id:", false);
        } else {
            Terminal.print(0, "Your shopping list is empty");
            menu();
        }
    }

    function buyProductId(string value) public {
        (uint256 num,) = stoi(value);
        m_productId = uint32(num);
        Terminal.input(tvm.functionId(buyProductAmount), "Enter product price :", false);
    }

    function buyProductAmount(string value) public {
        (uint256 num,) = stoi(value);
        m_price = uint32(num);
        ConfirmInput.get(tvm.functionId(buyProductConfirm),"You buy this product?");
    }

    
    function buyProductConfirm(bool value) public view {
      if(value){
        optional(uint256) pubkey = 0;
        ShoppingListInterface(m_address).buyProduct{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(m_productId, m_price);
      }  
        
    }

}