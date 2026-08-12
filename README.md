# **Heart Attack Prediction in Indonesia - Data Engineering Zoomcamp - [GitHub](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main)**

> **Scope** · Capstone for the [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) (DataTalksClub) — peer-reviewed against a published rubric. [Certificate](https://certificate.datatalks.club/dezoomcamp/2025/c8e8b5ba3fbcfde9632b6c623269ae4bbde4a2d2.pdf)
>
> **Committed on purpose:** sample data under `data/` is included so the pipeline runs end to end without external credentials. It inflates the clone size; that is a deliberate trade for reproducibility.

## 📌 **Project Overview**
This project builds an **end-to-end data pipeline** for analyzing heart attack prediction in Indonesia. Using **Google Cloud Platform (GCP)** and various **data engineering tools**, the pipeline automates data ingestion, transformation, and visualization to provide insights via **Power BI dashboards**.

---

## 🔍 **Problem Description**
Cardiovascular diseases, including heart attacks, are a leading cause of death worldwide. This project automates the **processing, transformation, and visualization** of a dataset related to **heart attack prediction in Indonesia** using cloud-based infrastructure. The goal is to help identify **risk factors and trends** through data analytics.

---

## 🛠️ **Tech Stack**
- **Cloud Infrastructure:** Terraform (GCP setup)  
- **Data Orchestration:** Apache Airflow (Google Cloud Composer)  
- **Storage & Processing:** Google Cloud Storage (GCS) & BigQuery  
- **Data Transformation:** dbt (data modeling)  
- **Dashboarding:** Power BI  
- **CI/CD:** GitHub Actions  
- **Scripting & Automation:** Python & Bash  

---

## 🚀 **Project Workflow**
The pipeline consists of **automated scripts** located in the `scripts/` folder, which handle every stage of the workflow:

1️⃣ **Setup the Virtual Environment & Install Dependencies**  
2️⃣ **Download & Extract Dataset**  
3️⃣ **Deploy Cloud Infrastructure (Terraform)**  
4️⃣ **Configure Airflow & Authenticate with Google Cloud**  
5️⃣ **Run Data Transformation with dbt**  
6️⃣ **Analyze and Visualize Data using Power BI**  

---

## 📂 **Project Structure**
```
heart-attack-prediction/
│── terraform/        # Infrastructure as Code (Terraform)
│── airflow/          # Airflow DAGs for orchestration
│── data/             # Raw and processed dataset storage
│── dbt/              # dbt models for transformation
│── powerbi/          # Power BI dashboards
│── scripts/          # Helper scripts (data ingestion, automation)
│── service-account-key/  # Store your GCP service account JSON key
│── .github/          # GitHub Actions for CI/CD
│── requirements.txt  # Python dependencies
│── README.md         # Project documentation
```

---

## 🏗️ **Setup Instructions**

### **1️⃣ Clone the Repository**
```bash
git clone https://github.com/JoshPola96/heart-attack-data-pipeline.git
cd heart-attack-data-pipeline
```

---

### **2️⃣ Setup Python Virtual Environment**
Before running any scripts, set up a virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

**Please take care to install any additional dependencies as you work with the scripts. Apologies for that.**

---

### **3️⃣ Configure Google Cloud Authentication**
Before running Terraform and Airflow, you must set up authentication:

#### **1. Create a Service Account on GCP**
- Navigate to [Google Cloud Console](https://console.cloud.google.com/)
- Go to **IAM & Admin > Service Accounts**
- Create a new service account with the necessary permissions (**BigQuery Admin, Storage Admin, Composer Admin**).
- Generate a **JSON key file** and download it.

#### **2. Move the JSON key file into the project directory**
```bash
mv ~/Downloads/<your-key-file>.json ~/heart-attack-prediction/service-account-key/
```

#### **3. Set the environment variable for authentication**
```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/heart-attack-prediction/service-account-key/<your-key-file>.json
```

---

### **4️⃣ Run the Automation Scripts**
Execute the following scripts in the **scripts/** folder:

#### **Download & Extract Dataset**
```bash
bash scripts/download-dataset.sh
```
This script will download the dataset into the `data/` folder.

---

### **5️⃣ Deploy Cloud Infrastructure (Terraform)**
```bash
bash scripts/execute-terraform.sh
```
This will provision:
- A **Google Cloud Storage (GCS) bucket** for data storage.
- A **BigQuery dataset** for structured data processing.

---

### **6️⃣ Configure Airflow & Upload DAGs**
Before running Airflow, update the **execute-airflow.sh** script with the correct **service account key file path**.

#### **1. Ensure the Service Account Key is in the Correct Location**
Make sure the service account key JSON file is in:
```bash
~/heart-attack-prediction/service-account-key/
```
If needed, rename it to match the expected format:
```bash
mv ~/Downloads/<your-key-file>.json ~/heart-attack-prediction/service-account-key/heart-attack-dataset.json
```

#### **2. Update and Execute the Airflow Setup Script**
Modify the `scripts/execute-airflow.sh` script to ensure it correctly sets up **Google Cloud authentication**:

```bash
#!/bin/bash
set -e

# Activate virtual environment
source ~/heart-attack-prediction/venv/bin/activate

# Set up GCP authentication
export GOOGLE_APPLICATION_CREDENTIALS="~/heart-attack-prediction/service-account-key/<your-key-file>.json"
export AIRFLOW_HOME=~/airflow
```

Run the script:
```bash
bash scripts/execute-airflow.sh
```

---

### **7️⃣ Run dbt Transformations**
Ensure that your `profiles.yml` file is properly configured:
1. Navigate to `~/.dbt/profiles.yml` and update the **service account key path**:
   ```yaml
   bigquery:
     outputs:
       dev:
         type: bigquery
         method: service-account
         project: <YOUR_GCP_PROJECT_ID>
         dataset: <YOUR_BIGQUERY_DATASET>
         threads: 4
         keyfile: ~/heart-attack-prediction/service-account-key/<your-key-file>.json
   ```

2. Run the transformation:
   ```bash
   bash scripts/execute-dbt.sh
   ```

This will clean and transform the dataset in **BigQuery**.

---

### **8️⃣ Power BI Visualization**  
🚨 **Important Note:** Power BI **cannot be fully automated in the free version**. However, you can manually open and interact with the report.  

The **Power BI report (.pbix) file** is available in the `powerbi/` folder. You can also view the generated pdf report with minimal formatting available in the folder.

#### **To View the Report:**
1️⃣ **Download and Install Power BI Desktop** (if not already installed)  
   - [Download Power BI Desktop](https://powerbi.microsoft.com/en-us/desktop/)  
   
2️⃣ **Open the `.pbix` File**  
   - Navigate to the `powerbi/` folder in your local project directory.  
   - Double-click the `.pbix` file to open it in **Power BI Desktop**.  

3️⃣ **Ensure Data Refresh is Enabled**  
   - If prompted, sign in with a **Microsoft Account** to access cloud-based data.  
   - Click **Transform Data → Data Source Settings** and update the **BigQuery credentials** if necessary.  
   - Click **Refresh** in the toolbar to load the latest data from BigQuery.  

4️⃣ **Explore the Visualizations**  
   - Use the built-in charts, tables, and filters to analyze **heart attack risk factors and trends** in Indonesia.  

---

## 🔄 **CI/CD Pipeline (GitHub Actions)**
GitHub Actions is configured to automate:
✅ **Terraform Infrastructure Deployment**  
✅ **Airflow DAG Upload & Scheduling**  
✅ **dbt Transformations Execution**  
🔜 **Power BI Report Updates (Future Scope)**  

---

## 📌 **Future Improvements**
✔️ Implement **Machine Learning models** for predictive analytics.  
✔️ Automate **Power BI dashboard deployment**.  
✔️ Expand dataset to include **more demographic insights**.  

---
