# Import all necessary libraries
# We are going to use pyspark and utilize pandasUDF for the parallel training
#
# install library:
# pip install scikit-learn==0.20.4

import pandas as pd
import joblib

from pyspark.sql import SparkSession

from pyspark.sql.types import StructType, StructField, FloatType, StringType
from pyspark.sql.functions import pandas_udf, PandasUDFType

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

base_model = tree.DecisionTreeClassifier()
schema = StructType([
    StructField("id", StringType()),
    StructField("accuracy", FloatType()),
    StructField("weighted_f1", FloatType()),
    StructField("weightedPrecision", FloatType()),
    StructField("weightedRecall", FloatType())
])

# Wrap the python udf using @pandas_udf
# this wrapped function will be used for parallel training


@pandas_udf(schema, PandasUDFType.GROUPED_MAP)
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

    filename = 'finalized_paralel_model_{}.sav'.format(idx)
    # joblib.dump(base_model, filename, compress=0, protocol=None, cache_size=None)
    joblib.dump(base_model, filename)

    return model_results_test


# Create spark session and load the data into a spark Dataframe
spark = SparkSession.builder \
    .appName("db_parallel_model_training") \
    .getOrCreate()

df = spark.read.format("jdbc").options(**config).load()

# Set all necessary information for the training process
partition_column = ["asset_type"]
target_column = ['status']
feature_column = ["avg_", "max_", "min_", "stddev_", "rng_"]
train_ratio = 0.7

# Call our pandas_udf function using groupby-apply method
# The training proces will be done in parallel fashion instead of serial
partition_result = df.groupBy(partition_column).apply(
    train_model
).toPandas()
