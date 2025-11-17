
# Food Tracking Survey Overview

```sql food_table_count_by_customer
select 
  user_email,
  count(food_name) as number_of_entries
from motherduck.food_table
group by user_email 
```
<DataTable data={food_table_count_by_customer} search=true/>


```sql food_table
select 
  insert_timestamp,
  user_email,
  food_name,
  allergens,
  ingredient_list,
  picture_link
from motherduck.food_table
```

<DataTable data={food_table} search=true/>