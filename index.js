const { connect, closeConnection } = require("./src/database");
const { promptUser } = require("./src/cli");

(async function main() {
  try {
    await connect();

    await promptUser();
  } catch (err) {
    console.error("An error occurred:", err.message);
  } finally {
    await closeConnection();
  }
})();
