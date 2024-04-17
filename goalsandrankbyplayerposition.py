import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import json

def fix_and_parse_json(json_like_str):
    # Replace single quotes with double quotes to adhere to JSON standards
    json_like_str = json_like_str.replace("'", "\"")
    # Replace semicolons with commas
    json_like_str = json_like_str.replace(";", ",")
    try:
        # Parse the corrected string into a Python dictionary
        return json.loads(json_like_str)
    except json.JSONDecodeError as e:
        # Handle possible JSON decoding errors
        print(f"Failed to parse JSON: {e}")
        return {}
# Load the necessary datasets
players_data = pd.read_csv('./data/players.csv', delimiter=';')
playerank_data = pd.read_csv('./data/playerank.csv')
matches_data = pd.read_csv('./data/matches_England.csv')


# Assuming the 'role' in players_data is stored in a JSON-like format and needs to be extracted
players_data['role'] = players_data['role'].apply(fix_and_parse_json)
players_data['role'] = players_data['role'].apply(lambda x: x.get('name', 'Unknown'))


# Merge the performance data with player data to include the role information
combined_data = playerank_data.merge(players_data[['wyId', 'role']], left_on='playerId', right_on='wyId', how='left')

# Aggregate total goals by position
goals_by_position = combined_data.groupby('role')['goalScored'].sum().reset_index()

# Aggregate average Playerank scores by position
rank_scores_by_position = combined_data.groupby('role')['playerankScore'].mean().reset_index()

# Plotting
plt.figure(figsize=(14, 6))

# Plot for total goals scored by position
plt.subplot(1, 2, 1)
sns.barplot(data=goals_by_position, x='goalScored', y='role', palette='viridis')
plt.title('Total Goals Scored by Position')
plt.xlabel('Total Goals')
plt.ylabel('Position')

# Plot for average Playerank scores by position
plt.subplot(1, 2, 2)
sns.barplot(data=rank_scores_by_position, x='playerankScore', y='role', palette='viridis')
plt.title('Average Playerank Scores by Position')
plt.xlabel('Average Playerank Score')
plt.ylabel('Position')

plt.tight_layout()
plt.show()