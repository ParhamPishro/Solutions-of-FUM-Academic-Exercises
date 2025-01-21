import os
from urllib.request import urlopen
from zipfile import ZipFile
from io import BytesIO
import pandas as pd
import networkx as nx
from collections import defaultdict
from node2vec import Node2Vec


def download_movielens_data():
    url = 'https://files.grouplens.org/datasets/movielens/ml-100k.zip'
    data_directory = 'data'

    if not os.path.exists(data_directory):
        os.makedirs(data_directory)

    with urlopen(url) as zip_response:
        with ZipFile(BytesIO(zip_response.read())) as zip_file:
            zip_file.extractall(data_directory)

    print(f"Dataset downloaded and extracted to {data_directory}.")


def load_movielens_data():
    ratings_path = 'data/ml-100k/u.data'
    movies_path = 'data/ml-100k/u.item'

   
    ratings = pd.read_csv(ratings_path, sep='\t', names=['user_id', 'movie_id', 'rating', 'timestamp'])

    
    movies = pd.read_csv(movies_path, sep='|', usecols=[0, 1], names=['movie_id', 'title'], encoding='latin1')
    return ratings, movies


def build_graph(ratings, min_weight=20):
    pairs = defaultdict(int)

    
    for group in ratings.groupby("user_id"):
        user_movies = list(group[1]["movie_id"])
        for i in range(len(user_movies)):
            for j in range(i + 1, len(user_movies)):
                pairs[(user_movies[i], user_movies[j])] += 1

    # اضافه کردن لبه‌ها به گراف
    G = nx.Graph()
    for (movie1, movie2), weight in pairs.items():
        if weight >= min_weight:
            G.add_edge(movie1, movie2, weight=weight)

    print(f"Graph created with {G.number_of_nodes()} nodes and {G.number_of_edges()} edges.")
    return G


def train_node2vec(graph, dimensions=64, walk_length=20, num_walks=200, p=1, q=1):
    node2vec = Node2Vec(graph, dimensions=dimensions, walk_length=walk_length, num_walks=num_walks, p=p, q=q, workers=1)
    model = node2vec.fit(window=10, min_count=1, batch_words=4)
    return model


def recommend_movies(model, movies, movie_name, top_n=5):
    movie_id = str(movies[movies.title == movie_name].movie_id.values[0])
    recommendations = []
    for similar_movie_id, score in model.wv.most_similar(movie_id, topn=top_n):
        title = movies[movies.movie_id == int(similar_movie_id)].title.values[0]
        recommendations.append((title, score))
    return recommendations


if __name__ == "__main__":
    
    download_movielens_data()

    
    ratings, movies = load_movielens_data()

    
    ratings = ratings[ratings.rating >= 4]

   
    graph = build_graph(ratings)

   
    model = train_node2vec(graph)

    
    movie_to_recommend = "Star Wars (1977)"
    recommendations = recommend_movies(model, movies, movie_to_recommend)

    print(f"Recommendations for '{movie_to_recommend}':")
    for title, score in recommendations:
        print(f"- {title}: {score:.2f}")
