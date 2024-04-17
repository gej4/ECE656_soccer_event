import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the necessary datasets
players_data = pd.read_csv('./data/players.csv', delimiter=';')
playerank_data = pd.read_csv('./data/playerank.csv')
matches_data = pd.read_csv('./data/matches_England.csv')


# Filter the playerank data to include only match IDs that are present in matches_England.csv
relevant_matches = matches_data['wyId']
filtered_playerank_data = playerank_data[playerank_data['matchId'].isin(relevant_matches)]

# Aggregate total goals for each player from the filtered data
total_goals_by_player_filtered = filtered_playerank_data.groupby('playerId')['goalScored'].sum().reset_index()

# Merge with players data to get player names for readability
total_goals_by_player_filtered = total_goals_by_player_filtered.merge(players_data[['wyId', 'shortName']], left_on='playerId', right_on='wyId', how='left')

# Sort to find top goal scorers from the relevant matches
top_goal_scorers_filtered = total_goals_by_player_filtered[['shortName', 'goalScored']].sort_values(by='goalScored', ascending=False).head(10)

# Plotting the top goal scorers from filtered matches
plt.figure(figsize=(10, 6))
sns.barplot(data=top_goal_scorers_filtered, x='goalScored', y='shortName', palette='viridis')
plt.title('Top 10 Goal Scorers in English Matches')
plt.xlabel('Total Goals')
plt.ylabel('Player Name')
plt.show()
