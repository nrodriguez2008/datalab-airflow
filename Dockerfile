FROM apache/airflow:2.8.0

USER root

# Install only lightweight dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        python3-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies (NO scikit-learn)
RUN pip install --no-cache-dir \
        minio \
        boto3 \
        pandas

USER airflow

COPY dags/ /opt/airflow/dags/

ENV AIRFLOW__WEBSERVER__WEB_SERVER_PORT=8080

CMD bash -c "airflow db init && airflow webserver"
