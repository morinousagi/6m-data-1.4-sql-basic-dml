# Self Studies

## Brief

In this lesson, we will be learning about SQL Data Manipulation Language (DML) statements. DML statements are used to query and manipulate data in a database. It is the workhorse of SQL and is used frequently by data analysts and data scientists.

# **Pre-class Self-study Materials**

### **1\. Summary of Key Concepts**

In this lesson, we move from building the "containers" (DDL) to handling the "content" (DML). You will learn how to:

* **Retrieve** data using SELECT and FROM.  
* **Filter** results to find specific information using WHERE.

* **Calculate** summaries (like averages or totals) using Aggregate Functions and GROUP BY.

* **Transform** data on the fly using CASE logic and CAST functions.

### Video introduction
Watch this - 🎬 [Intro to SQL DML](https://youtu.be/SbtP9O6qOAA?si=94M75fLMsQtjOFt2)

### **2\. Setup Instructions**

1. **Tool:** Ensure **DbGate** is installed on your machine.  
2. **Database:** Download the db/unit-1-4.db file from the course repository.

3. **Connection:** Open DbGate, create a new DuckDB connection, and point it to the downloaded .db file.

4. **Verification:** Run follow SQL  
```sql
SELECT * FROM resale_flat_prices_2017 LIMIT 5
```
to ensure you can see the Singapore HDB data.
