# pip install scikit-learn --break-system-packages --no-warn-script-location
# pip install pandas --break-system-packages --no-warn-script-location
# pip install boto3 --break-system-packages --no-warn-script-location
# python3 01.load-data.py
##########################Loading Data to DataFrame ###################
from sklearn.datasets import load_iris
import pandas as pd

# Load the dataset
iris = load_iris()

# Convert to a DataFrame
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['target'] = iris.target

# Preview the dataset
print( df.head() )
###########################Split Data into CSVs(Train, Test) #######################################
from sklearn.model_selection import train_test_split

# Split the data
train_data, test_data = train_test_split(df, test_size=0.2, random_state=42)

# Save the train and test data as CSV files
train_data.to_csv('train.csv', index=False)
test_data.to_csv('test.csv', index=False)




import sagemaker
from sagemaker.amazon.common import write_numpy_to_dense_tensor
import numpy as np

# Write to RecordIO format
train_file = 'train.recordio'
with open(train_file, 'wb') as f:
    write_numpy_to_dense_tensor(f, np.array(train_data.drop(columns=['target'])), np.array(train_data['target']))

# Upload the RecordIO file to S3
s3.upload_file(train_file, bucket_name, 'data/train.recordio')

# aws s3 ls s3://bkt-syed-2024-10-08-06-15-56z/data/train.csv