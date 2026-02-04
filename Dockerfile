FROM apache/airflow:2.8.0

USER root
RUN pip install --no-cache-dir minio boto3 pandas scikit-learn

USER airflow
COPY dags/ /opt/airflow/dags/

ENV AIRFLOW__WEBSERVER__WEB_SERVER_PORT=8080

# Initialize DB and start webserver
CMD bash -c "airflow db init && airflow webserver"
