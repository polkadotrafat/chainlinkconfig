pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract Client is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    uint256 public volume;

    /**
    This example uses the LINK token address on Moonbase Alpha.
    Make sure to update the oracle and jobId.
    */
    constructor() {
        setChainlinkToken(address(0xa36085F69e2889c224210F603D836748e7dC0088));
        oracle = 0x5e609E1c258255ef9Ee2022a519aBf5b9Fe1afe2;
        jobId = "cdc698f82bb44716ad4e9a57f10c6357";
        fee = 0;
    }

    /**
     * Create a Chainlink request to retrieve API response, find the target
     * data, then multiply by 1000000000000000000 (to remove decimal places from data).
     */
    function requestVolumeData() public returns (bytes32 requestId) {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);

        // Set the URL to perform the GET request on
        request.add("get", "http://drex-env.eba-jkxuyqbq.us-east-1.elasticbeanstalk.com/grid/last");

        // Set the path to find the desired data in the API response, where the response format is:
        
        request.add("path", "energy-acum");

        // Multiply the result by 1000000000000000000 to remove decimals
        int timesAmount = 10**18;
        request.addInt("times", timesAmount);

        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    /**
     * Receive the response in the form of uint256
     */ 
    function fulfill(bytes32 _requestId, uint256 _volume) public recordChainlinkFulfillment(_requestId)
    {
        volume = _volume;
    }
}
