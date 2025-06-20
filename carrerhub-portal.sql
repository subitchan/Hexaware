-- 1. Create Database
CREATE DATABASE careerhubportal;
USE careerhubportal;

-- ("Use Password as hashedpwd1 hashedpwd2 hashedpwd3 hashedpwd4 hashedpwd5")


-- 2. User Table
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role ENUM('JOB_SEEKER', 'EMPLOYER') NOT NULL
);

-- 3. Job Seeker Profile Table (with email)
CREATE TABLE job_seeker_profile (
    profile_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    skills TEXT,
    education TEXT,
    FOREIGN KEY (profile_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- 4. Employer Profile Table
CREATE TABLE employer_profile (
    employer_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    company_website VARCHAR(100),
    contact_email VARCHAR(100),
    FOREIGN KEY (employer_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- 5. Job Listing Table
CREATE TABLE job_listing (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    employer_id INT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    job_description TEXT,
    location VARCHAR(100),
    salary_range VARCHAR(50),
    skills_required TEXT,
    FOREIGN KEY (employer_id) REFERENCES employer_profile(employer_id) ON DELETE CASCADE
);

-- 6. Job Application Table (without cover_letter)
CREATE TABLE job_application (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    profile_id INT NOT NULL,
    application_status ENUM('APPLIED', 'SHORTLISTED', 'REJECTED', 'HIRED') DEFAULT 'APPLIED',
    FOREIGN KEY (job_id) REFERENCES job_listing(job_id) ON DELETE CASCADE,
    FOREIGN KEY (profile_id) REFERENCES job_seeker_profile(profile_id) ON DELETE CASCADE
);

-- 7. Resume Table (linked to job_application)
CREATE TABLE resume (
    resume_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    resume_data LONGBLOB,
    resume_filename VARCHAR(255),
    FOREIGN KEY (application_id) REFERENCES job_application(application_id) ON DELETE CASCADE
);


-- Insert into user table
INSERT INTO user (username, password, email, role) VALUES
('john_doe', 'hashedpwd1', 'john@example.com', 'JOB_SEEKER'),
('jane_smith', 'hashedpwd2', 'jane@example.com', 'JOB_SEEKER'),
('alice_jones', 'hashedpwd3', 'alice@example.com', 'JOB_SEEKER'),
('recruit_hr', 'hashedpwd4', 'hr@techcorp.com', 'EMPLOYER'),
('emily_mgr', 'hashedpwd5', 'emily@softinc.com', 'EMPLOYER');

-- Insert into job_seeker_profile table
INSERT INTO job_seeker_profile (profile_id, full_name, phone, email, skills, education) VALUES
(1, 'John Doe', '9876543210', 'john@example.com', 'Java, Spring Boot', 'BSc Computer Science'),
(2, 'Jane Smith', '9123456780', 'jane@example.com', 'Python, Data Analysis', 'MSc Data Science'),
(3, 'Alice Jones', '9988776655', 'alice@example.com', 'React, HTML, CSS', 'BSc Information Tech');

-- Insert into employer_profile table
INSERT INTO employer_profile (employer_id, company_name, company_website, contact_email) VALUES
(4, 'TechCorp Pvt Ltd', 'https://techcorp.com', 'hr@techcorp.com'),
(5, 'SoftInc Solutions', 'https://softinc.io', 'emily@softinc.com');

-- Insert into job_listing table
INSERT INTO job_listing (employer_id, job_title, job_description, location, salary_range, skills_required) VALUES
(4, 'Java Developer', 'Develop backend services using Java and Spring Boot.', 'Bangalore', '6-10 LPA', 'Java, Spring Boot'),
(4, 'Data Analyst', 'Analyze business data and generate reports.', 'Hyderabad', '5-8 LPA', 'Python, SQL'),
(5, 'Frontend Developer', 'Work on web front-end using React and JS.', 'Remote', '7-11 LPA', 'React, JavaScript, HTML');

-- Insert into job_application table
INSERT INTO job_application (job_id, profile_id, application_status) VALUES
(1, 1, 'APPLIED'),
(2, 2, 'SHORTLISTED'),
(3, 3, 'APPLIED');

-- Insert into resume table (no actual file data for now)
INSERT INTO resume (application_id, resume_data, resume_filename) VALUES
(1, NULL, 'John_Resume.pdf'),
(2, NULL, 'Jane_DataResume.pdf'),
(3, NULL, 'Alice_Frontend.pdf');


UPDATE user
SET password = '$2a$10$6cyzLWSo3g4qOm4W2ryNZupRW2VQhJZZSfnBHHT1mJNtUE.GLhsDe'
WHERE user_id = 1;

UPDATE user
SET password = '$2a$10$J0Prd.v5tz3DUucm5eDnwORHSSucV3Nve.a4/grjj8n1K5wrwMABq'
WHERE user_id = 2;

UPDATE user
SET password = '$2a$10$p0tWNB5HwMG/c3yYuORSkuKL0g0LtpNvuY984hM347bLwHJCUEV9y'
WHERE user_id = 3;

UPDATE user
SET password = '$2a$10$WRSwNI.fPYR8Tuks0sfRyuS3C1ZBeDjC9G.CBIxggAGJMRtJBEWHK'
WHERE user_id = 4;

UPDATE user
SET password = '$2a$10$syWLAZM1b8wCkpKS/mBvWuvbLY7AKtE8AUPg7Wz0m21VZHf7yw8Iq'
WHERE user_id = 5;

-- $2a$10$J0Prd.v5tz3DUucm5eDnwORHSSucV3Nve.a4/grjj8n1K5wrwMABq
-- $2a$10$p0tWNB5HwMG/c3yYuORSkuKL0g0LtpNvuY984hM347bLwHJCUEV9y
-- $2a$10$syWLAZM1b8wCkpKS/mBvWuvbLY7AKtE8AUPg7Wz0m21VZHf7yw8Iq
