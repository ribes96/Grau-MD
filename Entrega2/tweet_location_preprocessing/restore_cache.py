#!/usr/bin python3.6
# -*- coding: utf-8 -*-

import pandas as pd
import string
import json

ENCODING = 'latin1'
PRINTABLE = set(string.printable)

CACHE_FILE = 'gender-classifier-tweet-location-preprocessed-cache.json'
CSV = 'gender-classifier-tweet-location-preprocessed-0-18933.csv'

ROW_START = 0
ROW_END = 1205

twigen = pd.read_csv("../gender-classifier-DFE-791531.csv", encoding=ENCODING)
twigen = twigen.drop(twigen[twigen.gender == 'unknown'].index)

def is_printable(character):
    return character in PRINTABLE

tweet_location = twigen[ROW_START : ROW_END].tweet_location.apply(lambda location: ''.join(filter(is_printable, str(location).lower())).strip()).as_matrix()
geolocation_country = pd.read_csv(CSV, encoding=ENCODING)[ROW_START : ROW_END].tweet_location.as_matrix()

print(tweet_location)
print(geolocation_country)

geolocation_cache = {}

for k, v in zip(tweet_location, geolocation_country):
    geolocation_cache[str(k)] = v

json.dump(geolocation_cache, open(CACHE_FILE, 'w'), sort_keys=True, indent=4)