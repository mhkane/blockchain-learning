pragma solidity ^0.4.0;

contract HelloWorldContract {
    string greeting = "Hello World";
  
    function getGreeting() constant returns(string) {
        return greeting;
    }

    function setGreeting(string newGreeting) {
        greeting = newGreeting;
    }
}
