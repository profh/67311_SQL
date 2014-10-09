-- finding which procedural languages your version of postgres has available
SELECT lanname FROM pg_language;


-- function to increment the tasks_created field in users [using only sql]
CREATE OR REPLACE FUNCTION basic_update_created_count(user_id integer) 
	RETURNS void AS
	'UPDATE users SET tasks_created = (tasks_created + 1) WHERE user_id = $1;' 
	LANGUAGE 'sql';
  -- truth is we rarely use sql as the procedural language, plpgsql is prefered.

-- we can run this function with:
-- SELECT update_created_count(12);


-- function to calculate the percent of tasks on a project that are complete [using plpgsql]
CREATE OR REPLACE FUNCTION calculate_percent_tasks_completed(pr_id int) RETURNS REAL AS $$
	DECLARE
		number_of_tasks_total real; -- otherwise dividing int by int yields an int...
		number_of_tasks_completed integer;
		percent_completed real;
	BEGIN
		number_of_tasks_total = (select count(*) from tasks where project_id = pr_id);
		number_of_tasks_completed = (select count(*) from tasks where completed = true and project_id = pr_id);
		percent_completed = number_of_tasks_completed / number_of_tasks_total;
	  RETURN percent_completed;
	END;
	$$ LANGUAGE plpgsql;
	
-- USING THIS FUNCTION...
--
-- (1) select calculate_percent_tasks_completed(4);
--
--   calculate_percent_tasks_completed
--   -----------------------------------
--                                 0.4
--
-- (2) select name as "Project", calculate_percent_tasks_completed(project_id) as "Percent Complete" from projects;
--
--     Project     | Percent Completed
--   --------------+------------------
--    Arbeit       |        0.25
--    BookManager  |           1
--    ChoreTracker |         0.5
--    Proverbs     |         0.4
--   (4 rows)