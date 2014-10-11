-- Create two tests: one that always fails and one that always succeeds 
CREATE OR REPLACE FUNCTION unit_tests.always_fails() RETURNS test_result AS $$
	DECLARE 
		message test_result;
	BEGIN
		IF 1 = 1 THEN
			SELECT assert.fail('This test failed intentionally.') INTO message;
			RETURN message;
		END IF;

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION unit_tests.always_passes() RETURNS test_result AS $$
	DECLARE 
		message test_result;
	BEGIN
		IF 1 = 1 THEN
			SELECT assert.pass('This test passed intentionally.') INTO message;
			RETURN message;
		END IF;

		SELECT assert.ok('End of test.') INTO message;	
		RETURN message;	
	END
$$
LANGUAGE plpgsql;


-- To run tests, call begin() as follows
-- Wrap in transaction to ensure safety (really only necessary if using DML)
BEGIN TRANSACTION;
SELECT * FROM unit_tests.begin();
ROLLBACK TRANSACTION;
