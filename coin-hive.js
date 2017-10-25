const CoinHive = require("coin-hive");

(async () => {
  const miner = await CoinHive("{SITEKEY}",{ username: "{USERNAME}" },{ threads: "{THREADS}" });
  await miner.start();
  miner.on("found", () => console.log("Found!"));
  miner.on("accepted", () => console.log("Accepted!"));
  miner.on("update", data =>
    console.log(`
    Hashes per second: ${data.hashesPerSecond}
    Total hashes: ${data.totalHashes}
    Accepted hashes: ${data.acceptedHashes}
  `)
  );
})();
