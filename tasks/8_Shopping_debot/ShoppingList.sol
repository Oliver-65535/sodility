pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;


contract ShoppingList {
    /*
     * ERROR CODES
     * 100 - Unauthorized
     * 102 - task not found
     */

    modifier onlyOwner() {
        require(msg.pubkey() == m_ownerPubkey, 101);
        _;
    }

    uint32 m_count;

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

    mapping(uint32 => Product) m_products;

    uint256 m_ownerPubkey;

    constructor( uint256 pubkey) public {
        require(pubkey != 0, 120);
        tvm.accept();
        m_ownerPubkey = pubkey;
    }

    function addProduct(string name, uint32 sum) public onlyOwner {
        tvm.accept();
        m_count++;
        m_products[m_count] = Product(m_count, name, sum, now, false, 0);
    }

    function buyProduct(uint32 id, uint32 price) public onlyOwner {
        require(m_products.exists(id), 102);
        tvm.accept();
        m_products[id].isPaid = true;
        m_products[id].price = m_products[id].sum * price;
    }

    function deleteProduct(uint32 id) public onlyOwner {
        require(m_products.exists(id), 102);
        tvm.accept();
        delete m_products[id];
    }

    //
    // Get methods
    //

    function getProducts() public view returns (Product[] products) {
    
        for((uint32 id, Product product) : m_products) {
            products.push(Product(product.id, 
                                    product.name, 
                                    product.sum, 
                                    product.createdAt, 
                                    product.isPaid,
                                    product.price));
       }
    }

    function getStat() public view returns (Stat stat) {
        uint32 amountPaid;
        uint32 amountNotPaid;
        uint32 amountPrice;

        for((, Product product) : m_products) {
            if  (product.isPaid) {
                amountPaid += product.sum;
                amountPrice += product.price * product.sum;
            } else {
                amountNotPaid += product.sum;
            }
        }
        stat = Stat( amountPaid, amountNotPaid, amountPrice);
    }
}

