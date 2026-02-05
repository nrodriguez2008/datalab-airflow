FROM apache/airflow:2.8.0-python3.10

# Copy DAGs only (plugins folder optional)
COPY ./dags /opt/airflow/dags

# Create empty plugins folder so Airflow doesn't complain
RUN mkdir -p /opt/airflow/plugins

# Permissions
USER root
RUN chown -R airflow: /opt/airflow
USER airflow

# Start Airflow with DB initialization
CMD ["bash", "-c", "airflow db init && airflow webserver"]
