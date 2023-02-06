// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ReentrancyGuard} from "solmate/utils/ReentrancyGuard.sol";
import {IERC20} from "./interfaces/IERC20.sol";


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
/// @dev Note: we add "nonReentrant" to all functions that modify state, out of an abundance of
/// caustion for our users. This is not strictly necessary, but it is a good practice.
/// TODO: add EIP-2612 permit to createTrustline, and EIP-712 to all other functions
contract Trustline is ReentrancyGuard {
    /// @dev This makes it easier to distinguish between user addresses and token addresses
    type Token is address;

    /// @notice A Trustline withdrawal has this amount of time to be acknowledged by the other party
    /// otherwise the withdrawal can be cancelled by the initiator
    uint256 public constant WITHDRAWAL_TIMEOUT = 7 days;

    /// @notice A mapping of unidirectional trustlines for each token and pair of user addresses
    /// (i.e. trustlines[0xalice][0xbob] is the amount of token that 0xalice has deposited into
    /// the contract and 0xbob can withdraw)
    mapping(Token => mapping(address => mapping(address => uint256))) public trustlines;


    function createTrustline(address to, Token token, uint256 tokenAmount) nonReentrant public {
        bool suppliedToken = Token.unwrap(token) != address(0) || tokenAmount != 0;
        bool suppliedEther = msg.value != 0;
        if (tokenAmount == 0) {
            revert MissingTokenAmount();
        }

        // note, this approach to calculating the amount in ensures we handle fee
        // on transfer tokens correctly
        uint256 beforeBalance = IERC20(Token.unwrap(token)).balanceOf(address(this));
        IERC20(Token.unwrap(token)).transferFrom(msg.sender, address(this), tokenAmount);
        uint256 afterBalance = IERC20(Token.unwrap(token)).balanceOf(address(this));

        trustlines[token][msg.sender][to] += (afterBalance - before);

        emit TrustlineCreated(msg.sender, to, token, tokenAmount);
    }

    function initiateTrustlineWithdrawal(address withdrawer, address supplier, Token token, uint256 amount) nonReentrant public {
        // emit an event that the withdrawal has been initiated and the other party
        // can acknowledge and complete the withdrawal
    }

    function cancelTrustlineWithdrawal() nonReentrant public {
        // Cancel a trustline withdrawal
    }

    function completeTrustlineWithdrawal() nonReentrant public {
        // Complete a withdrawal, called by the other party of a
        // trustline that has previously initiated a withdrawal
        // on the same trustline
    }

    event TrustlineCreated(address, address, Token, uint256);

    error MissingTokenAmount();
}
