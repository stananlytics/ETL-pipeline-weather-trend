# Local data engineering stack

This Compose project runs PostgreSQL for project data and Apache Airflow for ETL scheduling. Airflow uses a separate `airflow` database in the same PostgreSQL server. Local credentials are kept in the ignored `.env` file.

## Start

From this folder, run these commands in the VS Code terminal:

```powershell
docker compose up -d postgres
docker compose run --rm airflow-init
docker compose up -d
```

Open Airflow at <http://localhost:8080>. Sign in with `AIRFLOW_ADMIN_USERNAME` and `AIRFLOW_ADMIN_PASSWORD` from `.env`. Connect database tools to PostgreSQL at `localhost:5433`.

The first command creates the PostgreSQL databases and Airflow role if the data volume is new. `airflow-init` runs the Airflow database migrations and creates the UI user. Keep `.env` private; the example file is only a template.

Open the Stanalytics Weather Check dashboard at <http://127.0.0.1:5000>. Choose English, French, or Spanish, then create a local account with your name, email, team, and a password of at least 12 characters. Passwords are stored as hashes in PostgreSQL; signing in creates a local session. Set a unique, private random `WEATHER_UI_SECRET_KEY` in `.env` before starting the dashboard so sessions remain signed securely across restarts. The app reads the latest saved weather records from the `de_practice` database. Run the `weather_etl` DAG in Airflow to update the dashboard data.

## Weather ETL

Add your OpenWeatherMap API key as `OPENWEATHER_API_KEY` in `.env`, then restart the Airflow services with `docker compose up -d`. The root `weather_etl.py` file is mounted into Airflow's DAG folder. In the Airflow UI, enable and trigger the `weather_etl` DAG to fetch current weather for the configured UK cities and upsert each city's daily observation into the `public.weather` table.
