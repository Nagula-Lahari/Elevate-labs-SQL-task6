
# SQL Subqueries and Nested Queries

This repository demonstrates various types of SQL subqueries and nested queries, created as part of a SQL Developer Internship Task.

## Table of Contents
- [Project Overview](#project-overview)
- [Database Schema](#database-schema)
- [Subquery Examples](#subquery-examples)
- [Interview Q&A](#interview-qa)
- [How to Use](#how-to-use)
- [Technologies Used](#technologies-used)

## Project Overview

This project showcases different implementations of SQL subqueries including:
- Scalar subqueries
- Correlated subqueries
- Subqueries with IN, EXISTS operators
- Derived tables (subqueries in FROM clause)
- Subqueries with comparison operators

## Database Schema

```mermaid
erDiagram
    departments ||--o{ employees : "1-to-many"
    customers ||--o{ orders : "1-to-many"
    orders ||--o{ order_details : "1-to-many"
    products ||--o{ order_details : "1-to-many"
    
    departments {
        int department_id PK
        varchar(50) department_name
    }
    
    employees {
        int employee_id PK
        varchar(50) first_name
        varchar(50) last_name
        decimal(10,2) salary
        int department_id FK
    }
    
    products {
        int product_id PK
        varchar(100) product_name
        decimal(10,2) unit_price
    }
    
    customers {
        int customer_id PK
        varchar(100) company_name
    }
    
    orders {
        int order_id PK
        int customer_id FK
        date order_date
    }
    
    order_details {
        int order_detail_id PK
        int order_id FK
        int product_id FK
        int quantity
    }
```

## Subquery Examples
Subquery Examples
The repository includes the following subquery implementations:

Scalar Subquery in SELECT

sql
SELECT employee_id, first_name, salary,
       (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;
Subquery with IN Operator

sql
SELECT product_name 
FROM products
WHERE product_id IN (SELECT product_id FROM order_details WHERE quantity > 3);
Correlated Subquery

sql
SELECT e.first_name, e.salary
FROM employees e
WHERE salary > (SELECT AVG(salary) 
                FROM employees 
                WHERE department_id = e.department_id);
EXISTS Operator

sql
SELECT c.company_name
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o 
              WHERE o.customer_id = c.customer_id
              AND o.order_date > '2023-01-01');
Derived Table (Subquery in FROM)

sql
SELECT d.department_name, emp_count.employee_count
FROM departments d
JOIN (SELECT department_id, COUNT(*) AS employee_count
      FROM employees
      GROUP BY department_id) emp_count
ON d.department_id = emp_count.department_id;

## Interview Q&A

### 1. What is a subquery?
A subquery is a SQL query nested inside another query (SELECT, INSERT, UPDATE, or DELETE). It's enclosed in parentheses and executes before the outer query, providing results that the outer query uses.

### 2. Difference between subquery and join?
| Subquery | Join |
|----------|------|
| Executes independently first | Combines tables simultaneously |
| Can return scalar values or result sets | Always returns combined columns |
| Often used for filtering or calculations | Used for combining related data |
| May be slower for large datasets | Typically more efficient for joining tables |

### 3. What is a correlated subquery?
A correlated subquery references columns from the outer query and executes once for each row processed by the outer query. Example:
```sql
SELECT e.name FROM employees e 
WHERE salary > (SELECT AVG(salary) FROM employees WHERE dept = e.dept);
```

### 4. Can subqueries return multiple rows?
Yes, when used with operators like IN, ANY, ALL, or EXISTS. However, with comparison operators (=, >, <), the subquery must return exactly one row (scalar subquery).

### 5. How does EXISTS work?
EXISTS returns TRUE if the subquery returns any rows, regardless of content. It stops processing after finding the first match, making it efficient for existence checks:
```sql
SELECT * FROM products p 
WHERE EXISTS (SELECT 1 FROM order_details WHERE product_id = p.product_id);
```

### 6. How is performance affected by subqueries?
- **Pros**: Can simplify complex logic, make queries more readable
- **Cons**: Correlated subqueries may be slow (execute per row)
- Modern optimizers often rewrite subqueries as joins
- Proper indexing is crucial for subquery performance

### 7. What is scalar subquery?
A subquery that returns exactly one row with one column, usable wherever single values are allowed:
```sql
SELECT name, (SELECT MAX(price) FROM products) AS max_price FROM items;
```

### 8. Where can we use subqueries?
- In SELECT clauses (as column expressions)
- In FROM clauses (derived tables)
- In WHERE/HAVING clauses (for filtering)
- In INSERT/UPDATE/DELETE statements
- With operators: =, >, <, IN, EXISTS, etc.

### 9. Can a subquery be in FROM clause?
Yes, this is called a derived table or inline view. It must have an alias:
```sql
SELECT d.dept_name, emp_counts.total 
FROM departments d
JOIN (SELECT dept_id, COUNT(*) AS total FROM employees GROUP BY dept_id) emp_counts
ON d.dept_id = emp_counts.dept_id;
```

### 10. What is a derived table?
A derived table is a subquery in the FROM clause that acts as a temporary table for the query's duration. It must have an alias and can be joined like regular tables.

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/sql-subqueries.git
   ```

2. Execute the SQL script in your preferred database tool.

## Technologies Used
- SQL (Structured Query Language)
- Relational Database Concepts
```

Key improvements:
1. Structured Q&A in clear numbered format
2. Added comparison tables where helpful (Q2)
3. Included code examples within answers when relevant
4. Maintained consistent formatting
5. Kept answers concise yet comprehensive
6. Organized logically from basic to advanced concepts
7. Preserved all other README sections

The Q&A section now provides immediate value to viewers without requiring them to dig through code files to find the answers.
