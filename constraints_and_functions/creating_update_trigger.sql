-- Building a trigger for automatically handling logic for completed tasks and 
-- automatically incrementing the summary field tasks_completed in users table.
--
-- See http://www.postgresql.org/docs/9.3/static/plpgsql-trigger.html for more help

-- Step 1: create a trigger function that updates the user table
CREATE FUNCTION update_completed() RETURNS TRIGGER AS $$
	DECLARE


	BEGIN




	END;
	$$ LANGUAGE plpgsql;


-- Step 2: call that trigger function whenever a task is updated
CREATE TRIGGER increment_completed_count
AFTER -- ...
FOR EACH ROW
WHEN -- ...
EXECUTE PROCEDURE update_completed();