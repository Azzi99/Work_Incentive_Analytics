-- Create a join table combining Absenteeism_at_work, compensation, and Reasons tables
SELECT * FROM Absenteeism_at_work a
LEFT JOIN compensation b ON a.ID = b.ID
LEFT JOIN Reasons r ON a.Reason_for_absence = r.Number;

-- Find the healthiest employees based on certain criteria
-- Employees who are non-social drinkers, non-social smokers, have a BMI less than 25, and absenteeism hours lower than the average.
SELECT * FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25 AND 
Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work);

-- Calculate the number of non-smokers for a compensation rate increase
-- Budget of $983,221 and an hourly increase of $0.68, determine the additional compensation that can be allocated to non-smokers annually.
SELECT COUNT(*) AS nonsmokers FROM Absenteeism_at_work
WHERE Social_smoker = 0;

-- Optimize this query to provide relevant employee information with BMI categories and season names
SELECT
    a.ID,
    r.Reason,
    Month_of_absence,
    Body_mass_index,
    -- Classify employees into BMI categories (Underweight, Healthy, Overweight, Obese)
    CASE 
        WHEN Body_mass_index < 18.5 THEN 'Underweight'
        WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy'
        WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
        WHEN Body_mass_index > 30 THEN 'Obese'
        ELSE 'Unknown'
    END AS BMI_Category,
    -- Classify months of absence into seasons (Winter, Spring, Summer, Fall)
    CASE 
        WHEN Month_of_absence IN (12, 1, 2) THEN 'Winter'
        WHEN Month_of_absence IN (3, 4, 5) THEN 'Spring'
        WHEN Month_of_absence IN (6, 7, 8) THEN 'Summer'
        WHEN Month_of_absence IN (9, 10, 11) THEN 'Fall'
        ELSE 'Unknown'
    END AS Season_Names,
    Month_of_absence,
    Day_of_the_week,
    Transportation_expense,
    Education,
    son,
    Social_drinker,
    Social_smoker,
    Pet,
    Disciplinary_failure,
    Age,
    Work_load_Average_day,
    Absenteeism_time_in_hours
FROM Absenteeism_at_work a
-- Left join with compensation table (Note: Check if this join is necessary based on the analysis requirements)
LEFT JOIN compensation b ON a.ID = b.ID
-- Left join with Reasons table (Note: Check if this join is necessary based on the analysis requirements)
LEFT JOIN Reasons r ON a.Reason_for_absence = r.Number;
