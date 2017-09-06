pragma solidity ^0.4.0;

contract CustodialContract {
    address client;
    bool fundsWithdrawn;

    event UpdateStatus(string _msg);
    event UserStatus(string _msg, address _user, uint _amount);

    function CustodialContract() {
        client = msg.sender;
    }

    modifier ifClient() {
        if (client != msg.sender) {
            throw;
        }
        _;
    }

    function depositFunds() payable {
        UserStatus("User has deposited some money", msg.sender, msg.value);
    }

    function withdrawFunds(uint funds) ifClient {
        if (client.send(funds)) {
            UpdateStatus("User has withdrawn some money");
            fundsWithdrawn = true;
        } else {
            fundsWithdrawn = false
        }
    }

    function getBalance() ifClient constant returns(uint) {
        return this.balance;
    }
}
