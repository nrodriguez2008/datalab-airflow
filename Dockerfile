FROM apache/airflow:2.8.0-python3.10

# Install any extra packages you need
# RUN pip install <packages>

# Copy your Airflow project (DAGs, plugins, etc.)
COPY ./dags /opt/airflow/dags
COPY ./plugins /opt/airflow/plugins

# Ensure proper permissions
USER root
RUN chown -R airflow: /opt/airflow
USER airflow

# The critical part:
# Use bash -c so Render can run db init AND webserver
CMD ["bash", "-c", "airflow db init && airflow webserver"]
