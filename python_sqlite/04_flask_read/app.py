"""
Практическая работа №4. Интеграция Flask и SQLite (чтение данных).

Браузер (GET /) → Flask-функция → SQLite (SELECT) → список строк →
HTML-шаблон Jinja2 → браузер.
"""
import sqlite3
from flask import Flask, render_template

app = Flask(__name__)

DB_PATH = 'app.db'


def get_connection():
    """Открывает соединение с базой и включает доступ к полям по имени."""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row   # --- строки станут sqlite3.Row: row['title'], item.title
    return conn


@app.route('/')
def index():
    # --- 1. Подключение
    conn = get_connection()
    cursor = conn.cursor()

    # --- 2. SELECT
    cursor.execute("SELECT id, title, status FROM tasks ORDER BY id")
    rows = cursor.fetchall()

    # --- 3. Закрытие (commit не нужен — данные не меняем)
    conn.close()

    # --- 4. Передача данных в шаблон под именем items
    return render_template('index.html', items=rows)


if __name__ == '__main__':
    app.run(debug=True, port=5000)
