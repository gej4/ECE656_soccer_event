from flask import Flask, request, jsonify, render_template
import pymysql
import mysql.connector
import json

app = Flask(__name__,template_folder='template')


soccerDBConnection = mysql.connector.connect(
    host = "database-2.cny0iwy6y1jm.us-east-2.rds.amazonaws.com",
    port = 3306,
    user = "admin",
    password = "123456789",
    db = "Soccer_Event"
)

# config
def get_db_connection():
    connection = mysql.connector.connect(
        host = "database-2.cny0iwy6y1jm.us-east-2.rds.amazonaws.com",
        port = 3306,
        user = "admin",
        password = "123456789",
        db = "Soccer_Event"
    )
    return connection

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/player', methods=['GET'])
def get_player():
    query = request.args.get('id')
    if not query:
        return jsonify({'error': 'Missing player ID'}), 400

    connection = get_db_connection()
    try:
        with connection.cursor(dictionary=True) as cursor:
            sql = "SELECT firstName, lastName, officialName, role FROM players AS p INNER JOIN teams AS t ON p.currentTeamId = t.wyId WHERE firstName LIKE %s OR lastName LIKE %s "
            cursor.execute(sql, (query, query))
            results = cursor.fetchall()
            if results:
                for result in results:
                    # Remove additional double quotes and replace single quotes with double quotes
                    corrected_json = result['role'][1:-1].replace("\'", "\"")
                    result['role'] = json.loads(corrected_json)
                return render_template('search_results.html', results=results)
            else:
                return jsonify({'error': 'Player not found'}), 404
    finally:
        connection.close()

@app.route('/top-players', methods=['GET'])
def get_top_players():
    n = request.args.get('n', type=int)
    if not n or n < 1 or n > 100:
        return jsonify({'error': 'Invalid number of players requested'}), 400
    
    connection = get_db_connection()
    try:
        with connection.cursor(dictionary=True) as cursor:
            sql = """
            SELECT firstname, lastname, SUM(minutes_played) as total_minutes
            FROM player_games
            GROUP BY player_id
            ORDER BY total_minutes DESC
            LIMIT %s
            """
            cursor.execute(sql, (n,))
            results = cursor.fetchall()
            return render_template('top_players.html', results=results)
    finally:
        connection.close()

@app.route('/top-scorers', methods=['GET'])
def top_scorers():
    n = int(request.args.get('top_n', default=10))  # Default to top 10 if not specified
    if n > 50:
        n = 50  # Limit to a maximum of 50 players

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    sql = """
        SELECT p.firstname, p.lastname, SUM(pa.goalScored) AS total_goals
        FROM playerank AS pa
        JOIN matches_England AS m ON pa.matchId = m.wyId
        JOIN players AS p ON pa.playerId = p.wyId
        GROUP BY pa.playerId, p.firstname, p.lastname
        ORDER BY total_goals DESC
        LIMIT 10;
        """
    cursor.execute(sql)
    scorers = cursor.fetchall()
    # scorers = [{'firstName': row['firstName'], 'lastName': row['lastName'], 'total_goals': int(row['total_goals'])} for row in cursor.fetchall()]
    print (scorers)
    cursor.close()
    conn.close()
    
    return render_template('top_scorers.html', scorers=scorers)

if __name__ == '__main__':
    app.run(debug=True)
    app.config['EXPLAIN_TEMPLATE_LOADING'] = True