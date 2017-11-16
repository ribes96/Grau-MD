#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Nov 14 19:50:55 2017

@author: alcasser
"""

import pandas as pd
from colour import Color
from colorclassifier import Classifier


twigen = pd.read_csv("./gender-classifier-DFE-791531.csv", encoding='latin1')


def hexToColor(hex):
    l = len(hex)
    if (l > 6): return 0
    if (l < 6): hex = hex + '0' * (6 - l)
    rgb = Color('#' + hex).rgb
    i = lambda f: int(round(f))
    return Classifier(rgb = [i(rgb[0]*255), i(rgb[1]*255), i(rgb[2]*255)]).get_name()

twigen['sidebar_color'] = twigen['sidebar_color'].apply(hexToColor)
#Hay 14 colores distintos sin contar los valores del estilo "1.10E+17" para los que se ha puesto "0"
#Son los colores de la libreria Classifier, de los que se elige el más similar.
print(twigen['sidebar_color'].unique())
print(twigen['sidebar_color'])

twigen['link_color'] = twigen['link_color'].apply(hexToColor)

print(twigen['link_color'].unique())
print(twigen['link_color'])


time = lambda t: 'Unknown' if pd.isnull(t) else t
twigen['user_timezone'] = twigen['user_timezone'].apply(time)
print(twigen['user_timezone'])

