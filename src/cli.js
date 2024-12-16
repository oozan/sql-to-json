const readline = require("readline");
const { fetchTableNames, fetchData } = require("./database");
const { saveJSON } = require("./utils");

function askQuestion(question) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve) =>
    rl.question(question, (answer) => {
      rl.close();
      resolve(answer);
    })
  );
}

async function promptUser() {
  try {
    const tableNames = await fetchTableNames();
    if (tableNames.length === 0) {
      console.log("No tables found in the database.");
      return;
    }

    console.log("Available tables:", tableNames.join(", "));

    // Ask the user which tables to query
    const tableAnswer = await askQuestion(
      "Which table(s) would you like to get data from? (type 'all' for all tables) "
    );

    const selectedTables =
      tableAnswer.toLowerCase() === "all"
        ? tableNames
        : tableAnswer.split(",").map((table) => table.trim());

    // Validate selected tables
    const invalidTables = selectedTables.filter(
      (table) => !tableNames.includes(table)
    );
    if (invalidTables.length > 0) {
      console.log("Invalid table(s):", invalidTables.join(", "));
      return;
    }

    // Ask for limit
    const limitAnswer = await askQuestion(
      "Would you like to limit the results? (e.g., type 'limit=10' or press Enter for all data) "
    );

    const limit = limitAnswer.startsWith("limit=")
      ? parseInt(limitAnswer.split("=")[1], 10)
      : null;

    if (limitAnswer && isNaN(limit)) {
      console.log("Invalid limit value.");
      return;
    }

    // Fetch data
    const results = [];
    for (const table of selectedTables) {
      const data = await fetchData(table, limit);
      results.push({ table, data });
    }

    console.log("Fetched data as JSON:\n", JSON.stringify(results, null, 2));

    // Save data to JSON file
    saveJSON("data.json", results);
    console.log("Data successfully saved to data.json.");
  } catch (err) {
    console.error("Error:", err.message);
  }
}

module.exports = { promptUser };
