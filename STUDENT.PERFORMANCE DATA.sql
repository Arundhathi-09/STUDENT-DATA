SELECT * FROM student.student;


-------- TOTAL COUNT OF STUDENTS BASED ON AGES----------

SELECT AGE, COUNT(*) AS TOTAL
FROM STUDENT.STUDENT
GROUP BY AGE
ORDER BY AGE;

--------- TOTAL NO. OF STUDENTS(MALE/FEMALE) BASED ON GENDER--------

SELECT GENDER, COUNT(*) AS TOTAL_COUNT
FROM STUDENT.STUDENT
GROUP BY GENDER
ORDER BY GENDER;

-------------- FEATURE ENGINEERING-----------------


SELECT ETHNICITY,
    CASE 
        WHEN Ethnicity = 0 THEN 'Asian'
        WHEN Ethnicity = 1 THEN 'Black'
        WHEN Ethnicity = 2 THEN 'Hispanic'
        WHEN Ethnicity = 3 THEN 'White'
        WHEN Ethnicity = 4 THEN 'Other'
        ELSE 'Unknown'
    END AS Ethnicity_Decoded,
    FROM STUDENT.STUDENT;
    ALTER TABLE STUDENT.STUDENT ADD COLUMN ETHNICITY_DECODED VARCHAR(30);
    UPDATE STUDENT.STUDENT
    SET ETHNICITY_DECODED =  CASE 
        WHEN Ethnicity = 0 THEN 'Asian'
        WHEN Ethnicity = 1 THEN 'Black'
        WHEN Ethnicity = 2 THEN 'Hispanic'
        WHEN Ethnicity = 3 THEN 'White'
        WHEN Ethnicity = 4 THEN 'Other'
        ELSE 'Unknown'
    END ;


SELECT  
       ParentalEducation,
       CASE 
           WHEN ParentalEducation = 0 THEN 'No Education'
           WHEN ParentalEducation = 1 THEN 'High School'
           WHEN ParentalEducation = 2 THEN 'College'
           WHEN ParentalEducation = 3 THEN 'Bachelor\'s Degree'
           WHEN ParentalEducation = 4 THEN 'Master\'s Degree'
           ELSE 'Unknown'
       END AS Decoded_Parental_Education
FROM STUDENT.STUDENT;
ALTER TABLE STUDENT.STUDENT ADD COLUMN Decoded_Parental_Education VARCHAR(50);
UPDATE STUDENT.STUDENT
SET Decoded_Parental_Education = CASE 
    WHEN ParentalEducation = 0 THEN 'No Education'
    WHEN ParentalEducation = 1 THEN 'High School'
    WHEN ParentalEducation = 2 THEN 'College'
    WHEN ParentalEducation = 3 THEN 'Bachelor\'s Degree'
    WHEN ParentalEducation = 4 THEN 'Master\'s Degree'
    ELSE 'Unknown'
END;




SELECT 
       ParentalSupport,
       CASE 
           WHEN ParentalSupport = 1 THEN 'High'
           WHEN ParentalSupport = 2 THEN 'Medium'
           WHEN ParentalSupport = 3 THEN 'Low'
           ELSE 'Unknown'
       END AS Decoded_Parental_Support
FROM STUDENT.STUDENT;
ALTER TABLE STUDENT.STUDENT ADD COLUMN Decoded_Parental_Support VARCHAR(20);
UPDATE STUDENT.STUDENT
SET Decoded_Parental_Support = CASE 
    WHEN ParentalSupport = 1 THEN 'High'
    WHEN ParentalSupport = 2 THEN 'Medium'
    WHEN ParentalSupport = 3 THEN 'Low'
    ELSE 'Unknown'
END;


SELECT  
       Gradeclass,
       CASE 
           WHEN GradeCLASS >= 4 THEN ' Excellent'
           WHEN Gradeclass >= 3 THEN ' Very Good'
           WHEN Gradeclass >= 2 THEN ' Good'
           WHEN Gradeclass >= 1 THEN ' Average'
           WHEN Gradeclass >= 0 THEN ' Below Average'
           ELSE ' Fail'
       END AS Decoded_Grade_Class
FROM STUDENT.STUDENT;
ALTER TABLE STUDENT.STUDENT ADD COLUMN Decoded_Grade_Class VARCHAR(50);
UPDATE STUDENT.STUDENT
SET Decoded_Grade_Class = CASE 
    WHEN Gradeclass >= 4 THEN ' Excellent'
    WHEN Gradeclass >= 3 THEN ' Very Good'
    WHEN Gradeclass >= 2 THEN ' Good'
    WHEN Gradeclass >= 1 THEN ' Average'
    WHEN Gradeclass >= 0 THEN ' Below Average'
    ELSE ' Fail'
END;

--------------- EDA----------------

SELECT * FROM STUDENT.STUDENT;

SELECT PARENTALSUPPORT, GPA, COUNT(*) TOTAL
FROM STUDENT.STUDENT
WHERE GPA IN ('3.5', '4.0')
GROUP BY PARENTALSUPPORT, GPA
ORDER BY PARENTALSUPPORT, GPA;

-------------- GENDER-WISE GRADECLASS----------

SELECT 
    GENDER, 
    GRADECLASS, 
    COUNT(*) AS GRADE_BY_GENDER
FROM 
    STUDENT.STUDENT
GROUP BY 
    GENDER, GRADECLASS
ORDER BY 
    GENDER,GRADECLASS;


------------- Top Performers----------

SELECT  COUNT(GPA)
FROM Student.STUDENT
WHERE GPA > 3.5
ORDER BY GPA DESC;

--------------- Average Study Time by Grade Class:------------

SELECT GradeClass, AVG(StudyTimeWeekly) AS AvgStudyTime
FROM Student.student
GROUP BY GradeClass;

------------ Gender Distribution in Sports Participation:----------

SELECT Gender, COUNT(*) AS SportsParticipants
FROM Student.student
WHERE Sports = 1
GROUP BY Gender;

-------------- Correlation of Tutoring with GPA:----------

SELECT Tutoring, AVG(GPA) AS AvgGPA
FROM Student.student
GROUP BY Tutoring;


------------- Students with High Absences and Low GPA:---------------

SELECT  Absences, GPA
FROM Student.student
WHERE Absences > 10 AND GPA < 2.0;

 ----------- Highest GPA for Each Age Group----------
 
SELECT Age, MAX(GPA) AS MaxGPA
FROM Student.student
GROUP BY Age
ORDER BY Age;

SELECT Ethnicity, COUNT(*) AS SportsParticipants
FROM Student.student
WHERE Sports = 1
GROUP BY Ethnicity
ORDER BY SportsParticipants DESC;

---------- GPA BASED ON PARENTAL EDUCATION----------
SELECT 
    PARENTALEDUCATION, 
    GPA, 
    COUNT(*) AS TOTAL
FROM student.STUDENT
GROUP BY PARENTALEDUCATION, GPA
ORDER BY PARENTALEDUCATION, GPA;


SELECT 
    PARENTALEDUCATION, 
    CASE
        WHEN GPA BETWEEN 0 AND 1 THEN '0-1'
        WHEN GPA BETWEEN 1 AND 2 THEN '1-2'
        WHEN GPA BETWEEN 2 AND 3 THEN '2-3'
        WHEN GPA BETWEEN 3 AND 4 THEN '3-4'
        ELSE 'Other'
    END AS GPA_Range,
    COUNT(*) AS TOTAL
FROM student.STUDENT
GROUP BY PARENTALEDUCATION, GPA_Range
ORDER BY PARENTALEDUCATION, GPA_Range;

------------ Count for All GPA and Sports Combinations--------

SELECT GPA, Sports, COUNT(*) AS Total
FROM student.STUDENT
WHERE SPORTS = 1 AND GPA > 3.5
GROUP BY GPA, Sports
ORDER BY GPA, Sports;

--------------- Count Students Without Sports Participation-----------

SELECT GPA, COUNT(*) AS Total
FROM student.STUDENT
WHERE Sports IS NULL OR Sports = '0'
GROUP BY GPA
ORDER BY GPA;

SELECT * 
FROM student.STUDENT
WHERE ParentalEducation = 'High School';

SELECT DECODED_PARENTAL_EDUCATION, 
       COUNT(CASE WHEN GPA > 3.0 THEN 1 END) AS HIGH_PERFORMANCE_COUNT
FROM STUDENT.STUDENT
GROUP BY DECODED_PARENTAL_EDUCATION;

SELECT * FROM STUDENT.STUDENT ORDER BY GPA DESC LIMIT 5;


----- Correlation Between Attendance and GPA:--------

SELECT ABSENCES, AVG(GPA) AS Avg_GPA
FROM STUDENT.STUDENT
GROUP BY ABSENCES
ORDER BY ABSENCES;

--------- Parental Support Level and Performance:-----------

SELECT DECODED_Parental_Support, AVG(GPA) AS Avg_GPA
FROM STUDENT.STUDENT
GROUP BY DECODED_Parental_Support;
 
 
 ------- Count Students by Parental Support Level:-------
 
SELECT Decoded_Parental_Support, COUNT(*) AS Total_Students
FROM STUDENT.STUDENT
GROUP BY Decoded_Parental_Support;

------------- Count of Students by Parental Education ----------

SELECT Decoded_Parental_Education, COUNT(*) AS Total_Students
FROM STUDENT.STUDENT
GROUP BY Decoded_Parental_Education;

---------- Average GPA by Parental Education:-----------

SELECT Decoded_Parental_Education, AVG(GPA) AS Avg_GPA
FROM STUDENT.STUDENT
GROUP BY Decoded_Parental_Education;

----------- Count of Students by Grade Class:----------

SELECT Decoded_Grade_Class, COUNT(*) AS Total_Students
FROM STUDENT.STUDENT
GROUP BY Decoded_Grade_Class;

SELECT Decoded_Grade_Class, AVG(GPA) AS Avg_GPA
FROM STUDENT.STUDENT
GROUP BY Decoded_Grade_Class;







