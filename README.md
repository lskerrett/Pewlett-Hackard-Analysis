# Pewlett-Hackard-Analysis

### The challenge for Pewlett-Hackard

Pewlett-Hackard needs to prepare for a  “silver tsunami” as many current employees reach retirement age. For this we have = to  determine the total number of employees per title who will be retiring, and from that list, identify those employees who are eligible to participate in a mentorship program. 

### The method used
To solve this issue, I used SQL to gather, merge and clean the data from 6 data files I was given. There were a few challenges as the information needed to perform this analysis was split between 6 differents csv files. I create new csv. files to join this information in 3 clean - duplicates were removed - easy to read new csv files.

For example I created a new file for mentorship:

            SELECT em.emp_no,em.first_name, em.last_name, 
                t.title AS Title, t.from_date, t.to_date
            INTO challenge_mentor_info
            FROM Employees AS em
            INNER JOIN titles AS t ON em.emp_no = t.emp_no
            INNER JOIN dept_emp AS d ON em.emp_no = d.emp_no
            WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
            AND (d.to_date = '9999-01-01');
           
 ### The data generated
 
One of the limitation of the data is the assumption that every employee will decide to retire at the exact date they should. 
To have better representation we need to include a survey of meaningfull number of employees. 

 ### The ERD mapping at the start of the project
 
 ![QuickDBD-export.png](https://github.com/lskerrett/Pewlett-Hackard-Analysis/blob/master/QuickDBD-export.png)
 
 
 
     
