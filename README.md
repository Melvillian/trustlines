# 🤝 Trustlines

A Trustline is a smart contract that let's people with strong social relationships access capital from their communities and networks. It uses a smart contract to store and represent the trustlines between addresses, and they can be denominated in any ERC20 token.

A trustline is simply an amount of token that one address makes available to another. Crucially, the funds cannot be withdrawn immediately, but will require offchain coordination to release the funds. In this way, Trustlines leverage the best parts of a blockchain (secure storage of digital assets + openness) and the best parts of human relationships (respect and mutual growth)

Trustlines is a [hyperstructure](https://jacob.energy/hyperstructures.html), we have no way to capture any of its value. All value goes to its users, who we hope will use it to leverage their strong social connections for the betterment of all.

## Setup

`forge build`
`forge test`

## TODO

- [ ] implement functions
    - [ ] initiateTrustlineWithdrawal
    - [ ] cancelTrustlineWithdrawal
    - [ ] completeTrustlineWithdrawal
- [ ] natspec for all above functions, storage vars, events, and errors
- [ ] unit tests for everything
- [ ] fuzz tests for high risk functionality
- [ ] [Halmos](https://github.com/a16z/halmos) for extra assurance
- [ ] [Certora spec](https://docs.certora.com/en/latest/) for extra _extra_ assurance
- [ ] subgraph for offchain indexing
- [ ] OpenZeppelin Defender for automated notifications based on onchain events (i.e. when `initiateTrustlineWithdrawal` gets called)
- [ ] Next.js frontend for interacting with the contract