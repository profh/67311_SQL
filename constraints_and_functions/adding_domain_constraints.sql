-- Assuming the table is already created w/o constraints, they are easily added afterwards

-- EMAIL CONSTRAINT ON SUPERHERO PEOPLE TABLE
ALTER TABLE people ADD CONSTRAINT validate_email CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');


-- SIMPLE CHECK ON HEIGHT & WEIGHT
ALTER TABLE people ADD CHECK (height > 0);
ALTER TABLE people ADD CHECK (weight BETWEEN 1 AND 400);