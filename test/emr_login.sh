#!/bin/sh

echo '========================='
echo '  Copy Script to Master  '
echo '========================='
scp -i EMR_SERVER_KEY.cer db_pdm_demo_paralel.py hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal:/opt/data
scp -i EMR_SERVER_KEY.cer db_pdm_demo_serial.py hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal:/opt/data
scp -i EMR_SERVER_KEY.cer csv_pdm_demo_paralel.py hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal:/opt/data
scp -i EMR_SERVER_KEY.cer csv_pdm_demo_serial.py hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal:/opt/data
scp -i EMR_SERVER_KEY.cer activity_analytics.csv hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal:/opt/data
scp -i EMR_SERVER_KEY.cer spark_job.sh hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal:/opt/data
scp -i EMR_SERVER_KEY.cer emr_login.sh hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal:/opt/data
echo '- DONE -'
echo ''

echo '====================='
echo '  Copy Script to S3  '
echo '====================='
aws s3 cp db_pdm_demo_paralel.py s3://[BUCKET_NAME]/
aws s3 cp db_pdm_demo_serial.py s3://[BUCKET_NAME]/
aws s3 cp csv_pdm_demo_paralel.py s3://[BUCKET_NAME]/
aws s3 cp csv_pdm_demo_serial.py s3://[BUCKET_NAME]/
aws s3 cp activity_analytics.csv s3://[BUCKET_NAME]/
aws s3 cp spark_job.sh s3://[BUCKET_NAME]/
aws s3 cp emr_login.sh s3://[BUCKET_NAME]/
echo '- DONE -'
echo ''

echo '======================'
echo ' SSH Login to Master  '
echo '======================'
ssh -i EMR_SERVER_KEY.cer hadoop@ip-64-0-8-111.ap-southeast-1.compute.internal
echo '-- ALL DONE --'
echo ''