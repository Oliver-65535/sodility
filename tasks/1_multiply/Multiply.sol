pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiply {

	// Переменная в которой хранится результаты выполнения функции
	uint public result = 1;

	constructor() public {
		// проверка на наличие публичного ключа
		require(tvm.pubkey() != 0, 101);
		// проверка что ключ сообщения не пустой
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	// Модификатор проверки ключей
	modifier checkOwnerAndAccept {
		// Проверка ключа сообщения на соответсвие публичному.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	// Функция перемножения веденного значения на хранимое 
	function mul(uint value) public checkOwnerAndAccept {
        require(value > 0 && value < 10, 102);
		result *= value;
	}
}