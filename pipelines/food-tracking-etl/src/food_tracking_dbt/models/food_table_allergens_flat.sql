SELECT
    t.user_hash_id,
    t.insert_timestamp,
    t.state_point,
	t.sleep_point,
	t.stomach_point,
	t.finger_point,
    TRIM(unnest) AS allergen
FROM {{ref('food_tracker_sheet')}} t
CROSS JOIN LATERAL unnest(string_to_array(regexp_replace(t.allergens, ',$', ''), ',')) AS item
WHERE unnest <> ''