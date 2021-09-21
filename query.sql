/* 1*/
SELECT c.Address AS "Campus", COUNT(s.StudentName) AS "Total Student No"
FROM Campus c
  INNER JOIN Classroom AS r ON c.CaID = r.CaID
  INNER JOIN SpaceAssign AS a ON r.RmID = a.RmID
  INNER JOIN Teach AS t ON a.TID = t.TID
  INNER JOIN Enrolment AS e ON t.ModuleID = e.ModuleID
  INNER JOIN Student AS s ON e.StudentID = s.StudentID
  GROUP BY c.Address;

/* 2*/

SELECT d.DeptName AS "Department", COUNT(s.StudentName) AS "Total Student No" 
FROM Department d
	INNER JOIN Module AS m ON d.DeptID = m.DeptID
    INNER JOIN Enrolment AS e ON m.ModuleID = e.ModuleID
    INNER JOIN Student AS s ON e.StudentID = s.StudentID
    GROUP BY d.DeptName
    HAVING COUNT(*) > 50;

/* 3*/
SELECT DISTINCT s.StudentID, s.StudentName, d.DeptName 
FROM Department d 
    INNER JOIN Module AS m ON d.DeptID = m.DeptID 
    INNER JOIN Enrolment AS e ON m.ModuleID = e.ModuleID 
    INNER JOIN Student AS s ON e.StudentID = s.StudentID 
    WHERE e.Year = 2020 
    AND m.TMode = "Online";
	
/* 4*/
INSERT INTO Campus (Campus.Address, Campus.GmName, Campus.Country, Campus.Status)
VALUES ("122 Pineapple Ave, New York", "Michael Carlos", "USA", "Open soon");

/* 5*/
SELECT s.StaffID, s.FirstName, s.LastName, c.Address AS "Campus"
	FROM Staff s
    INNER JOIN Campus AS c ON s.CaID = c.CaID
    WHERE s.LeftD >= "2019-01-01" 
    AND s.LeftD <= "2019-12-30";
	
/* 6*/
SELECT c.RmID, c.Capacity, c.Location
FROM Classroom c
	INNER JOIN SpaceAssign AS s ON c.RmID = s.RmID
    INNER JOIN Teach AS t ON s.SpaID = t.SpaID
    WHERE s.Approved = "Pending"
    AND t.Year != 2018
    AND c.Location LIKE "%Belfast";
	
/* 7*/
SELECT DISTINCT s.StaffID, s.FirstName, s.LastName, d.DeptName 
FROM Staff s 
	INNER JOIN Department AS d ON s.DeptID = d.DeptID 
	LEFT JOIN Allocation al ON s.StaffID = al.StaffID 
	WHERE al.AcID is NULL;
	

/* 8*/
SELECT s.StaffID, s.Title, s.FirstName, s.LastName, d.DeptName
FROM Staff s
	INNER JOIN Department AS d ON s.DeptID = d.DeptID
    LEFT JOIN Teach AS t ON s.StaffID = t.StaffID
    WHERE s.LeftD >= "2018-01-01"
    AND t.Year != 2019 OR t.Year IS NOT NULL
    AND s.ContractType = "Full Time"
    AND s.Salary > (SELECT AVG(Salary) FROM Staff WHERE s.DeptID = d.DeptID);
	
/* 9*/
SELECT a.AcID, a.Title, c.Address AS "Campus", b.Amount, b.Status
FROM Activity a
	INNER JOIN Allocation AS l ON a.AcID = l.AcID
    INNER JOIN Staff AS s ON l.StaffID = s.StaffID
    INNER JOIN Teach AS t ON s.StaffID = t.StaffID
    INNER JOIN Module AS m ON t.ModuleID = m.ModuleID
	INNER JOIN Campus AS c ON s.CaID = c.CaID
    INNER JOIN Budget AS b ON a.BuID = b.BuID
    WHERE t.Year = 2019
    AND a.Internal = 1
    AND c.Address LIKE "%Sydney"
    GROUP BY t.StaffID, s.SupervisorID
	HAVING COUNT(*) > 1;

/* 10*/
SELECT a.Title, COUNT(l.StaffID) AS "Staff Allocated"
FROM Activity a
	INNER JOIN Allocation AS l ON a.AcID = l.AcID
	INNER JOIN Staff AS s ON l.StaffID = s.StaffID
    INNER JOIN Budget AS b ON a.BuID = b.BuID
    WHERE s.LeftD IS NULL
    AND a.Status != "Finished"
    AND b.Amount > 300
    GROUP BY a.AcID
	HAVING COUNT(l.StaffID) > 1;
	
/* 11*/
SELECT s.StaffID, s.FirstName, s.LastName, a.Title, b.Amount, a.Status
FROM Staff s
	INNER JOIN Campus AS c ON s.CaID = c.CaID
    INNER JOIN Activity AS a ON c.CaID = a.CaID
    INNER JOIN Budget AS b ON a.BuID = b.BuID
    WHERE s.Current = 1
    AND s.ContractType = "Full time"
    AND s.Joined < "2017-01-01"
    AND s.LeftD > "2017-12-30" OR NULL
    AND c.Address LIKE "%Belfast";
	
/* 12*/
SELECT s.StaffID, s.FirstName, s.LastName, COUNT(c.RmID) AS "Classroom# Used"
FROM Staff s
	INNER JOIN Teach AS t ON s.StaffID = t.StaffID
    INNER JOIN Module AS m ON t.ModuleID = m.ModuleID
    INNER JOIN SpaceAssign AS p ON t.SpaID = p.SpaID
    INNER JOIN Classroom AS c ON p.RmID = c.RmID
    WHERE t.Year = 2018 OR t.Year = 2019
    AND s.Current = 1
    GROUP BY s.StaffID;