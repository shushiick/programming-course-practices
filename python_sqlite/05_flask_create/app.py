"""
Практическая работа №5. Интеграция Flask и SQLite (добавление данных).

Браузер (форма) → POST / → Flask → SQLite (INSERT + commit) →
редирект на главную (GET /) — паттерн Post/Redirect/Get.
"""
import sqlite3
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

DB_PATH = 'app.db'


def get_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def fetch_all_tasks():
    """Возвращает все задачи. Используется и в GET, и при ошибке в POST."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, title, status FROM tasks ORDER BY id")
    rows = cursor.fetchall()
    conn.close()
    return rows


@app.route('/', methods=['GET', 'POST'])
def index():
    # --- обработка POST
    if request.method == 'POST':
        # --- .get(..., '') не выбросит KeyError, если поля в форме нет
        title = request.form.get('title', '').strip()

        # --- Серверная валидация: даже если браузерную проверку required обошли
        if not title:
            return render_template(
                'index.html',
                items=fetch_all_tasks(),
                error='Название задачи не может быть пустым.'
            ), 400

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO tasks (title) VALUES (?)", (title,))
        conn.commit()            # --- без commit задача не сохранится
        conn.close()

        # --- PRG: после POST — редирект на GET, чтобы F5 не дублировал задачу
        return redirect(url_for('index'))

    # --- обработка GET
    return render_template('index.html', items=fetch_all_tasks())


if __name__ == '__main__':
    app.run(debug=True, port=5000)
