pragma solidity >=0.5.0;

import "./zombiefactory.sol" // Solidity uses the import keyword

// Storage refers to variables stored permanently on the blockchain. Memory variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.

contract ZombieFeeding is ZombieFactory{
    function feedAndMultiply(uint _zombieId , uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
    }
}