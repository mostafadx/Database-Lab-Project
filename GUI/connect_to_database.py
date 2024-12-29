import pyodbc

def connect_database(server,database,username,password,version):
    connection_string = f'DRIVER={{ODBC Driver {version} for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password};trustServerCertificate=yes'
    connection = pyodbc.connect(connection_string)
    cursor = connection.cursor()
    return cursor