FROM apache/airflow:2.8.0

USER root

# Install system dependencies required for pandas & scikit-learn
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        python3-dev \
        libatlas-base-dev \
        gfortran && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
        minio \
        boto3 \
        pandas \
        scikit-learn

USER airflow

COPY dags/ /opt/airflow/dags/

ENV AIRFLOW__WEBSERVER__WEB_SERVER_PORT=8080

# Initialize DB and start Airflow
CMD bash -c "airflow db init && airflow webserver"
