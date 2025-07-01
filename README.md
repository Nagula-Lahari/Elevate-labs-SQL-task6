
# SQL Subqueries and Nested Queries

This repository demonstrates various types of SQL subqueries and nested queries, created as part of a SQL Developer Internship Task.

## Table of Contents
- [Project Overview](#project-overview)
- [Database Schema](#database-schema)
- [Subquery Examples](#subquery-examples)
- [Interview Questions](#interview-questions)
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

The database consists of the following tables:

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

The repository includes the following subquery implementations:

1. **Scalar Subquery in SELECT**
   ```sql
   SELECT employee_id, first_name, salary,
          (SELECT AVG(salary) FROM employees) AS avg_salary
   FROM employees;
   ```

2. **Subquery with IN Operator**
   ```sql
   SELECT product_name 
   FROM products
   WHERE product_id IN (SELECT product_id FROM order_details WHERE quantity > 3);
   ```

3. **Correlated Subquery**
   ```sql
   SELECT e.first_name, e.salary
   FROM employees e
   WHERE salary > (SELECT AVG(salary) 
                   FROM employees 
                   WHERE department_id = e.department_id);
   ```

4. **EXISTS Operator**
   ```sql
   SELECT c.company_name
   FROM customers c
   WHERE EXISTS (SELECT 1 FROM orders o 
                 WHERE o.customer_id = c.customer_id
                 AND o.order_date > '2023-01-01');
   ```

5. **Derived Table (Subquery in FROM)**
   ```sql
   SELECT d.department_name, emp_count.employee_count
   FROM departments d
   JOIN (SELECT department_id, COUNT(*) AS employee_count
         FROM employees
         GROUP BY department_id) emp_count
   ON d.department_id = emp_count.department_id;
   ```

## Interview Questions

The project addresses common interview questions about subqueries:

1. What is a subquery?
2. Difference between subquery and join
3. What is a correlated subquery?
4. Can subqueries return multiple rows?
5. How does EXISTS work?
6. How is performance affected by subqueries?
7. What is scalar subquery?
8. Where can we use subqueries?
9. Can a subquery be in FROM clause?
10. What is a derived table?

Answers to these questions can be found in the [SQL script file](/subqueries_demo.sql).

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/sql-subqueries.git
   ```

2. Execute the SQL script in your preferred database tool:
   - DB Browser for SQLite
   - MySQL Workbench
   - SQL Server Management Studio
   - pgAdmin (PostgreSQL)

3. Run individual queries to see the results of each subquery type.

## Technologies Used

- SQL (Structured Query Language)
- DB Browser for SQLite / MySQL Workbench
- Relational Database Concepts

```

This README includes:

1. Professional structure with clear sections
2. Visual database schema (using Mermaid syntax which GitHub supports)
3. Code snippets with syntax highlighting
4. Clear instructions for setup and usage
5. Technology stack information
6. Interview questions section
7. Professional formatting

