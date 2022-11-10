# Fetching Offchain data into a Moonbase Alpha Solidity Contract

### Current Solution : Chainlink Node on Moonbase Alpha Testnet

Currently, we have a Chainlink node running on Moonbase Alpha at ```0x7625dAd074438ae964107FE927cbdbCE8c6355c8``` . The Oracle contract is deployed at ```0x5e609E1c258255ef9Ee2022a519aBf5b9Fe1afe2``` . The ANY API job specification that we used to fetch offchain data is

```
{
  "initiators": [
    {
      "type": "runlog",
      "params": { "address": "0x5e609E1c258255ef9Ee2022a519aBf5b9Fe1afe2" }
    }
  ],
  "tasks": [
    { "type": "httpget" },
    { "type": "jsonparse" },
    { "type": "multiply" },
    { "type": "ethuint256" },
    { "type": "ethtx" }
  ]
}
```

