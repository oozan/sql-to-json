CREATE TYPE product_category AS ENUM ('Electronics', 'Furniture', 'Clothing');

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0),
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    preferences JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    category product_category NOT NULL,
    price DECIMAL(10, 2) CHECK (price >= 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    metadata JSONB DEFAULT '{}'::JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    total_price DECIMAL(10, 2) CHECK (total_price >= 0),
    status VARCHAR(20) DEFAULT 'Pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0),
    price DECIMAL(10, 2) CHECK (price >= 0)
);

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, age, email, password_hash, preferences) VALUES
    ('Alice', 30, 'alice@example.com', 'hash1', '{"theme": "dark", "notifications": true}'::JSONB),
    ('Bob', 25, 'bob@example.com', 'hash2', '{"theme": "light", "notifications": false}'::JSONB),
    ('Charlie', 35, 'charlie@example.com', 'hash3', '{"theme": "dark", "notifications": true}'::JSONB);

INSERT INTO products (name, category, price, stock, metadata) VALUES
    ('Laptop', 'Electronics', 1000.00, 10, '{"brand": "TechCo", "warranty": "2 years"}'::JSONB),
    ('Phone', 'Electronics', 500.00, 25, '{"brand": "MobileCorp", "warranty": "1 year"}'::JSONB),
    ('Tablet', 'Electronics', 300.00, 15, '{"brand": "TechCo", "warranty": "1 year"}'::JSONB),
    ('Chair', 'Furniture', 100.00, 20, '{"material": "wood", "color": "brown"}'::JSONB);

INSERT INTO customers (name, email, phone, address) VALUES
    ('Alice', 'alice@example.com', '123-456-7890', '123 Wonderland St, Helsinki'),
    ('Bob', 'bob@example.com', '987-654-3210', '456 Nowhere Ave, Espoo');

INSERT INTO orders (user_id, total_price, status) VALUES
    (1, 2300.00, 'Completed'),
    (2, 2500.00, 'Pending');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
    (1, 1, 2, 2000.00),
    (1, 3, 1, 300.00),
    (2, 2, 5, 2500.00);

INSERT INTO reviews (user_id, product_id, rating, review_text) VALUES
    (1, 1, 5, 'Excellent laptop, very fast and reliable.'),
    (2, 2, 4, 'Good phone but battery life could be better.'),
    (1, 3, 3, 'Decent tablet for the price.');
