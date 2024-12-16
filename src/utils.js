const fs = require("fs");

function saveJSON(fileName, data) {
  try {
    fs.writeFileSync(fileName, JSON.stringify(data, null, 2));
    console.log(`Data saved to ${fileName}`);
  } catch (err) {
    console.error("Error saving data to file:", err.message);
  }
}

module.exports = { saveJSON };
