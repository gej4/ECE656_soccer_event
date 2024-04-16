import json
import mysql.connector

# number 4 on optimzation
def correct_json_format(malformed_json):
    corrected_json = malformed_json.replace(";", ",").replace("'", '"')
    modified_string = corrected_json[1:-1]
   
    return modified_string

def extract_referee_info(json_data):
       
    json_data = "'" + json_data + "'"
    json_data = json_data[1:-1]
    referees = json.loads(json_data)
    referee_info = []
    for referee in referees:
        if 'refereeId' in referee and 'role' in referee:
            referee_info.append({
                'refereeId': referee['refereeId'],
                'role': referee['role']
            })
    return referee_info
    


# Database connection
config = {
    'user': 'admin',
    'password': '123456789',
    'host': 'database-2.cny0iwy6y1jm.us-east-2.rds.amazonaws.com',
    'database': 'Soccer_Event',
    'raise_on_warnings': True
}
cnx = mysql.connector.connect(**config)
cursor = cnx.cursor()

# Fetch the JSON data from the database
query = "SELECT wyId, referees FROM matches_England WHERE referees !='[]'"
cursor.execute(query)
rows = cursor.fetchall()

query = "SELECT wyId FROM referees"
cursor.execute(query)
result_list = [item[0] for item in cursor.fetchall()]

# Process each row
# insert into match referee table
for index,row in enumerate(rows):
    if index<400:
        match_id = row[0]
        corrected_json = correct_json_format(row[1])
        referee_data = extract_referee_info(corrected_json)
        # Insert each referee's data back into another table
        insert_query = "INSERT INTO matches_referees (matchID, refereeID, role) VALUES (%s, %s, %s)"
        insert_values = []
        for ref in referee_data:
            if ref['refereeId'] is not None and ref['refereeId'] in result_list:
                insert_value = (match_id, ref['refereeId'], ref['role'])
                insert_values.append(insert_value)
        cursor.executemany(insert_query, insert_values)
    

# Commit changes and close connection
cnx.commit()
cursor.close()
cnx.close()
