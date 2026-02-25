--Using the Company Database, write the queries for the following:
--1. Retrieve the birth date and address of the employee(s) whose name is ‘John B. Smith’.
SELECT bdate
FROM company.employee
WHERE fname = 'John'
  AND minit = 'B'
  AND lname = 'Smith';


--2. Retrieve the name and address of all employees who work for the ‘Research’ department.

SELECT e.fname, e.minit, e.lname, e.address
FROM company.employee e
         JOIN company.department d
              ON e.dno = d.dnumber
WHERE d.dname = 'Research';


--3. For every project located in ‘Stafford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date.
SELECT p.pnumber,
       p.dnum AS controlling_department_number,
       m.lname AS manager_lname,
       m.address AS manager_address,
       m.bdate AS manager_bdate
FROM company.project p
         JOIN company.department d
              ON p.dnum = d.dnumber
         JOIN company.employee m
              ON d.mgr_ssn = m.ssn
WHERE p.plocation = 'Stafford';

--4. For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor.
SELECT e.fname  AS employee_fname,
       e.lname  AS employee_lname,
       s.fname  AS supervisor_fname,
       s.lname  AS supervisor_lname
FROM company.employee e
         LEFT JOIN company.employee s
                   ON e.super_ssn = s.ssn;

--5. Make a list of all project numbers for projects that involve an employee whose last name is ‘Smith’, either as a worker or as a manager of the department that controls the project.
SELECT DISTINCT p.pnumber
FROM company.project p
WHERE EXISTS (
    SELECT 1
    FROM company.works_on w
             JOIN company.employee e
                  ON e.ssn = w.essn
    WHERE w.pno = p.pnumber
      AND e.lname = 'Smith'
)
   OR EXISTS (
    SELECT 1
    FROM company.department d
             JOIN company.employee m
                  ON m.ssn = d.mgr_ssn
    WHERE d.dnumber = p.dnum
      AND m.lname = 'Smith'
);

--6. Retrieve all employees whose address is in Houston, Texas.
SELECT *
FROM company.employee
WHERE address ILIKE '%Houston%'
  AND (address ILIKE '%TX%' OR address ILIKE '%Texas%');

--7. Show the resulting salaries if every employee working on the ‘ProductX’ project is given a 10% raise.
SELECT DISTINCT e.fname,
                e.lname,
                e.salary AS current_salary,
                (e.salary * 1.10) AS raised_salary
FROM company.employee e
         JOIN company.works_on w
              ON e.ssn = w.essn
         JOIN company.project p
              ON p.pnumber = w.pno
WHERE p.pname = 'ProductX';

--8. Retrieve the names of all employees who do not have supervisors.
SELECT e.fname, e.minit, e.lname
FROM company.employee e
WHERE e.super_ssn IS NULL;

