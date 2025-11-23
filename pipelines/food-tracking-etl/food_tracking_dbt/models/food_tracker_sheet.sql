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
FROM read_gsheet('https://docs.google.com/spreadsheets/d/1EKqY5sNCD3Fo57JdP8Lq4XZ4xLNcCG1ZQ_FuZbCwTfM/edit') t