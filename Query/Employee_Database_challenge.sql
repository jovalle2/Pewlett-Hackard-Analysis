-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT em.emp_no, 
em.first_name,
em.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO retirement_titles
FROM employees as em
INNER JOIN titles AS ti
ON (em.emp_no = ti.emp_no)
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY em.emp_no;


-- Create unique_title csv
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
titles

INTO unique_title
FROM retirement_titles
WHERE to_date <> ('9999-01-01')
ORDER BY emp_no, to_date DESC;

-- retrieve the number of titles from the Unique Titles table.
SELECT COUNT (title)
FROM unique_title

--Create the retiring_titles table
	SELECT COUNT (unique_title.title), title
	INTO retiring_titles
	FROM unique_title
	GROUP BY unique_title.title
	ORDER BY unique_title.title DESC;

SELECT * FROM retiring_titles
ORDER BY count DESC