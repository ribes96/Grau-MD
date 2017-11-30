
# -*- coding: utf-8 -*-

# 1. Load Modules and Libraries

import numpy as np  # Llibreria matemàtica
import pandas as pd
import sklearn # Llibreria de DM
import sklearn.cross_validation as cv # Pel Cross-validation
from sklearn.naive_bayes import GaussianNB # Pel Naive Bayes

# 2. Load the dataset

twigen = pd.read_csv("dataWithTextWordsPrep.csv", encoding='latin1')
twigen.head()


# 3. Pre-processing

twigen = twigen.drop(['_unit_id', '_golden', '_unit_state', '_trusted_judgments', '_last_judgment_at',
               'gender:confidence', 'profile_yn', 'profile_yn:confidence', 'created', 'description',
               'fav_number', 'gender_gold', 'link_color', 'name', 'profile_yn_gold', 'profileimage',
               'sidebar_color', 'text', 'tweet_count', 'tweet_created', 'tweet_id', 'tweet_location',
               'retweet_count', 'tweet_coord', 'user_timezone'], axis=1);
twigen = twigen[twigen.gender.notnull()]
twigen.head()

# Separate data from labels

def genderToNumeric(gender) :
    if gender == 'male' :
        return 0
    elif gender == 'female' :
        return 1
    else :
        return 2

labels = twigen.gender.apply(lambda g: genderToNumeric(g))

data = twigen.drop('gender', axis=1)

#print(data.shape)
#data.head()

# 4. K-Fold Cross-Validation

kf = cv.KFold(len(data), n_folds=10)

a_s = [] # Accuracy
c_m = [] # Confusion Matrix


for train_index, test_index in kf:
    
    # Split
    
    data_train, data_test = pd.core.frame.DataFrame(data,index = train_index, dtype = np.int64), pd.core.frame.DataFrame(data,index = test_index, dtype = np.int64)
    labels_train, labels_test = pd.Series(labels,index = train_index, dtype = np.int64), pd.Series(labels,index = test_index, dtype = np.int64)
    
    # Training
#    data_train.info()
    twigen.iloc[data_train.head().index]
    
    # Testing
#    data_test.info()
    twigen.iloc[data_test.head().index]
    
    # Fitting
    gnb = GaussianNB()
    gnb.fit(data_train, labels_train)
    pred = gnb.predict(data_test)
    c_m.append(sklearn.metrics.confusion_matrix(labels_test,pred))
    a_s.append(sklearn.metrics.accuracy_score(labels_test,pred))

print("ACCURACY SCORE")
print("MEAN "+str(sum(a_s) / kf.n_folds))
print("MAX  "+str(max(a_s)))
print("MIN  "+str(min(a_s)))
