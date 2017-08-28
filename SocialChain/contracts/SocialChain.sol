pragma solidity ^0.4.4;

contract SocialChain {
    address SocialChainAdmin;
    mapping(bytes32 => notarizedImage) notarizedImages; // allows notarizedImage search by SHA256NotaryHash
    bytes32[] imagesByNotaryHash; // directory of images by SHA256NotaryHash
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
        bytes32[] myImages;
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

    function addImageToUser(string imageURL, bytes32 SHA256NotaryHash) returns (bool) {
        address newAddress = msg.sender;
        if (bytes(Users[newAddress].handle).length != 0) {
            if (bytes(imageURL).length != 0) {
                if (bytes(notarizedImages[SHA256NotaryHash].imageURL).length == 0) {
                    imagesByNotaryHash.push(SHA256NotaryHash);
                }
                notarizedImages[SHA256NotaryHash].imageURL = imageURL;
                notarizedImages[SHA256NotaryHash].timeStamp = block.timestamp;
                Users[newAddress].myImages.push(SHA256NotaryHash);
                return true;
            } else {
                return false;
            }
            return true;
        } else {
            return false;
        }
    }

    function getUsers() constant returns (address[]) {
        return usersByAddress;
    }

    function getUser(address userAddress) constant returns (string,bytes32,bytes32,bytes32,bytes32[]) {
        return (Users[userAddress].handle,Users[userAddress].city,Users[userAddress].state,Users[userAddress].country,Users[userAddress].myImages);
    }

    function getAllImages() constant returns (bytes32[]) {
        return imagesByNotaryHash;
    }

    function getUserImages(address userAddress) constant returns (bytes32[]) {
        return Users[userAddress].myImages;
    }

    function getImage(bytes32 SHA256notaryHash) constant returns (string,uint) {
        return (notarizedImages[SHA256notaryHash].imageURL,notarizedImages[SHA256notaryHash].timeStamp);
    }
}
