CREATE TABLE Person (
    id INT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    personNumber VARCHAR(12) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip VARCHAR(50) NOT NULL,
    street VARCHAR(50) NOT NULL
);

CREATE TABLE Student (
    id INT PRIMARY KEY,
    contactPerson VARCHAR(50) NOT NULL,
    studentID VARCHAR(50) NOT NULL,
    siblingID VARCHAR(50),
    person_id INT NOT NULL,
    rental_id INT,
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE Teacher (
    id INT PRIMARY KEY,
    employmentID VARCHAR(10) NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE Instrument (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    instrumentID VARCHAR(50) NOT NULL,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(id)
);

CREATE TABLE Rental (
    id INT PRIMARY KEY,
    price DOUBLE PRECISION NOT NULL,
    rentalTimeLimit TIMESTAMP NOT NULL,
    instrumentLimit VARCHAR(10) NOT NULL,
    minInstruments VARCHAR(10) NOT NULL,
    maxInstruments VARCHAR(10) NOT NULL
);

CREATE TABLE LessonType (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    minStudents INT NOT NULL,
    maxStudents INT NOT NULL,
    description VARCHAR(50),
    targetGenre VARCHAR(50)
);

CREATE TABLE Lesson (
    id INT PRIMARY KEY,
    lessonDate VARCHAR(50) NOT NULL,
    skillLevel VARCHAR(50) NOT NULL,
    duration VARCHAR(50) NOT NULL,
    bookingSchedule_id INT,
    teacher_id INT NOT NULL,
    administrative_id INT NOT NULL,
    lessonType_id INT NOT NULL,
    instrument_id INT,
    FOREIGN KEY (bookingSchedule_id) REFERENCES BookingSchedule(id),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(id),
    FOREIGN KEY (administrative_id) REFERENCES AdministrativeStaff(id),
    FOREIGN KEY (lessonType_id) REFERENCES LessonType(id),
    FOREIGN KEY (instrument_id) REFERENCES Instrument(id)
);

CREATE TABLE LessonStudent (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    attendance VARCHAR(10) NOT NULL,
    paymentStatus VARCHAR(10),
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (lesson_id) REFERENCES Lesson(id)
);

CREATE TABLE LessonPrice (
    id INT PRIMARY KEY,
    price DOUBLE PRECISION NOT NULL,
    startDate VARCHAR(50) NOT NULL,
    endDate VARCHAR(50) NOT NULL,
    lesson_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES Lesson(id)
);

CREATE TABLE BookingSchedule (
    id INT PRIMARY KEY,
    timeSlot TIMESTAMP NOT NULL,
    room VARCHAR(50) NOT NULL,
    administrativeStaff_id INT NOT NULL,
    teacher_id INT NOT NULL,
    FOREIGN KEY (administrativeStaff_id) REFERENCES AdministrativeStaff(id),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(id)
);

CREATE TABLE AdministrativeStaff (
    id INT PRIMARY KEY,
    employmentID VARCHAR(50) NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE Email (
    id CHAR(10) PRIMARY KEY,
    emailAddress VARCHAR(500) UNIQUE
);

CREATE TABLE personEmail (
    email_id CHAR(10) NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY (email_id) REFERENCES Email(id),
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE Phone (
    id INT PRIMARY KEY,
    phoneNo VARCHAR(500)
);

CREATE TABLE personPhone (
    phone_id INT NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY (phone_id) REFERENCES Phone(id),
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE siblingStudent (
    id INT PRIMARY KEY,
    studentID INT NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

-- INSERT DATA

-- Insert Persons
INSERT INTO Person VALUES
(1, 'John', 'Doe', '123456789012', 'New York', '10001', '5th Avenue'),
(2, 'Jane', 'Smith', '987654321012', 'Los Angeles', '90001', 'Sunset Blvd'),
(3, 'Alice', 'Brown', '456123789012', 'Chicago', '60601', 'Michigan Ave'),
(4, 'Bob', 'Johnson', '789456123012', 'Houston', '77001', 'Main St');

-- Insert Students
INSERT INTO Student VALUES
(1, 'Parent1', 'STU001', NULL, 1, 1),
(2, 'Parent2', 'STU002', 1, 2, 2);

-- Insert Teachers
INSERT INTO Teacher VALUES
(1, 'EMP001', 3),
(2, 'EMP002', 4);

-- Insert Administrative Staff
INSERT INTO AdministrativeStaff VALUES
(1, 'ADM001', 4);

-- Insert Instruments
INSERT INTO Instrument VALUES
(1, 'Guitar', 'INST001', 1),
(2, 'Piano', 'INST002', 2);

-- Insert Rentals
INSERT INTO Rental VALUES
(1, 50.00, '2026-01-06', '2', '1', '2');

-- Insert Lesson Types
INSERT INTO LessonType VALUES
(1, 'Individual', 1, 1, 'Private lessons', NULL),
(2, 'Group', 2, 10, 'Group lessons', NULL),
(3, 'Ensemble', 3, 10, 'Ensemble lessons', 'Jazz');

-- Insert Lessons
INSERT INTO Lesson VALUES
(1, '2025-01-06', 'Beginner', '30min', 1, 1, 1, 1, 1),
(2, '2025-01-07', 'Intermediate', '1hr', 2, 2, 1, 2, 2);

-- Insert Lesson Students
INSERT INTO LessonStudent VALUES
(1, 1, 'Present', 'Paid'),
(2, 2, 'Absent', 'Unpaid');

-- Insert Lesson Prices
INSERT INTO LessonPrice VALUES
(1, 20.00, '2025-01-01', '2025-12-31', 1),
(2, 30.00, '2025-01-01', '2025-12-31', 2);

-- Insert Booking Schedules
INSERT INTO BookingSchedule VALUES
(1, '2025-01-06 10:00:00', 'Room A', 1, 1),
(2, '2025-01-07 14:00:00', 'Room B', 1, 2);

-- Insert Emails
INSERT INTO Email VALUES
('EM001', 'john.doe@example.com'),
('EM002', 'jane.smith@example.com');

-- Insert Person Emails
INSERT INTO personEmail VALUES
('EM001', 1),
('EM002', 2);

-- Insert Phones
INSERT INTO Phone VALUES
(1, '123-456-7890'),
(2, '987-654-3210');

-- Insert Person Phones
INSERT INTO personPhone VALUES
(1, 1),
(2, 2);

-- Insert Sibling Students
INSERT INTO siblingStudent VALUES
(1, 2, 1);

