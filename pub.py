import ssl
import sys
import json
import random
import time
import paho.mqtt.client as mqtt
import paho.mqtt.publish
import numpy as np
import datetime
import psycopg2 as psy
import pandas as pd

conn=psy.connect(host = 'localhost', user= 'postgres', password ='miravila1', dbname= 'FarmatodoInteligente')

client = mqtt.Client("Persona")
peopleInside = []
exitFlag = True
date = datetime.datetime.now()
