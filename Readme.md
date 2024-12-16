# SQL-to-JSON

Created and maintained by **oozan**

SQL-to-JSON is a Node.js application that interacts with a PostgreSQL database. It allows users to dynamically fetch data from database tables and save it in a JSON format. The application is designed for developers to simplify database data extraction and transformation.

---

## Features

- Connects to a PostgreSQL database using environment variables for secure credentials.
- Dynamically fetches data from tables based on user input.
- Provides an option to fetch data from specific tables or all tables.
- Allows optional row limits when fetching data.
- Saves the fetched data in a structured JSON format.
- Uses a modular architecture for maintainability and scalability.

---

## File Structure

```plaintext
sql-to-json/
├── src/
│   ├── data/
│   │   ├── queries.sql        # SQL file to create tables and insert data
│   ├── cli.js                 # CLI logic
│   ├── database.js            # Database interaction logic
│   ├── utils.js               # Utility functions
│   └── config.js              # Configuration management
├── .env                       # Environment variables
├── docker-compose.yml          # Docker setup for PostgreSQL
├── package.json                # Node.js dependencies and scripts
└── index.js                    # Entry point for the application
```

---

## Prerequisites

1. **Node.js**: Ensure you have Node.js installed.
2. **Docker**: Used for running the PostgreSQL instance via `docker-compose`.
3. **PostgreSQL Client**: Optional for direct database interaction.

---

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/oozan/sql-to-json.git
   cd sql-to-json
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Set up environment variables in `.env`:

   ```plaintext
   DB_HOST=localhost
   DB_PORT=5432
   DB_USER=user
   DB_PASSWORD=yourpassword
   DB_NAME=testdb
   ```

4. Start PostgreSQL using Docker:

   ```bash
   docker-compose up -d
   ```

5. Execute the SQL setup script:

   ```bash
   docker exec -i postgres_container psql -U user -d testdb < src/data/queries.sql
   ```

---

## Usage

1. Run the application:

   ```bash
   npm start
   ```

2. Follow the CLI prompts:

   - **Select Tables**: Type the table names separated by commas or `all` to fetch data from all tables.
   - **Set Limit**: Optionally, type `limit=10` to limit the rows or press Enter for all rows.

3. View the fetched data:
   - The data will be saved in `src/data/data.json`.

---

## Scripts

### `npm start`

Starts the application.

### `npm run dev`

Starts the application with `nodemon` for development (auto-restarts on changes).

### `npm run run-sql`

Executes `queries.sql` to set up the database:

```bash
npm run run-sql
```

---

## Example

### Sample CLI Interaction

```plaintext
Connected to the database.
Available tables: users, orders, products, customers
Which table(s) would you like to get data from? (type 'all' for all tables): users, products
Would you like to limit the results? (e.g., type 'limit=10' or press Enter for all data): limit=5
Fetched data as JSON:
[
  {
    "table": "users",
    "data": [ ... ]
  },
  {
    "table": "products",
    "data": [ ... ]
  }
]
Data successfully saved to src/data/data.json.
```

---

## Environment Variables

| Variable      | Description                         |
| ------------- | ----------------------------------- |
| `DB_HOST`     | Hostname of the PostgreSQL instance |
| `DB_PORT`     | Port number for PostgreSQL          |
| `DB_USER`     | Username for PostgreSQL             |
| `DB_PASSWORD` | Password for PostgreSQL             |
| `DB_NAME`     | Database name                       |

---

## Contributing

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-branch-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add a new feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-branch-name
   ```
5. Open a pull request.

---

## License

This project is licensed under the MIT License.
