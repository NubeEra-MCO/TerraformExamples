from sklearn.model_selection import train_test_split

# Split the data
train_data, test_data = train_test_split(df, test_size=0.2, random_state=42)

# Save the train and test data as CSV files
train_data.to_csv('train.csv', index=False)
test_data.to_csv('test.csv', index=False)