
SELECT e.* 
FROM Employee e
INNER JOIN (SELECT dept_id as [Department ID], MAX(salary) as [Top salary] FROM Employee GROUP BY dept_id) s
on e.salary = s.[Top salary]
ORDER BY e.dept_id 




SELECT d.dept_id as [Department ID], COUNT(emp_id) as [Total Employee]
FROM Department d
LEFT JOIN Employee e
ON d.dept_id = e.dept_id 
GROUP BY d.dept_id 
HAVING COUNT(emp_id) < 3


SELECT d.*, c.[Total Employee] 
FROM Department d
INNER JOIN (SELECT d.dept_id as [Department ID], COUNT(emp_id) as [Total Employee]
			FROM Department d
			LEFT JOIN Employee e
			ON d.dept_id = e.dept_id 
			GROUP BY d.dept_id) c
ON d.dept_id = c.[Department ID]



SELECT d.*, c.[Total salary] 
FROM Department d
INNER JOIN (SELECT d.dept_id as [Department ID], COALESCE(SUM(salary),0) as [Total salary]
			FROM Department d
			LEFT JOIN Employee e
			ON d.dept_id = e.dept_id 
			GROUP BY d.dept_id ) c 
ON d.dept_id = c.[Department ID]