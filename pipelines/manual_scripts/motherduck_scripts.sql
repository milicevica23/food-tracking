
INSTALL gsheets FROM community;
LOAD gsheets;
INSTALL crypto FROM community;;
LOAD crypto;


CREATE OR REPLACE SECRET (
    TYPE gsheet, 
    PROVIDER key_file, 
    FILEPATH ''
);

CREATE OR REPLACE TABLE memory.food_tracker AS FROM read_gsheet('https://docs.google.com/spreadsheets/d/1EKqY5sNCD3Fo57JdP8Lq4XZ4xLNcCG1ZQ_FuZbCwTfM/edit');

FROM memory.food_tracker;

CREATE OR REPLACE VIEW memory.food_tracker_view AS 
SELECT
	strptime(t."Timestamp", '%d/%m/%Y %H:%M:%S') AS insert_timestamp,
	t."Picture of your food" as picture_link,
	t."Food name" as food_name,
    t."Email address" as user_email,
    sha256(t."Email address") as user_hash_id,
    CAST(t."How much impact had your meal on your mental/physical state?" AS INT) AS state_point, 
	CAST(t."How sleepy or tired do you feel after your meal?" AS INT) as sleep_point,
	CAST(t."How is your stomach after the meel?" AS INT) as stomach_point,
	CAST(t."How swollen are your fingers?" AS INT) as finger_point,
	t,"Are there any known allergens? [Allergens]" as allergens,
	t."Each ingredient list separated by coma" as ingredient_list
FROM food_tracker t;

FROM memory.food_tracker_view;


ATTACH OR REPLACE 'md:food_tracker_db' as food_tracker_db;
USE food_tracker_db;

CREATE OR REPLACE TABLE food_table as SELECT * from memory.food_tracker_view;
CREATE OR REPLACE VIEW food_table_view as SELECT * EXCLUDE(user_email) from food_table;

FROM food_table;

CREATE OR REPLACE TABLE food_table_ingredients_flat AS
SELECT
    t.user_hash_id,
    t.insert_timestamp,
    t.state_point,
	t.sleep_point,
	t.stomach_point,
	t.finger_point,
    TRIM(unnest) AS ingredient
FROM memory.food_tracker_view t
CROSS JOIN LATERAL unnest(string_to_array(regexp_replace(t.ingredient_list, ',$', ''), ',')) AS item
WHERE unnest <> '';

CREATE OR REPLACE TABLE food_table_allergens_flat AS
SELECT
    t.user_hash_id,
    t.insert_timestamp,
    t.state_point,
	t.sleep_point,
	t.stomach_point,
	t.finger_point,
    TRIM(unnest) AS allergen
FROM memory.food_tracker_view t
CROSS JOIN LATERAL unnest(string_to_array(regexp_replace(t.allergens, ',$', ''), ',')) AS item
WHERE unnest <> '';



