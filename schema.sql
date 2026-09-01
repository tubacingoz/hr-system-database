-- 1. Departmanlar Tablosu
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100) NOT NULL,
    BudgetCode VARCHAR(50)
);

-- 2. Çalışanlar Tablosu
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    HireDate DATE NOT NULL,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 3. İzin Talepleri Tablosu
CREATE TABLE Leave_Requests (
    RequestID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    LeaveDays INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending',
    RequestDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- 4. Maaş Geçmişi Tablosu
CREATE TABLE Payroll_History (
    PayrollID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    BaseSalary DECIMAL(10,2) NOT NULL,
    UpdateDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
