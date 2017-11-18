#!/usr/bin python3.6
# -*- coding: utf-8 -*-

import pandas as pd
import string
import json

ENCODING = 'latin1'
PRINTABLE = set(string.printable)

CACHE_FILE = 'gender-classifier-tweet-location-preprocessed-cache.json'
CSV = 'gender-classifier-tweet-location-preprocessed-0-18933.csv'

twigen = pd.read_csv("../gender-classifier-DFE-791531.csv", encoding=ENCODING)
twigen = twigen.drop(twigen[twigen.gender == 'unknown'].index)

def is_printable(character):
    return character in PRINTABLE

confirmation = input(f'Se modificará el fichero {CACHE_FILE} con los datos procesados de tweet_location de {CSV}.\
    \n¿Estás seguro? [y/N] ')

if confirmation != 'y':
    print('Cancelled')
    exit()

tweet_location = twigen.tweet_location.apply(lambda location: ''.join(filter(is_printable, str(location).lower())).strip()).as_matrix()
geolocation_country = pd.read_csv(CSV, encoding=ENCODING).tweet_location.as_matrix()

print(tweet_location)
print(geolocation_country)

geolocation_cache = {}

for k, v in zip(tweet_location, geolocation_country):
    geolocation_cache[str(k)] = v

json.dump(geolocation_cache, open(CACHE_FILE, 'w'), sort_keys=True, indent=4)