
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Define the interface for the ERC20 token standard
interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    // Events that the ERC20 token contract should emit
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

// Define the Vault contract that will interact with the ERC20 token
contract Vault {
    // The token that this vault will interact with
    IERC20 public immutable token;

    // The total supply of shares in the vault
    uint public totalSupply;
    // Mapping from addresses to their share balances in the vault
    mapping(address => uint) public balanceOf;

    // Constructor to set the token this vault will use
    constructor(address _token) {
        token = IERC20(_token);
    }

    // Internal function to mint new shares to an address
    function _mint(address _to, uint _shares) private {
        totalSupply += _shares;
        balanceOf[_to] += _shares;
    }

    // Internal function to burn shares from an address
    function _burn(address _from, uint _shares) private {
        totalSupply -= _shares;
        balanceOf[_from] -= _shares;
    }

    // Function to deposit tokens into the vault and receive shares
    function deposit(uint _amount) external {
        /*
        a = amount to deposit
        B = balance of token in the vault before deposit
        T = total supply of shares
        s = shares to mint

        (T + s) / T = (a + B) / B 

        s = aT / B
        */
        uint shares;
        if (totalSupply == 0) {
            shares = _amount; // Initial deposit, 1:1 ratio
        } else {
            shares = (_amount * totalSupply) / token.balanceOf(address(this));
        }

        // Mint the calculated number of shares to the depositor
        _mint(msg.sender, shares);
        // Transfer the deposited tokens from the depositor to the vault
        token.transferFrom(msg.sender, address(this), _amount);
    }

    // Function to withdraw tokens from the vault by burning shares
    function withdraw(uint _shares) external {
        /*
        a = amount to withdraw
        B = balance of token in the vault before withdrawal
        T = total supply of shares
        s = shares to burn

        (T - s) / T = (B - a) / B 

        a = sB / T
        */
        uint amount = (_shares * token.balanceOf(address(this))) / totalSupply;
        // Burn the shares from the withdrawer's balance
        _burn(msg.sender, _shares);
        // Transfer the calculated amount of tokens from the vault to the withdrawer
        token.transfer(msg.sender, amount);
    }
}
