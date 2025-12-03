pragma solidity >=0.5.0 <0.6.0;

contract KittyInterface{
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
);
}


contract ZombieFactory{
    uint dnaDigit = 16;
    uint dnaModulus = 10 ** dnaDigit;

    event NewZombie(uint zombieId, uint dna, string name);

    struct Zombie{
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

// internal is the same as private, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).
//
//external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract. We'll talk about why you might want to use external vs public later.

    function _createZombie(string _name, uint _dna) internal  {  
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender; // In Solidity, there are certain global variables that are available to all functions. One of these is msg.sender, which refers to the address of the person (or smart contract) who called the current function.
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id,_dna,_name);
    }

    function _generateRandomDna(string _str) private view returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str))) ;
        return rand % dnaModulus ;
    }

    function createRandomZombie(string _name) public{
        require(ownerZombieCount[msg.sender] == 0); // require to make sure this function only gets executed one time per user, when they create their first zombie.
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    } 
}

