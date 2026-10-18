import os

import psycopg
from flask import Flask, jsonify

app = Flask(__name__)


@app.get('/health')
def health():
    try:
        with psycopg.connect(os.environ['DATABASE_URL'], connect_timeout=3) as conn:
            result = conn.execute('SELECT 1').fetchone()[0]
        return jsonify(service='cloudnotes', status='ok', database='connected' if result == 1 else 'error')
    except (psycopg.Error, KeyError):
        return jsonify(service='cloudnotes', status='error', database='unavailable'), 503


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
