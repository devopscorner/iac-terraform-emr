#!/bin/sh

export PYSPARK_PYTHON=python3
export HADOOP_CONF_DIR=/etc/hadoop/conf/
export SPARK_HOME=/usr/lib/spark/
export HADOOP_USER_NAME=hadoop
export JDBC_CLASS='postgresql-42.3.3.jar'

get_jdbc() {
  if [ "$JDBC_CLASS" = "" ]; then
    wget https://jdbc.postgresql.org/download/postgresql-42.3.3.jar
  fi
}

running_submit() {
  # spark-submit --master yarn --deploy-mode cluster --executor-memory=4g --conf spark.sql.shuffle.partitions=50 --name $1 $2
  spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name $1 $2
}

main() {
  get_jdbc
  running_submit $1 $2
}

### START HERE ###
main $1 $2


# ==================================
# Automation Script: `spark_job.sh`
# ==================================
## Local
# ./spark_job.sh db-demo-serial ./db_pdm_demo_serial.py
# ./spark_job.sh db-demo-paralel ./db_pdm_demo_paralel.py

## S3 Object
# ./spark_job.sh db-demo-serial s3a://[BUCKET_NAME]/db_pdm_demo_serial.py
# ./spark_job.sh db-demo-paralel s3a://[BUCKET_NAME]/db_pdm_demo_paralel.py

# ========================
# Manual: `spark-summit`
# ========================
## Local
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-serial ./db_pdm_demo_serial.py
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-paralel ./db_pdm_demo_paralel.py

## S3 Object
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-serial s3a://[BUCKET_NAME]/db_pdm_demo_serial.py
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-paralel s3a://[BUCKET_NAME]/db_pdm_demo_paralel.py

# =================================================
# Spesific Memory Limits (Manual: `spark-summit`)
# =================================================
## Local
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-serial --executor-memory 4g s3a://[BUCKET_NAME]/db_pdm_demo_serial.py
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-paralel --executor-memory 4g s3a://[BUCKET_NAME]/db_pdm_demo_paralel.py

## S3 Object
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-serial --executor-memory 4g s3a://[BUCKET_NAME]/db_pdm_demo_serial.py
# spark-submit --master yarn --driver-class-path $JDBC_CLASS --deploy-mode cluster --name db-demo-paralel --executor-memory 4g s3a://[BUCKET_NAME]/db_pdm_demo_paralel.py
