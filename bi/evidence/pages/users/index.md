```sql food_table_total_entries_count
select count(*) 
from motherduck.food_table
```
# User Food Tracking Analysis
This user has total of <Value data={food_table_total_entries_count}/> entries in the food tracking database.




```sql food_table_ingredients_flat_filtered
with cte as (
    select *,
    count(ingredient) over (PARTITION BY ingredient) as ingredient_count
    from motherduck.food_table_ingredients_flat
)
select * from cte
where ingredient_count >= ${inputs.min_ingredient_count}
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
from ${food_table_ingredients_flat_filtered} 
group by ingredient
```

# Ingredient Analysis

<TextInput
    name="min_ingredient_count"
    title="Filter ingredients that appear less than this number of times"
    type="number"
    defaultValue=1
/>

## Sleep analysis by ingredient

```sql sleep_points_by_ingredient
select ingredient as name, average_sleep_point as value
from ${food_table_ingredients_flat_filtered_average_points_by_ingredient}
```

<ECharts config={
    {
      title: {
        text: 'Average Sleep Points by Ingredient',
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
          data: [...sleep_points_by_ingredient],
          breadcrumb: {
            show: false
          }
        }
      ]
      }
    }
/>

## Mental state analysis by ingredient

```sql state_points_by_ingredient
select ingredient as name, average_state_point as value
from ${food_table_ingredients_flat_filtered_average_points_by_ingredient}
```

<ECharts config={
    {
      title: {
        text: 'Average Mental State Points by Ingredient',
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
          data: [...state_points_by_ingredient],
          breadcrumb: {
            show: false
          }
        }
      ]
      }
    }
/>

# Allergens analysis

```sql food_table_allergens_flat_filtered
select *, 
from motherduck.food_table_allergens_flat
where user_hash_id = '${params.user_hash_id}' 
```

```sql food_table_allergens_flat_filtered_average_points 
select
  allergen,
  avg(state_point) as average_state_point,
  count(state_point) as count_state_point,
  avg(sleep_point) as average_sleep_point,
  count(sleep_point) as count_sleep_point,
  avg(stomach_point) as average_stomach_point,
  count(stomach_point) as count_stomach_point,
  avg(finger_point) as average_finger_point,
  count(finger_point) as count_finger_point,
from ${food_table_allergens_flat_filtered} 
group by all
```

```sql allergens_unpivoted
UNPIVOT ${food_table_allergens_flat_filtered_average_points}
ON average_state_point, average_sleep_point, average_stomach_point, average_finger_point
INTO
    NAME state_name
    VALUE average_value;
```


<Heatmap 
    data={allergens_unpivoted} 
    x=allergen 
    y=state_name 
    value=average_value 
/>

