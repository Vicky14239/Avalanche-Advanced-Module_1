// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ERC20 {
    // Total supply of the token
    uint public totalSupply;
    // Mapping from account addresses to their balances
    mapping(address => uint) public balanceOf;
    // Mapping from owner addresses to spender addresses to allowance amount
    mapping(address => mapping(address => uint)) public allowance;
    // Token name
    string public name = "ARYAN";
    // Token symbol
    string public symbol = "AR";
    // Number of decimals the token uses
    uint8 public decimals = 18;

    // Event emitted when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint value);
    // Event emitted when an approval is made
    event Approval(address indexed owner, address indexed spender, uint value);

    // Transfer tokens to a specified address
    function transfer(address recipient, uint amount) external returns (bool) {
        // Ensure the recipient is not the zero address
        require(recipient != address(0), "ERC20: transfer to the zero address");
        // Ensure the sender has enough balance
        require(balanceOf[msg.sender] >= amount, "ERC20: transfer amount exceeds balance");

        // Subtract the amount from the sender's balance
        balanceOf[msg.sender] -= amount;
        // Add the amount to the recipient's balance
        balanceOf[recipient] += amount;
        // Emit the Transfer event
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Approve a spender to transfer up to a specified amount
    function approve(address spender, uint amount) external returns (bool) {
        // Ensure the spender is not the zero address
        require(spender != address(0), "ERC20: approve to the zero address");

        // Set the allowance for the spender
        allowance[msg.sender][spender] = amount;
        // Emit the Approval event
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Transfer tokens from a specified address to another address
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        // Ensure the sender and recipient are not the zero address
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        // Ensure the sender has enough balance
        require(balanceOf[sender] >= amount, "ERC20: transfer amount exceeds balance");
        // Ensure the caller has enough allowance
        require(allowance[sender][msg.sender] >= amount, "ERC20: transfer amount exceeds allowance");

        // Subtract the amount from the allowance
        allowance[sender][msg.sender] -= amount;
        // Subtract the amount from the sender's balance
        balanceOf[sender] -= amount;
        // Add the amount to the recipient's balance
        balanceOf[recipient] += amount;
        // Emit the Transfer event
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // Mint new tokens and assign them to the caller
    function mint(uint amount) external {
        // Ensure the amount to mint is greater than zero
        require(amount > 0, "ERC20: mint amount not greater than zero");

        // Add the amount to the caller's balance
        balanceOf[msg.sender] += amount;
        // Increase the total supply
        totalSupply += amount;
        // Emit the Transfer event from the zero address
        emit Transfer(address(0), msg.sender, amount);
    }

    // Burn tokens from the caller's balance
    function burn(uint amount) external {
        // Ensure the caller has enough balance
        require(balanceOf[msg.sender] >= amount, "ERC20: burn amount exceeds balance");

        // Subtract the amount from the caller's balance
        balanceOf[msg.sender] -= amount;
        // Decrease the total supply
        totalSupply -= amount;
        // Emit the Transfer event to the zero address
        emit Transfer(msg.sender, address(0), amount);
    }
}
