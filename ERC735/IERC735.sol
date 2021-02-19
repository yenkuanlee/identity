pragma solidity >=0.4.21 <0.7.0;

interface ERC734 {

    event ClaimAdded(bytes32 indexed claimId, uint256 indexed claimType, uint256 scheme, address indexed issuer, bytes signature, bytes data, string uri);
    event ClaimRemoved(bytes32 indexed claimId, uint256 indexed claimType, uint256 scheme, address indexed issuer, bytes signature, bytes data, string uri);

    struct Claim {
        uint256 claimType;
        address issuer; // msg.sender
        uint256 signatureType; // The type of signature
        bytes signature; // this.address + claimType + claim
        bytes claim;
        string uri;
    }

    function addClaim(uint256 _claimType,address _issuer,uint256 _signatureType,bytes memory _signature,bytes memory _claim,string memory _uri) external;

    function removeClaim(bytes32 _claimId) external returns (bool success);
}
