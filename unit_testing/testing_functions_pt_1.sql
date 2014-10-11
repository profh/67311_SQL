-- Function to test:
--  CREATE OR REPLACE FUNCTION calculate_percent_tasks_completed(pr_id int) RETURNS REAL AS $$
--  	DECLARE
--  		number_of_tasks_total real; -- otherwise dividing int by int yields an int...
--  		number_of_tasks_completed integer;
--  		percent_completed real;
--  	BEGIN
--  		number_of_tasks_total = (select count(*) from tasks where project_id = pr_id);
--  		number_of_tasks_completed = (select count(*) from tasks where completed = true and project_id = pr_id);
--  		percent_completed = number_of_tasks_completed / number_of_tasks_total;
--  	  RETURN percent_completed;
--  	END;
--  	$$ LANGUAGE plpgsql;
	
-- Create two tests: one that fails and one that succeeds 
CREATE OR REPLACE FUNCTION unit_tests.percent_tasks_failure() RETURNS test_result AS $$
	DECLARE 
		message test_result;
		result boolean;
		prj_id integer;
		function_result real;
		number_of_tasks_total integer;
		number_of_tasks_completed real;
		correct_percent real;
	BEGIN
		prj_id = (SELECT project_id FROM tasks LIMIT 1);
		number_of_tasks_total = (SELECT count(*) FROM tasks WHERE project_id = prj_id);
		number_of_tasks_completed = (SELECT count(*) FROM tasks WHERE completed = true AND project_id = prj_id);
		correct_percent = (number_of_tasks_completed / number_of_tasks_total);
		function_result = (SELECT calculate_percent_tasks_completed(prj_id));
		
		SELECT * FROM assert.is_equal(function_result, (correct_percent+0.1)::real) INTO message, result;
		-- b/c the test should fail (we added 0.1 to correct result so it would fail).
		IF result = false THEN
			RETURN message;
		END IF; 

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION unit_tests.percent_tasks_passes() RETURNS test_result AS $$
	DECLARE 
		message test_result;
		result boolean;
		prj_id integer;
		function_result real;
		number_of_tasks_total integer;
		number_of_tasks_completed real;
		correct_percent real;
	BEGIN
		prj_id = (SELECT project_id FROM tasks LIMIT 1);
		number_of_tasks_total = (SELECT count(*) FROM tasks WHERE project_id = prj_id);
		number_of_tasks_completed = (SELECT count(*) FROM tasks WHERE completed = true AND project_id = prj_id);
		correct_percent = (number_of_tasks_completed / number_of_tasks_total);
		function_result = (SELECT calculate_percent_tasks_completed(prj_id));
	
		SELECT * FROM assert.is_equal(function_result, correct_percent) INTO message, result;
		IF result = false THEN
			RETURN message;
		END IF; 

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;
