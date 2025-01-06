INSERT INTO Person VALUES
(1, 'John', 'Doe', '199001010001', 'Stockholm', '12345', 'Main Street 1'),
(2, 'Jane', 'Smith', '199502020002', 'Stockholm', '12345', 'Main Street 2'),
(3, 'Alice', 'Johnson', '198703030003', 'Stockholm', '12345', 'Main Street 3'),
(4, 'Bob', 'Brown', '198104040004', 'Stockholm', '12345', 'Main Street 4');

-- Insert Data into Student Table
INSERT INTO Student VALUES
(1, 'Jane Smith', 'STU001', NULL, 1, NULL),
(2, 'John Doe', 'STU002', 1, 2, NULL);

-- Insert Data into Teacher Table
INSERT INTO Teacher VALUES
(1, 'EMP001', 3),
(2, 'EMP002', 4);

-- Insert Data into Instrument Table
INSERT INTO Instrument VALUES
(1, 'Piano', 'INST001', NULL),
(2, 'Guitar', 'INST002', NULL),
(3, 'Violin', 'INST003', 1),
(4, 'Flute', 'INST004', 2);

-- Insert Data into Rental Table
INSERT INTO Rental VALUES
(1, 50.0, '2025-12-31', '2', '1', '2');

-- Insert Data into LessonType Table
INSERT INTO LessonType VALUES
(1, 'Individual', 1, 1, 'One-on-one lessons', NULL),
(2, 'Group', 3, 10, 'Group lessons for beginners', NULL),
(3, 'Ensemble', 5, 15, 'Ensemble practice', 'Jazz');

INSERT INTO LessonType VALUES
(4, 'Ensemble', 15, 20, 'String Orchestra practice', 'Classical'),
(5, 'Ensemble', 20, 25, 'Choir practice', 'Choral');

-- Insert Data into AdministrativeStaff Table
INSERT INTO AdministrativeStaff VALUES
(1, 'ADM001', 1);

-- Insert Data into BookingSchedule Table
INSERT INTO BookingSchedule VALUES
(1, '2025-01-15 10:00:00', 'Room A', 1, 1),
(2, '2025-01-16 15:00:00', 'Room B', 1, 2);

-- Insert Data into Lesson Table
INSERT INTO Lesson VALUES
(1, '2025-01-15', 'Beginner', '1 hour', 1, 1, 1, 1, 1),
(2, '2025-01-16', 'Intermediate', '1 hour', 2, 2, 1, 2, 2),
(3, '2024-03-10', 'Beginner', '1 hour', 1, 1, 1, 1, 1),
(4, '2024-03-15', 'Intermediate', '1 hour', 2, 2, 1, 2, 2),
(5, '2024-04-05', 'Advanced', '1 hour', 1, 1, 1, 3, 1),
(6, '2024-04-12', 'Beginner', '1 hour', 2, 2, 1, 2, 2),
(7, '2024-05-01', 'Intermediate', '1 hour', 1, 1, 1, 3, 1),
(8, '2024-05-10', 'Advanced', '1 hour', 2, 2, 1, 1, 2),
(9, '2024-05-15', 'Beginner', '1 hour', 1, 1, 1, 1, 3),
(10, '2024-05-20', 'Intermediate', '1 hour', 2, 2, 1, 2, 4);

INSERT INTO Lesson VALUES
(11, '2024-05-11', 'Intermediate', '1 hour', 2, 2, 1, 2, 2),
(12, '2024-05-12', 'Beginner', '1 hour', 1, 1, 1, 3, 1),
(13, '2024-05-13', 'Intermediate', '1 hour', 2, 2, 1, 2, 2),
(14, '2024-05-14', 'Advanced', '1 hour', 1, 1, 1, 3, 1),
(15, '2024-05-16', 'Intermediate', '1 hour', 1, 1, 1, 3, 1),
(16, '2024-05-17', 'Ensemble Practice', '2 hours', 2, 1, 1, 3, 3),
(17, '2024-05-18', 'String Orchestra', '2 hours', 1, 2, 1, 4, 4),
(18, '2024-05-19', 'Choir Practice', '2 hours', 2, 1, 1, 4, 4); 





-- Insert Data into LessonStudent Table
INSERT INTO LessonStudent VALUES
(1, 1, 'Present', 'Paid'),
(2, 2, 'Absent', 'Unpaid');

-- Insert Data into LessonPrice Table
INSERT INTO LessonPrice VALUES
(1, 30.0, '2025-01-01', '2025-12-31', 1),
(2, 40.0, '2025-01-01', '2025-12-31', 2);

-- Insert Data into Email Table
INSERT INTO Email VALUES
('E001', 'john.doe@example.com'),
('E002', 'jane.smith@example.com');

-- Insert Data into personEmail Table
INSERT INTO personEmail VALUES
('E001', 1),
('E002', 2);

-- Insert Data into Phone Table
INSERT INTO Phone VALUES
(1, '123456789'),
(2, '987654321');

-- Insert Data into personPhone Table
INSERT INTO personPhone VALUES
(1, 1),
(2, 2);

-- Insert Data into siblingStudent Table
INSERT INTO siblingStudent VALUES
(1, 2, 2);

-- Query 1: Number of lessons per month in a specified year
SELECT 
    MONTHNAME(STR_TO_DATE(lessonDate, '%Y-%m-%d')) AS Month,
    COUNT(*) AS Total,
    SUM(CASE WHEN lt.name = 'Individual' THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN lt.name = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,
    SUM(CASE WHEN lt.name = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble
FROM Lesson l
JOIN LessonType lt ON l.lessonType_id = lt.id
WHERE YEAR(STR_TO_DATE(lessonDate, '%Y-%m-%d')) = 2024
GROUP BY MONTHNAME(STR_TO_DATE(lessonDate, '%Y-%m-%d'))
ORDER BY Month;

-- Query 2: Count of students by number of siblings
SELECT 
    COUNT(s.id) AS NoOfStudents,
    COUNT(ss.studentID) AS NoOfSiblings
FROM Student s
LEFT JOIN siblingStudent ss ON s.id = ss.studentID
GROUP BY ss.studentID;

-- Query 3: Instructors with more than specified lessons in the current month
SELECT 
    t.id AS InstructorId,
    p.firstName,
    p.lastName,
    COUNT(l.id) AS NoOfLessons
FROM Teacher t
JOIN Person p ON t.person_id = p.id
JOIN Lesson l ON t.id = l.teacher_id
WHERE MONTH(STR_TO_DATE(l.lessonDate, '%Y-%m-%d')) = 5 -- May 2024
  AND YEAR(STR_TO_DATE(l.lessonDate, '%Y-%m-%d')) = 2024 -- Explicit year
GROUP BY t.id, p.firstName, p.lastName
HAVING COUNT(l.id) > 3
ORDER BY NoOfLessons DESC;


-- Query 4: Ensembles held next week with seat availability
SELECT 
    DAYNAME(STR_TO_DATE(l.lessonDate, '%Y-%m-%d')) AS Day,
    lt.targetGenre AS Genre,
    CASE 
        WHEN COUNT(ls.student_id) >= lt.maxStudents THEN 'No Seats'
        WHEN COUNT(ls.student_id) >= (lt.maxStudents - 2) THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS NoOfFreeSeats
FROM Lesson l
JOIN LessonType lt ON l.lessonType_id = lt.id
LEFT JOIN LessonStudent ls ON l.id = ls.lesson_id
WHERE lt.name = 'Ensemble'
  AND STR_TO_DATE(l.lessonDate, '%Y-%m-%d') BETWEEN '2024-05-17' AND '2024-05-24' -- Specific week in May 2024
GROUP BY Day, Genre, lt.maxStudents
ORDER BY Day, Genre;

EXPLAIN ANALYZE SELECT 
    MONTHNAME(STR_TO_DATE(lessonDate, '%Y-%m-%d')) AS Month,
    COUNT(*) AS Total,
    SUM(CASE WHEN lt.name = 'Individual' THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN lt.name = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,
    SUM(CASE WHEN lt.name = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble
FROM Lesson l
JOIN LessonType lt ON l.lessonType_id = lt.id
WHERE YEAR(STR_TO_DATE(lessonDate, '%Y-%m-%d')) = 2024
GROUP BY MONTHNAME(STR_TO_DATE(lessonDate, '%Y-%m-%d'))
ORDER BY Month;

