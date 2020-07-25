# test.py
from bottle import Bottle, run
app = Bottle()

import datetime
import mysql.connector

cnx = mysql.connector.connect(user='root', host="db",passwd="123" )

@app.route('/')
def hello():
   print("inicia consulta")
   cursor = cnx.cursor()
   query = ("SELECT schema_name FROM information_schema.schemata; ")
   cursor.execute(query, ())
   data = ""
   for (name) in cursor:
       data += f"{name} <br />"
   cursor.close()
   print("termina consulta")
   return data
run(app, host='0.0.0.0', port=8080)