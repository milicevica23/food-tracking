# Food Tracking & Health Impact Analysis

A personal health analytics system that tracks food consumption and correlates ingredients/allergens with health outcomes (sleep quality, mental state, stomach health, finger swelling).

![architecture](./documentation/architecture.excalidraw.png)

## Tech Stack

### Data Collection
- **Google Forms** - Survey interface for meal logging
- **Google Sheets** - Central data storage for survey responses

### Data Pipeline
- **Dagster** - Orchestration and workflow automation
- **dbt** - SQL-based data transformations
- **DuckDB** - Local SQL database engine
- **MotherDuck** - Cloud data warehouse

### Analytics & Visualization
- **Evidence.dev** - Interactive BI dashboards
- **GitHub Pages** - Dashboard hosting
- **GitHub Actions** - CI/CD for automated deployment

## Project Structure

```
food-tracking/
├── pipelines/          # Data pipeline (Dagster + dbt)
├── bi/                 # Evidence.dev dashboards
└── documentation/      # Architecture diagrams
```

## Survey Rules

To ensure accurate health impact tracking:
- Log all food consumed in one meal in a single row
- Add self-assessment 1-2 hours after the meal
- Avoid eating other food for at least 3-4 hours after the meal

## Todo

- [x] Introduce Dagster
- [x] Introduce dbt
- [ ] Create separate dashboards for ingredients and allergens
- [ ] Learn about GitHub local CI/CD agent

## Questions

- How to refresh Evidence dashboards from Dagster when dbt models are ready? Currently, data preparation and dashboard deployment happen via the CI/CD pipeline.
