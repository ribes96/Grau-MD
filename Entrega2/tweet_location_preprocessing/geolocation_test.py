#!/usr/bin python3.6
# -*- coding: utf-8 -*-

from pygeocoder import Geocoder
from pygeolib import GeocoderError as GeocoderError

LOCATION = 'Laniakea'

try:
    print(Geocoder.geocode(LOCATION))
except GeocoderError as e:
    print(e)