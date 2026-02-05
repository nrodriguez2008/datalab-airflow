FROM apache/airflow:2.8.0

USER airflow

COPY dags/ /opt/airflow/dags/

ENV AIRFLOW__WEBSERVER__WEB_SERVER_PORT=8080

CMD bash -c "airflow db init && airflow webserver"
