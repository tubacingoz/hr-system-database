# Corporate HR Management System: Database Architecture & Business Analysis

**Manifesto & Project Scope**
This repository demonstrates the transformation of complex human resources workflows into structured, normalized relational database models. By combining principles of labor economics and industrial relations with IT Business Analysis methodologies, this project bridges the gap between business requirements and technical execution within the Software Development Life Cycle (SDLC). 

## Technologies & Tools
* **Database Management:** SQL (PostgreSQL / T-SQL)
* **Architecture & Modeling:** Relational Data Modeling, Entity-Relationship (ER) Diagrams
* **Business Analysis:** Requirement Engineering, Data Mapping, Agile/Scrum Context
* **Domain Expertise:** Personnel tracking, payroll logic, leave management workflows

## Database Architecture
The system is built on a normalized relational structure to ensure data integrity and query efficiency for HR operations.

**`Departments`:** Manages organizational units and budget codes.
**`Employees`:** The core entity storing personnel records, linked to departments via a One-to-Many (1:N) relationship.
**`Leave_Requests`:** Tracks time-off policies, utilizing status flags (Pending, Approved, Rejected) and date intervals.
**`Payroll_History`:** Stores immutable financial records, salary adjustments, and compensation calculations.

## Business Scenarios & Execution (SQL Implementation)

The following scenarios represent real-world business requirements translated into executable SQL queries.

### Scenario 1: Strategic Tenure & Severance Pay Infrastructure
**Business Requirement:** Management requires an automated view of the average organizational tenure per department to forecast potential severance pay liabilities and retention rates.

```sql
SELECT 
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalActiveEmployees,
    AVG(DATEDIFF(YEAR, e.HireDate, GETDATE())) AS AverageTenureYears
FROM 
    Employees e
JOIN 
    Departments d ON e.EmployeeID = d.DepartmentID
WHERE 
    e.IsActive = 1
GROUP BY 
    d.DepartmentName
ORDER BY 
    AverageTenureYears DESC;

```

### **Scenario 2: Critical Leave Balance Control**

**Business Requirement:** The HR department needs to identify operational risks by flagging active employees who have completely exhausted their annual leave balances.

```sql
SELECT 
    e.FirstName, 
    e.LastName, 
    d.DepartmentName
FROM 
    Employees e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    e.EmployeeID IN (
        SELECT EmployeeID 
        FROM Leave_Requests 
        GROUP BY EmployeeID 
        HAVING SUM(LeaveDays) >= 14 -- Assuming 14 days baseline
    )
    AND e.IsActive = 1;

```

##  Future Enhancements

* **API Integration Planning:** Designing RESTful endpoints to expose this SQL data via JSON payloads for front-end HR dashboards.
* **Observability & Audit Logging:** Implementing trigger-based audit logs for critical payroll modifications to ensure data governance and system health.

```

```
