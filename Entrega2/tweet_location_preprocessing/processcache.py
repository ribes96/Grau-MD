from pygeocoder import Geocoder
from pygeolib import GeocoderError as GeocoderError
import numpy as np
import pandas as pd
import time
import string
import json
import pdb

CACHE_FILE = 'gender-classifier-tweet-location-preprocessed-cache.json'
try:
    geolocation_cache = json.load(open(CACHE_FILE, 'r'))
    print('Loaded Geolocation Cache\n')
except FileNotFoundError:
    geolocation_cache = {}
    

CACHE_FILE2 = 'gender-classifier-tweet-location-preprocessed-cache-diego.json'
try:
    geolocation_cache2 = json.load(open(CACHE_FILE2, 'r'))
    print('Loaded Geolocation Cache\n')
except FileNotFoundError:
    geolocation_cache2 = {}

finalcache = {}

for elem in geolocation_cache :
    if elem in geolocation_cache2 :
        if (geolocation_cache2[elem] == "Unknown") :
            finalcache[elem] = geolocation_cache[elem]
        else :
            finalcache[elem] = geolocation_cache2[elem]
    else :
        finalcache[elem] = geolocation_cache[elem];


for elem in geolocation_cache2:
    if elem in geolocation_cache:
        if (geolocation_cache[elem] == "Unknown"):
            finalcache[elem] = geolocation_cache2[elem]
        else:
            finalcache[elem] = geolocation_cache[elem]
    else :
        finalcache[elem] = geolocation_cache2[elem]


CACHE_FILE3 = 'gender-classifier-tweet-location-preprocessed-cache-diego2.json'
json.dump(geolocation_cache, open(CACHE_FILE3, 'w+'), sort_keys=True, indent=4)
