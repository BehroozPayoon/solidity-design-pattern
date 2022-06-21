//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract BallotStorage {
    address private immutable owner;
    address private latestVersion;
    mapping(bytes32 => uint256) ballotVotesMapping;
    mapping(bytes32 => bool) userVotedMapping;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyLatestVersion() {
        require(msg.sender == latestVersion);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setLatestVersion(address _newVersion) external onlyOwner {
        latestVersion = _newVersion;
    }

    function getBallotVote(bytes32 ballot) external view returns (uint) {
        return ballotVotesMapping[ballot];
    }

    function setBallotVote(bytes32 ballot, uint256 votes)
        external
        onlyLatestVersion
    {
        ballotVotesMapping[ballot] = votes;
    }

    function getUserVoted(bytes32 key) external view returns (bool) {
        return userVotedMapping[key];
    }

    function setUserVoted(bytes32 key, bool value) external onlyLatestVersion {
        userVotedMapping[key] = value;
    }
}
