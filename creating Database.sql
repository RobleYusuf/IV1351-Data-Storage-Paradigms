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

CREATE TABLE AdministrativeStaff (
    id INT PRIMARY KEY,
    employmentID VARCHAR(50) NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id)
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

