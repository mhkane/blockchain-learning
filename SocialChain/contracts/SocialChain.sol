pragma ^0.4.4;

contract SocialChain {
    address SocialChainAdmin;
    mapping(bytes32 => notarizedImage) notarizedImages; // allows notarizedImage search by SHA256notaryHash
    bytes32[] imagesByNotaryHash; // directory of images by SHA256notaryHash
    mapping(address => User) Users; // allows User search by Ethereum address
    address[] usersByAddress; // directory of Users by Ethereum adderss

    struct notarizedImage {
        string imageURL;
        uint timeStamp;
    }

    struct User {
        string handle;
        bytes32 city;
        bytes32 state;
        bytes32 country;
        byrtes32[] myImages;
    }

    function registerNewUser(string handle, bytes32 city, bytes32 state, bytes32 country) returns (bool) {
        address newAddress = msg.sender;
        // protect information of existing Users; prevent null handles
        if (bytes(Users[msg.sender].handle).length == 0 && bytes(handle).length != 0) {
            Users[newAddress].handle = handle;
            Users[newAddress].city = city;
            Users[newAddress].state = state;
            Users[newAddress].country = country;
            usersByAddress.push(newAddress);
            return true;
        }
        return false;
    }
}
