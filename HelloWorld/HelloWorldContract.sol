pragma solidity ^0.4.0;

contract HelloWorldContract {

    string greeting = "Hello World";
    address public issuer;

    function HelloWorldContract() {
        issuer = msg.sender;
    }

    modifier ifIssuer() {
        if (issuer != msg.sender) {
            throw;
        }
        _;
    }

    function getGreeting() constant returns(string) {
        return greeting;
    }

    function setGreeting(string newGreeting) ifIssuer {
        greeting = newGreeting;
    }
}
