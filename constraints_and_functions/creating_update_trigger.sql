-- Building a trigger for automatically handling logic for completed tasks and 
-- automatically incrementing the summary field tasks_completed in users table.
--
-- See http://www.postgresql.org/docs/9.3/static/plpgsql-trigger.html for more help

-- Step 1: create a trigger function that updates the user table
CREATE FUNCTION update_completed() RETURNS TRIGGER AS $$
	DECLARE
		uid INTEGER;
		last_task INTEGER;
	BEGIN
		last_task = (OLD.task_id);
		uid = (SELECT completed_by FROM tasks WHERE task_id = last_task);
		UPDATE users SET tasks_completed = (tasks_completed + 1) WHERE user_id = uid;
	  RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;

-- Step 2: call that trigger function whenever a task is updated
CREATE TRIGGER increment_completed_count
AFTER UPDATE ON tasks
FOR EACH ROW
WHEN (OLD.completed IS DISTINCT FROM NEW.completed)
-- one alternative condition might be...
-- WHEN (NEW.completed_on IS NOT NULL)
EXECUTE PROCEDURE update_completed();