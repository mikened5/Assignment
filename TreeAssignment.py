from flask import Flask, jsonify
app = Flask(__name__)

@app.route("/tree", methods=["GET"])
def home():
    Trees = {
        'myFavoriteTree': 'Lemon Tree'
    }
    return jsonify(Trees)

if __name__=="__main__":
    app.run(host="0.0.0.0", debug=True)