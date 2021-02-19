pragma solidity ^0.6.0;

import "./ERC725/ERC725Account.sol";
import "./ERC735/ERC735Claim.sol";

contract Identity is ERC725Account, ERC735Claim {
    address private key_manager_contract;

    constructor(address _newOwner)
    ERC725Account(_newOwner)
    public
    {
    }

    // function addKeyManager(address _address) public onlyManagementKeyOrSelf {
    //     bytes32 key = keccak256(abi.encodePacked(_address));
    //     keys[key].keyType = ECDSA_TYPE;
    //     keys[key].purposes = MANAGEMENT_KEY;
    //     emit KeySet(key, MANAGEMENT_KEY, ECDSA_TYPE);
    // }

    // function removeKeyManager(address _address) public onlyManagementKeyOrSelf {
    //     bytes32 key = keccak256(abi.encodePacked(_address));
    //     removeKey(key);
    // }

    // function keyManagerRegister(bytes32 publickey, bytes32[] memory bxTopic, string memory bxDataHash) external {
    //     KeyManager _key_manager_contract = new KeyManager(publickey, bxTopic, bxDataHash);
    //     key_manager_contract = address(_key_manager_contract);
    // }

    // function getKeyManagerContractAddress () public view returns (address) {
    //     return key_manager_contract;
    // }

}
