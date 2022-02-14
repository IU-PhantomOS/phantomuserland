from flask import Flask, jsonify
from random import randint

app = Flask(__name__)


@app.route("/weather")
def get_weather():
    return jsonify({
        "p1": {
            "x": randint(50, 400),
            "y": randint(50, 400),
            "val": randint(10, 20),
            "dir": "NW"
        },
        "p2": {
            "x": randint(50, 400),
            "y": randint(50, 400),
            "val": randint(10, 20),
            "dir": "NW"
        },
        "p3": {
            "x": randint(50, 400),
            "y": randint(50, 400),
            "val": randint(10, 20),
            "dir": "W"
        },
    })


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
