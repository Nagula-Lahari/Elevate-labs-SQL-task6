-- Create database tables
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data
INSERT INTO departments VALUES 
(1, 'Sales'),
(2, 'Marketing'),
(3, 'IT'),
(4, 'Finance');

INSERT INTO employees VALUES
(1, 'John', 'Doe', 60000.00, 1),
(2, 'Jane', 'Smith', 75000.00, 1),
(3, 'Mike', 'Johnson', 80000.00, 2),
(4, 'Sarah', 'Williams', 90000.00, 3),
(5, 'David', 'Brown', 65000.00, 3),
(6, 'Emily', 'Davis', 70000.00, 4);

INSERT INTO products VALUES
(101, 'Laptop', 1200.00),
(102, 'Smartphone', 800.00),
(103, 'Tablet', 500.00),
(104, 'Monitor', 300.00),
(105, 'Keyboard', 100.00);

INSERT INTO customers VALUES
(1001, 'ABC Corporation'),
(1002, 'XYZ Ltd'),
(1003, 'Acme Inc');

INSERT INTO orders VALUES
(5001, 1001, '2023-01-15'),
(5002, 1001, '2023-02-20'),
(5003, 1002, '2023-01-10'),
(5004, 1003, '2023-03-05');

INSERT INTO order_details VALUES
(1, 5001, 101, 2),
(2, 5001, 102, 1),
(3, 5002, 103, 5),
(4, 5003, 101, 1),
(5, 5003, 104, 3),
(6, 5004, 105, 10),
(7, 5004, 102, 2);

-- 1. Scalar subquery in SELECT
SELECT 
    employee_id,
    first_name,
    last_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS avg_salary,
    salary - (SELECT AVG(salary) FROM employees) AS difference_from_avg
FROM employees;

-- 2. Subquery in WHERE with IN
SELECT product_name, unit_price
FROM products
WHERE product_id IN (
    SELECT product_id 
    FROM order_details 
    WHERE quantity > 3
);

-- 3. Correlated subquery
SELECT e.employee_id, e.first_name, e.last_name, e.department_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- 4. Subquery with EXISTS
SELECT c.customer_id, c.company_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.order_date > '2023-01-01'
);

-- 5. Subquery in FROM clause (derived table)
SELECT d.department_name, emp_count.employee_count
FROM departments d
JOIN (
    SELECT department_id, COUNT(*) AS employee_count
    FROM employees
    GROUP BY department_id
) emp_count ON d.department_id = emp_count.department_id;

-- 6. Subquery with comparison operators
SELECT product_name, unit_price
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM products
);