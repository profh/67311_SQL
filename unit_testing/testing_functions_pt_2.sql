-- An easier and more complete set of tests for calculate_percent_tasks_completed()
-- --------------------------------------------------------------------------------
-- Test that project 1 gives us 25%
CREATE OR REPLACE FUNCTION unit_tests.percent_tasks_quarter_complete() RETURNS test_result AS $$
	DECLARE 
		message test_result;
		result boolean;
		function_result real;
		correct_percent real;
	BEGIN
		correct_percent = 0.25;
		function_result = (SELECT calculate_percent_tasks_completed(1));
	
		SELECT * FROM assert.is_equal(function_result, correct_percent::real) INTO message, result;
		IF result = false THEN
			RETURN message;
		END IF; 

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;


-- Test that project 2 gives us 100%
CREATE OR REPLACE FUNCTION unit_tests.percent_tasks_all_complete() RETURNS test_result AS $$
	DECLARE 
		message test_result;
		result boolean;
		function_result real;
		correct_percent real;
	BEGIN
		correct_percent = 1;
		function_result = (SELECT calculate_percent_tasks_completed(2));
	
		SELECT * FROM assert.is_equal(function_result, correct_percent::real) INTO message, result;
		IF result = false THEN
			RETURN message;
		END IF; 

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;

-- Test that project 5 gives us 0%
CREATE OR REPLACE FUNCTION unit_tests.percent_tasks_none_complete() RETURNS test_result AS $$
	DECLARE 
		message test_result;
		result boolean;
		function_result real;
		correct_percent real;
	BEGIN
		correct_percent = 0;
		function_result = (SELECT calculate_percent_tasks_completed(5));
	
		SELECT * FROM assert.is_equal(function_result, correct_percent::real) INTO message, result;
		IF result = false THEN
			RETURN message;
		END IF; 

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;

-- Test that project 6 gives us NULL
CREATE OR REPLACE FUNCTION unit_tests.percent_tasks_none_exist() RETURNS test_result AS $$
	DECLARE 
		message test_result;
		result boolean;
		function_result real;
	BEGIN
		function_result = (SELECT calculate_percent_tasks_completed(6));
	
		SELECT * FROM assert.is_null(function_result) INTO message, result;
		IF result = false THEN
			RETURN message;
		END IF; 

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;

