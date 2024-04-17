import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the necessary datasets
players_data = pd.read_csv('./data/players.csv', delimiter=';')
playerank_data = pd.read_csv('./data/playerank.csv')
matches_data = pd.read_csv('./data/matches_England.csv')
teams_data = pd.read_csv('./data/teams.csv')


# Assuming 'winner' column in matches_data contains the team IDs of the match winners
# Count the number of wins for each team
wins_by_team = matches_data['winner'].value_counts().reset_index()
wins_by_team.columns = ['teamId', 'Wins']

# Filter out rows where 'winner' might be 0 or NaN, indicating a draw or no data
wins_by_team = wins_by_team[wins_by_team['teamId'] != 0]

# Merge with teams_data to get team names
# Assuming 'wyId' in teams_data corresponds to 'teamId' in matches_data
wins_by_team = wins_by_team.merge(teams_data[['wyId', 'officialName']], left_on='teamId', right_on='wyId', how='left')
wins_by_team.drop('wyId', axis=1, inplace=True)

plt.figure(figsize=(10, 8))
sns.barplot(data=wins_by_team, y='officialName', x='Wins', palette='viridis')
plt.title('Number of Wins by Teams')
plt.xlabel('Wins')
plt.ylabel('Team Name')
plt.tight_layout()
plt.show()