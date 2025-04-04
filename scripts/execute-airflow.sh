#!/bin/bash
set -e

# Set up GCP authentication
export GOOGLE_APPLICATION_CREDENTIALS="/home/josh/heart-attack-prediction/service-account-key/heart-attack-dataset-35065960d254.json"
export AIRFLOW_HOME=~/airflow

KEYFILE_PATH=$(echo $GOOGLE_APPLICATION_CREDENTIALS)
airflow connections delete google_cloud_default
airflow connections add 'google_cloud_default' \
  --conn-type 'google_cloud_platform' \
  --conn-extra "{\"project\": \"heart-attack-dataset\", \"keyfile_path\": \"$KEYFILE_PATH\"}"

# Execute the DAG tasks directly
cd ~/heart-attack-prediction/airflow/dags
python -c "
from gcs_to_bq_dag import dag
from airflow.models.taskinstance import TaskInstance
import pendulum

dag_run = dag.create_dagrun(
    state='running',
    execution_date=pendulum.now('UTC'),
    run_type='manual'
)

for task_id in ['upload_csv_to_gcs', 'load_gcs_to_bq']:
    task = dag.get_task(task_id)
    print(f'Executing: {task_id}')
    ti = TaskInstance(task=task, run_id=dag_run.run_id)
    ti.run()
    print(f'Complete: {task_id}')
"

echo "ETL process completed!"
