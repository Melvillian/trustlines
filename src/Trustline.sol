// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// @title Trustline
/// @author Melvillian
/// @dev THIS CONTRACT IS UNAUDITED AND SHOULD NOT BE USED IN PRODUCTION
/// @notice A Trustline is a smart contract that let's people with strong social relationships
/// access capital from their communities and networks. Individuals who are friends, family, or business
/// can deposit funds into the contract and only allow the other party to withdraw funds.
/// The incentive mechanism is that the other party can only withdraw funds if they
/// first initiate a withdrawal. This means that the other side of the Trustline can
/// be alerted and can stop the withdrawal if they suspect foul play.
/// @notice The goal is to create a trustless trustline that is as secure as a bank, but
/// as simple to setup as a Venmo account. Ideally, a user opens the Trustline frontend
/// and finds they have several thousands of dollars in their account.
contract Trustline {
    /// @notice A mapping of unidirectional trustlines for each token and pair of user addresses
    /// (i.e. trustlines[0xalice][0xbob] is the amount of token that 0xalice has deposited into
    /// the contract and 0xbob can withdraw)
    mapping(address => mapping(address => mapping(address => uint256))) public trustlines;

    type Token is address;

    function createTrustline(Token token) public payable {
        // either user sent in ether, or they set a nonzero token
        bool suppliedToken = Token.unwrap(token) != address(0);
        bool suppliedEther = msg.value != 0;
        if ((suppliedEther && suppliedToken) || (!suppliedEther && !suppliedToken)) {
            revert MustSupplyExactlyOneOfEtherOrToken(msg.value, Token.unwrap(token));
        }

        if (suppliedToken) {
            
        }
    }

    function initiateTrustlineWithdrawal(uint256 amount) public {
        // Withdraw ether from the contract
    }

    function cancelTrustlineWithdrawal() public {
        // Cancel a withdrawal
    }

    function completeTrustlineWithdrawal() public {
        // Complete a withdrawal
    }

    error MustSupplyExactlyOneOfEtherOrToken(uint256 amount, address token);
}
