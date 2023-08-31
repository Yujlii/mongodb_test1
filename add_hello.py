# Connect to MongoDB
from pymongo import MongoClient

# Define the MongoDB connection URI
mongo_uri = "mongodb://localhost:27017"

# Connect to MongoDB
client = MongoClient(mongo_uri)

# Access a specific database (use an existing one or create a new one)
db = client["testdb"]

# Create a collection (use an existing one or create a new one)
collection = db["messages"]

# Insert a document into the collection
message = {"text": "Hello, World!"}
result = collection.insert_one(message)

# Check if the insertion was successful
if result.acknowledged:
    print("Document inserted successfully!")
else:
    print("Failed to insert document.")
