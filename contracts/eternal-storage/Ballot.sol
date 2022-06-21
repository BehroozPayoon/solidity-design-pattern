//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./BallotStorage.sol";

library ballotLib {
    function getNumberOfVotes(address _ballotStorage, bytes32 ballot)
        public
        view
        returns (uint256)
    {
        return BallotStorage(_ballotStorage).getBallotVote(ballot);
    }

    function setNumberOfVotes(
        address _ballotStorage,
        bytes32 ballot,
        uint256 votes
    ) external {
        BallotStorage(_ballotStorage).setBallotVote(ballot, votes);
    }
}

contract Ballot {
    using ballotLib for address;
    address private immutable ballotStorage;

    constructor(address _ballotStorage) {
        ballotStorage = _ballotStorage;
    }

    function getNumberOfVotes(bytes32 ballot) external view returns (uint256) {
        return ballotStorage.getNumberOfVotes(ballot);
    }

    function vote(bytes32 ballot, uint256 votes) external {
        ballotStorage.setNumberOfVotes(ballot, votes);
    }
}
