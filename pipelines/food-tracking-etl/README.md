# Food Tracking ETL

Dagster-based ETL pipeline for the food tracking project, integrating dbt for data transformations.

## Getting Started

### Installing Dependencies

**Option 1: uv (Recommended)**

Ensure [`uv`](https://docs.astral.sh/uv/) is installed by following the [official documentation](https://docs.astral.sh/uv/getting-started/installation/).

Create a virtual environment and install the required dependencies using sync:

```bash
uv sync
```

Then activate the virtual environment:

| OS | Command |
| --- | --- |
| macOS/Linux | `source .venv/bin/activate` |
| Windows | `.venv\Scripts\activate` |

**Option 2: pip**

Create a virtual environment:

```bash
python3 -m venv .venv
```

Activate the virtual environment:

| OS | Command |
| --- | --- |
| macOS/Linux | `source .venv/bin/activate` |
| Windows | `.venv\Scripts\activate` |

Install the required dependencies:

```bash
pip install -e ".[dev]"
```

### Running Dagster

Start the Dagster UI web server:

```bash
dg dev
```

Open http://localhost:3000 in your browser to access the Dagster UI.

## Learn More

- [Dagster Documentation](https://docs.dagster.io/)
- [Dagster University](https://courses.dagster.io/)
- [Dagster Slack Community](https://dagster.io/slack)
