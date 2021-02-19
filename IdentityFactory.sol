pragma solidity >=0.4.21 <0.7.0;

// import "zos-lib/contracts/Initializable.sol";
import "./Identity.sol";


contract IdentityFactory  {

  event IdentityCreated(address indexed identity);

  /**
  * @dev Keep track or identities created with the factory contract
  * This is necessary because there is no way to tell on chain
  * if the identity interface is implemented in a certain way and
  * the Centrifuge Protocol requires on chain key history. A key
  * should be revoked and not removed
  */
  mapping(address => bool) internal _identities;

  /**
  * Deploys a new identity with the provided address as a MANAGEMENT key
  * and the msg.sender as an ACTION key
  * @param manager string address owner of the new identity
  */
  function createIdentityFor(
    address manager
  )
  public
  {
    Identity identity_ = new Identity(manager);
    address identityAddr_ = address(identity_);
    _identities[identityAddr_] = true;
    emit IdentityCreated(address(identityAddr_));
  }

  /**
  * @dev Checks if the given address was created by this factory
  * @param identityAddr address the contract address to check
  */
  function createdIdentity(
    address identityAddr
  )
  external
  view
  returns (bool valid)
  {
    return _identities[identityAddr];
  }
}
