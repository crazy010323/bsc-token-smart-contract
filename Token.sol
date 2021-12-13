// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

contract Token {
    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowance;
    uint public totalSupply = 10000 * (10 ** 18);
    string public name = "My First BNB Token";
    string public symbol = "TKN";
    uint public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }

    function transfer(address to, uint amount) public returns(bool) {
        require(balanceOf(msg.sender) >= amount, "Insufficient funds to transfer");
        balances[to] += amount;
        balances[msg.sender] -= amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address owner, address spender, uint amount) public returns(bool) {
        require(balances[owner] >= amount, "Insufficient funds to transfer");
        require(allowance[owner][spender] >= amount, "Not allowed to spend that much!!!");
        balances[owner] -= amount;
        balances[spender] += amount;
        // allowance[owner][spender] -= amount;
        emit Transfer(owner, spender, amount);
        return true;
    }

    function approve(address spender, uint amount) public returns(bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
}

