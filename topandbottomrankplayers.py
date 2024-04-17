import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the necessary datasets
players_data = pd.read_csv('./data/players.csv', delimiter=';')
playerank_data = pd.read_csv('./data/playerank.csv')
matches_data = pd.read_csv('./data/matches_England.csv')


# Filter playerank data to only include matches that are in the matches_England dataset
relevant_matches = matches_data['wyId'].unique()
filtered_playerank_data = playerank_data[playerank_data['matchId'].isin(relevant_matches)]

# Aggregate the average Playerank scores for each player from filtered matches
average_scores_by_player = filtered_playerank_data.groupby('playerId')['playerankScore'].mean().reset_index()

# Merge with players data to get player names for readability
average_scores_by_player = average_scores_by_player.merge(players_data[['wyId', 'shortName']], left_on='playerId', right_on='wyId', how='left')

# Sort to find the top 10 players with the best scores and bottom 10 players with the worst scores
top_10_players = average_scores_by_player[['shortName', 'playerankScore']].sort_values(by='playerankScore', ascending=False).head(10)
bottom_10_players = average_scores_by_player[['shortName', 'playerankScore']].sort_values(by='playerankScore').head(10)

# Plotting
plt.figure(figsize=(14, 8))

# Top 10 players plot
plt.subplot(1, 2, 1)
sns.barplot(data=top_10_players, x='playerankScore', y='shortName', palette='viridis')
plt.title('Top 10 Players with Best Playerank Scores in England')
plt.xlabel('Average Playerank Score')
plt.ylabel('Player Name')

# Bottom 10 players plot
plt.subplot(1, 2, 2)
sns.barplot(data=bottom_10_players, x='playerankScore', y='shortName', palette='viridis')
plt.title('Bottom 10 Players with Worst Playerank Scores in England')
plt.xlabel('Average Playerank Score')
plt.ylabel('Player Name')

plt.tight_layout()
plt.show()
