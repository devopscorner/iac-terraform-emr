# this script is to run model training in serial fashion
# using python and sklearn library
#
# install library:
# pip install scikit-learn==0.20.4

import pandas as pd
import joblib

from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, FloatType, StringType

## Install scikit-learn==0.20.4
from sklearn import tree

## Import Decision Tree Classifier
# from sklearn.tree import BaseDecisionTree
# from sklearn.tree import DecisionTreeClassifier

from sklearn import metrics
from sklearn.model_selection import train_test_split

config = {'url': 'jdbc:postgresql://[DB_HOST]:5432/db_test',
          'driver': 'org.postgresql.Driver',
          'user': '[DB_USERNAME]',
          'password': '[DB_PASSWORD]',
          'dbtable': 'activity_analytics_combined_label_v2'}

# this udf is used to train your model

def train_model(train_ds):
    idx = str(train_ds[partition_column].unique()[0]).lower()
    X = train_ds[feature_column]
    y = train_ds[target_column]
    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        train_size=train_ratio,
        random_state=42
    )

    base_model.fit(X_train, y_train)

    y_pred_test = base_model.predict(X_test)

    accuracy_test = metrics.accuracy_score(y_test, y_pred_test).tolist()
    f1_test = metrics.f1_score(
        y_test, y_pred_test, average='weighted').tolist()
    precision_test = metrics.precision_score(y_test, y_pred_test,
                                             average='weighted').tolist()
    recall_test = metrics.recall_score(y_test, y_pred_test,
                                       average='weighted').tolist()
    model_results_test = pd.DataFrame(
        [[idx, accuracy_test, f1_test, precision_test, recall_test]],
        columns=["id", "accuracy", "weighted_f1", "weightedPrecision", "weightedRecall"])

    filename = 'finalized_serial_model_{}.sav'.format(idx)
    # joblib.dump(base_model, filename, compress=0, protocol=None, cache_size=None)
    joblib.dump(base_model, filename)

    return model_results_test


# load the data into pandas dataframe
spark = SparkSession.builder \
    .appName("db_serial_model_training") \
    .getOrCreate()

df = spark.read.format("jdbc").options(**config).load()
df = df.toPandas()

# set all necesarry information for the training process
partition_column = ["asset_type"]
target_column = ['status']
feature_column = ["avg_", "max_", "min_", "stddev_", "rng_"]
train_ratio = 0.7
partition_list = list(df[partition_column].unique())

base_model = tree.DecisionTreeClassifier()

# call the train_model function inside the for loop
# the training is done in serial fashion
training_result = pd.DataFrame()
for partition in partition_list:
    sub_df = df.loc[df[partition_column] == partition]
    model_training = train_model(sub_df)
    training_result = pd.concat([training_result, model_training])
