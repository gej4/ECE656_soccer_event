import pandas as pd
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt

# Load the data
playerank_data = pd.read_csv('./data/playerank.csv')

# Select the relevant features for clustering
features = playerank_data[['playerankScore', 'minutesPlayed']].dropna()

# Standardize the features
scaler = StandardScaler()
features_scaled = scaler.fit_transform(features)

# Use the Elbow method to find the optimal number of clusters if needed
# ...

# Apply k-means clustering
kmeans = KMeans(n_clusters=10, random_state=42)
playerank_data['cluster'] = kmeans.fit_predict(features_scaled)

# Plot the clusters
plt.scatter(playerank_data['minutesPlayed'], playerank_data['playerankScore'], c=playerank_data['cluster'], cmap='viridis')
plt.xlabel('Minutes Played')
plt.ylabel('Player Rank Score')
plt.title('Cluster Analysis on Player Rank')
plt.show()