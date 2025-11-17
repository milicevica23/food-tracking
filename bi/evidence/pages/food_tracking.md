
```sql food_table_ingredients_flat
select * 
from motherduck.food_table_ingredients_flat
```

<Dropdown 
    data={food_table_ingredients_flat} 
    name=user_email
    value=user_email 
    title="Select a User"
    electAllByDefault=true
/>

```sql food_table_ingredients_flat_filtered
select * 
from motherduck.food_table_ingredients_flat
where user_email = '${inputs.user_email.value}'
```

```sql food_table_ingredients_flat_filtered_average_points_by_ingredient
select
  ingredient,
  avg(state_point) as average_state_point,
  count(state_point) as count_state_point,
  avg(sleep_point) as average_sleep_point,
  count(sleep_point) as count_sleep_point,
  avg(stomach_point) as stomach_point,
  count(stomach_point) as count_stomach_point,
  avg(finger_point) as average_finger_point,
  count(finger_point) as count_finger_point,
from motherduck.food_table_ingredients_flat
where user_email = '${inputs.user_email.value}'
group by ingredient
```
## Sleep analysis by ingredient
```sql test_data
select ingredient as name, average_sleep_point as value
from ${food_table_ingredients_flat_filtered_average_points_by_ingredient}
```

<ECharts config={
    {
      title: {
        text: 'Treemap Example',
        left: 'center'
      },
        tooltip: {
            formatter: '{b}: {c}'
        },
      series: [
        {
          type: 'treemap',
          visibleMin: 300,
          label: {
            show: true,
            formatter: '{b}'
          },
          itemStyle: {
            borderColor: '#fff'
          },
          roam: false,
          nodeClick: false,
          data: [...test_data],
          breadcrumb: {
            show: false
          }
        }
      ]
      }
    }
/>



## Total view 
<DataTable data={food_table_ingredients_flat_filtered_average_points_by_ingredient} />



## All elements
<DataTable data={food_table_ingredients_flat_filtered} />

