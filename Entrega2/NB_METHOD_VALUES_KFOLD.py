# -*- coding: utf-8 -*-

# 1. Load Modules and Libraries

import numpy as np  # Llibreria matemàtica
import pandas as pd
import sklearn # Llibreria de DM
#import sklearn.cross_validation as cv # Pel Cross-validation
import sklearn.model_selection as cv    # Pel Cross-validation
from sklearn.naive_bayes import GaussianNB # Pel Naive Bayes

# 2. Load the dataset

twigen = pd.read_csv("datapreprocessed.csv", encoding='latin1')
twigen.head()


# 3. Pre-processing

def expand_categoric_column_with_binary_values(column_name):
    global twigen
#    print(column_name)
#    print(twigen[column_name].unique())
    twigen = pd.concat([
            twigen.drop(column_name, axis=1),
            pd.get_dummies(twigen[column_name], prefix=column_name)
        ], axis=1)
    
expand_categoric_column_with_binary_values('created')
expand_categoric_column_with_binary_values('tweet_created')
expand_categoric_column_with_binary_values('link_color')
expand_categoric_column_with_binary_values('sidebar_color')
expand_categoric_column_with_binary_values('tweet_location')
expand_categoric_column_with_binary_values('user_timezone')

twigen.head()

# Convert boolean columns to binary values

def boolean_to_binary(column_name):
    global twigen
    twigen[column_name] = twigen[column_name].apply(lambda boolean: int(boolean))

twigen.tweet_coord.sum()

# Separate data from labels

labels = twigen.gender.apply(lambda g: 0 if g == 'male' else(1 if g == 'female' else 2))
data = twigen.drop('gender', axis=1)

print(data.shape)
data.head()

# 4. K-Fold Cross-Validation

#kf = cv.KFold(len(data), n_folds=10)
kf = cv.KFold(n_splits=10)

a_s = [] # Accuracy
c_m = [] # Confusion Matrix

for train_index, test_index in kf.split(data):
    
    # Split
    
    data_train, data_test = pd.core.frame.DataFrame(data,index = train_index), pd.core.frame.DataFrame(data,index = test_index)
    labels_train, labels_test = pd.Series(labels,index = train_index, dtype = np.int64), pd.Series(labels,index = test_index, dtype = np.int64)
    
    # Training
    #data_train.info()
    twigen.iloc[data_train.head().index]
    
    # Testing
    #data_test.info()
    twigen.iloc[data_test.head().index]
    
    # Fitting
    gnb = GaussianNB()
    gnb.fit(data_train, labels_train)
    pred = gnb.predict(data_test)
    c_m.append(sklearn.metrics.confusion_matrix(labels_test,pred))
    a_s.append(sklearn.metrics.accuracy_score(labels_test,pred))

print("ACCURACY SCORE")
print("MEAN "+str(sum(a_s) / kf.n_splits))
print("MAX  "+str(max(a_s)))
print("MIN  "+str(min(a_s)))
