const { Client } = require("pg");
const { dbConfig } = require("./config");

// Create a PostgreSQL client
const client = new Client(dbConfig);

async function connect() {
  try {
    await client.connect();
    console.log("Connected to the database.");
  } catch (err) {
    console.error("Error connecting to the database:", err.message);
    throw err;
  }
}

async function fetchTableNames() {
  try {
    const res = await client.query(
      `SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'`
    );
    return res.rows.map((row) => row.table_name);
  } catch (err) {
    console.error("Error fetching table names:", err.message);
    throw err;
  }
}

async function fetchData(table, limit = null) {
  try {
    const query = limit
      ? `SELECT * FROM ${table} LIMIT $1`
      : `SELECT * FROM ${table}`;
    const params = limit ? [limit] : [];
    const res = await client.query(query, params);
    return res.rows;
  } catch (err) {
    console.error(`Error fetching data from table "${table}":`, err.message);
    throw err;
  }
}

async function closeConnection() {
  try {
    await client.end();
    console.log("Database connection closed.");
  } catch (err) {
    console.error("Error closing the database connection:", err.message);
  }
}

module.exports = { connect, fetchTableNames, fetchData, closeConnection };
