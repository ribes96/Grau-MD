#!/usr/bin python3.6
# -*- coding: utf-8 -*-

from pygeocoder import Geocoder
from pygeolib import GeocoderError as GeocoderError
import numpy as np
import pandas as pd
import time
import string
import json

ENCODING = 'latin1'
LIMIT = 2500
PRINTABLE = set(string.printable)

print('Loading CSV...')

twigen = pd.read_csv("../gender-classifier-DFE-791531.csv", encoding=ENCODING)
twigen = twigen.drop(twigen[twigen.gender == 'unknown'].index)

total_rows = len(twigen)
ROW_START = 0
ROW_END = total_rows

limited = False
time_sum = 0
geolocated_rows = 0
cached_rows = 0
row_counter = ROW_START
twigen = twigen[ROW_START : ROW_END]
total_rows = len(twigen.tweet_location)
null_rows = twigen.tweet_location.isnull().sum()
rows_to_geolocate = total_rows - null_rows

print(f'Total rows: {total_rows}')
print(f'Rows without tweet_location: {null_rows}')
print(f'Rows to geolocate: {rows_to_geolocate}\n')

CACHE_FILE = 'gender-classifier-tweet-location-preprocessed-cache.json'
try:
    geolocation_cache = json.load(open(CACHE_FILE, 'r'))
    print('Loaded Geolocation Cache\n')
except FileNotFoundError:
    geolocation_cache = {}

start = time.perf_counter()

def format_time(seconds):
    seconds = int(seconds)
    result = ''
    def append_unit(unit_time, unit):
        nonlocal result
        if unit_time > 0:
            result += f'{unit_time}{unit} '
    hours = seconds // 3600
    append_unit(hours, 'h')
    seconds %= 3600
    minutes = seconds // 60
    append_unit(minutes, 'm')
    seconds %= 60
    append_unit(seconds, 's')
    result = result.strip()
    return '0s' if result == '' else result

def is_printable(character):
    return character in PRINTABLE

def geolocation(location):
    global row_counter, geolocated_rows

    result = 'Unknown'

    def geolocate():
        global limited, geolocated_rows, cached_rows
        nonlocal result
        if location in geolocation_cache:
            print('Geolocation CACHED')
            result = geolocation_cache[location]
            cached_rows += 1
        elif not limited:
            try:
                country = Geocoder.geocode(location).country # NOTE THIS IS NETWORK TIME COSUMING
                if country is not None:
                    result = str(country)
                    geolocation_cache[location] = result
            except GeocoderError as e:
                if 'ZERO' not in str(e) and 'OVER_QUERY_LIMIT' in str(e):
                    limit_warning = f'\n[Row {row_counter}] OVER_QUERY_LIMIT after {geolocated_rows} locations processed (CACHED: {cached_rows})\n'
                    limited = (geolocated_rows - cached_rows) > LIMIT
                    print(limit_warning)
                    if limited:
                        open(f'gender-classifier-tweet-location-preprocessed-{ROW_START}-{ROW_END}-LIMITED.log', 'w+').write(limit_warning)
                        input('From now on all non-cached locations will be set as Unknown. Press to continue...')
                    else:
                        geolocation_cache[location] = result
        geolocated_rows += 1

    if not pd.isnull(location):
        location = ''.join(filter(is_printable, location.lower())).strip()
        print(f'tweet_location: {location}')
        geolocate()
        print(f'GEOLOCATION: {result}')
        remaining_rows_to_geolocate = rows_to_geolocate - geolocated_rows
        time_sum = time.perf_counter() - start
        mean_time_geolocation = time_sum / geolocated_rows
        print(f'[Row {row_counter}] Remaining rows to geolocate: {remaining_rows_to_geolocate}')
        print(f'{format_time(time_sum)} elapsed.\tRemaining: ~{format_time(remaining_rows_to_geolocate * mean_time_geolocation)}\n')

    row_counter += 1
    return result

twigen.tweet_location = twigen.tweet_location.apply(geolocation)

print(f'FINISHED. Writing to CSV...')

twigen.to_csv(f'gender-classifier-tweet-location-preprocessed-{ROW_START}-{ROW_END}.csv', encoding=ENCODING)
json.dump(geolocation_cache, open(CACHE_FILE, 'w+'), sort_keys=True, indent=4)
