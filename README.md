# **Heart Attack Prediction in Indonesia - Data Engineering Zoomcamp - https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main**

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
│── terraform/       # Infrastructure as Code (Terraform)
│── airflow/         # Airflow DAGs for orchestration
│── data/            # Raw and processed dataset storage
│── dbt/             # dbt models for transformation
│── powerbi/         # Power BI dashboards
│── scripts/         # Helper scripts (data ingestion, automation)
│── service-account-key/ # Store your GCP service account JSON key
│── .github/         # GitHub Actions for CI/CD
│── requirements.txt # Python dependencies
│── README.md        # Project documentation
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

**Please take care to install any additional dependancies as you work with the scripts, apolgoies for that**.

---

### **3️⃣ Configure Google Cloud Authentication**
Before running Terraform and Airflow, you must set up authentication:
1. **Create a Service Account on GCP**  
   - Navigate to [Google Cloud Console](https://console.cloud.google.com/)
   - Go to **IAM & Admin > Service Accounts**
   - Create a new service account with the necessary permissions (BigQuery Admin, Storage Admin, Composer Admin).
   - Generate a **JSON key file** and download it.

2. **Move the JSON key file into the project directory:**
   ```bash
   mv <downloaded-key>.json ~/heart-attack-prediction/service-account-key/
   ```

3. **Set the environment variable for authentication:**
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
1. Ensure that the **service account key** is placed in:
   ```
   ~/heart-attack-prediction/service-account-key/
   ```
2. Update Airflow DAG configuration files:
   - If any **file paths** need to be updated, modify the `airflow/dags/` scripts.
3. Deploy DAGs to Cloud Composer:
   ```bash
   bash scripts/execute-airflow.sh
   ```

---

### **7️⃣ Run dbt Transformations**
Before running dbt, ensure that your `profiles.yml` file is properly configured:
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
🚨 **Important Note:** Power BI **cannot be automated in the free version**.  
However, the **Power BI report (.pbix) file** is available in the `powerbi/` folder.

#### **To view the report:**
1. Open **Power BI Desktop**.
2. Connect to **BigQuery** using the **Google BigQuery Connector**.
3. Load the transformed data and generate insights.

---

## 🔄 **CI/CD Pipeline (GitHub Actions)**
GitHub Actions is configured to automate:
✅ **Terraform Infrastructure Deployment**  
✅ **Airflow DAG Upload & Scheduling**  
✅ **dbt Transformations Execution**  
🔜 **Power BI Report Updates (Future Scope)**  

To enable automation, ensure that:
- **Service account credentials** are stored in **GitHub Secrets**.
- The GitHub Actions workflow files in `.github/workflows/` are properly configured.

---

## 📌 **Future Improvements**
✔️ Implement **Machine Learning models** for predictive analytics.  
✔️ Automate **Power BI dashboard deployment**.  
✔️ Expand dataset to include **more demographic insights**.  

---

## 📄 **License**
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## ✉️ **Contact**
For any inquiries, feel free to reach out via **GitHub Issues** or email at **joshpola96@gmail.com**.

---

### **✅ Final Notes**
- The repository has been structured for **easy execution** with all automation scripts in `scripts/`.  
- Ensure that the **service account key** is set up properly.  
- If you face **authentication issues**, re-run the following:  
  ```bash
  export GOOGLE_APPLICATION_CREDENTIALS=~/heart-attack-prediction/service-account-key/<your-key-file>.json
  ```

---
