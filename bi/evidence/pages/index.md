
# Food Tracking Survey Overview
<LastRefreshed/>

```sql food_table_count_by_customer
select 
  user_hash_id,
  '/users/' || user_hash_id as user_link,
  count(food_name) as number_of_entries
from motherduck.food_table
group by all
```
<DataTable data={food_table_count_by_customer} link=user_link totalRow=true search=true/>

<LinkButton url="/users">
  Total Users Analysis
</LinkButton>

```sql food_table_count_by_day
select 
  CAST(insert_timestamp AS DATE) insert_day,
  count(user_hash_id) as count_entries
from motherduck.food_table
group by all
```

<CalendarHeatmap 
    data={food_table_count_by_day}
    date=insert_day
    value=count_entries
    title="Entries by Day"
    subtitle="Daily Entries in Food Tracking Survey"
/>


<LineChart 
    data={food_table_count_by_day}
    x=insert_day
    y=count_entries 
    yAxisTitle="Survey entries"
/>