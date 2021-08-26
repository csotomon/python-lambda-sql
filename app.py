import sys
import pyodbc

def handler(event, context):
    server = 'tcp:testing.database.windows.net' 
    database = 'testing' 
    username = 'adminitrador' 
    password = 'Admin1234' 
    cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
    cursor = cnxn.cursor()

    cursor.execute("SELECT @@version;") 
    row = cursor.fetchone() 
    version = ""
    while row: 
        version = row[0]
        row = cursor.fetchone()

    return f'{version}'
  
