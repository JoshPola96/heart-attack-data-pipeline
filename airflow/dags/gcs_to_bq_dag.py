from airflow import DAG
from airflow.providers.google.cloud.transfers.local_to_gcs import LocalFilesystemToGCSOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.utils.dates import days_ago
from airflow.operators.python import PythonOperator
import os

# GCP Settings
GCP_CONN_ID = "google_cloud_default"
GCP_PROJECT_ID = "heart-attack-dataset"
BUCKET_NAME = "heart-attack-dataset-data-lake"
BQ_DATASET = "heart_attack_dataset"
BQ_TABLE = "heart_attack_data"
CSV_FILE = "heart_attack_prediction_indonesia.csv"

# Default DAG Arguments
default_args = {
    "owner": "airflow",
    "start_date": days_ago(1),
    "depends_on_past": False,
}

# Define DAG
with DAG(
    dag_id="gcs_to_bq_dag",
    default_args=default_args,
    schedule_interval="@daily",
    catchup=False,
) as dag:

    # Upload CSV from local data folder to GCS
    upload_to_gcs = LocalFilesystemToGCSOperator(
        task_id="upload_csv_to_gcs",
        src=os.path.join("/home/josh/heart-attack-prediction/data", CSV_FILE),  # Adjust path
        dst=f"raw/{CSV_FILE}",
        bucket=BUCKET_NAME,
        gcp_conn_id=GCP_CONN_ID,
    )

    # Load data from GCS into BigQuery
    load_gcs_to_bq = GCSToBigQueryOperator(
        task_id="load_gcs_to_bq",
        bucket=BUCKET_NAME,
        source_objects=[f"raw/{CSV_FILE}"],
        destination_project_dataset_table=f"{GCP_PROJECT_ID}.{BQ_DATASET}.{BQ_TABLE}",
        source_format="CSV",
        skip_leading_rows=1,
        write_disposition="WRITE_TRUNCATE",
        gcp_conn_id=GCP_CONN_ID,
    )

    # DAG Task Dependencies
    upload_to_gcs >> load_gcs_to_bq
