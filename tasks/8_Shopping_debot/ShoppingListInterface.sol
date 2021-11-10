pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

struct Product {
        uint32 id;
        string name;
        uint32 sum;
        uint64 createdAt;
        bool isPaid;
        uint32 price;
    }

    struct Stat {
        uint32 amountPaid;
        uint32 amountNotPaid;
        uint32 amountPrice;
    }

interface ShoppingListInterface {
   function addProduct(string name, uint32 sum) external;
   function buyProduct(uint32 id, uint32 price) external;
   function deleteProduct(uint32 id) external;
   function getProducts() external returns (Product[] products);
   function getStat() external returns (Stat);
}