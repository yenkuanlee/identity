pragma solidity >=0.4.21 <0.7.0;
contract ERC735Claim {
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
    

    mapping (bytes32 => Claim) claims;
    mapping (uint256 => bytes32[]) claimsByType;
    
    
    function getClaim(
            bytes32 _claimId
        )
        external
        view
        returns
                (uint256 claimType,
                address issuer,
                uint256 signatureType,
                bytes memory signature,
                bytes memory claim,
                string memory uri)
        {
            Claim memory _claim = claims[_claimId];
            return (_claim.claimType, _claim.issuer, _claim.signatureType, _claim.signature, _claim.claim, _claim.uri);
        }

    function getClaimsIdByType(uint256 _claimType) external view returns(bytes32 [] memory) {
            return claimsByType[_claimType];
    }

    function addClaim(
            uint256 _claimType,
            uint256 _signatureType,
            address _issuer,
            bytes memory _signature,
            bytes memory _claim,
            string memory _uri
        )
            public
            returns (bytes32 claimId)
        {
            claimId = keccak256(abi.encodePacked(_issuer, _claimType));
            claims[claimId] = Claim(
                {
                    claimType: _claimType,
                    issuer: _issuer,
                    signatureType: _signatureType,
                    signature: _signature,
                    claim: _claim,
                    uri: _uri
                }
            );
            claimsByType[_claimType].push(claimId);
            emit ClaimAdded(claimId, _claimType, _signatureType, _issuer, _signature, _claim, _uri);
        }

    function removeClaim(bytes32 _claimId) external returns (bool success) {
        bytes32[] storage keysCache = claimsByType[claims[_claimId].claimType];
        for (uint i = 0; i < keysCache.length; i++) {
            if (keysCache[i] == _claimId) {
                keysCache[i] = keysCache[keysCache.length - 1];
                delete keysCache[keysCache.length - 1];
                // keysCache.length--;
                break;
            }
        }
        delete claims[_claimId];
        emit ClaimRemoved(_claimId, claims[_claimId].claimType, claims[_claimId].signatureType, claims[_claimId].issuer, claims[_claimId].signature, claims[_claimId].claim, claims[_claimId].uri);
        return true;
    }
}