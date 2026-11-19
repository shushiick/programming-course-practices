"""
Практическая работа №6. Обработка ошибок и защита соединений.

Паттерн: открыть соединение → try (execute, commit) →
except (rollback, понятное сообщение) → finally (close — всегда).
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
    """Чтение тоже может упасть (нет таблицы, база заблокирована) — защищаем."""
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT id, title, status FROM tasks ORDER BY id")
        # --- return внутри try: сначала выполнится finally (close), потом функция вернёт результат
        return cursor.fetchall()
    except sqlite3.Error as e:
        print(f"[DB ERROR] {e}")
        return []                      # --- при ошибке — пустой список, страница всё равно откроется
    finally:
        conn.close()


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        title = request.form.get('title', '').strip()

        if not title:
            return render_template(
                'index.html',
                items=fetch_all_tasks(),
                error='Название задачи не может быть пустым.'
            ), 400

        # --- Соединение открываем ДО try, чтобы в finally переменная conn точно существовала
        conn = get_connection()
        try:
            cursor = conn.cursor()
            cursor.execute("INSERT INTO tasks (title) VALUES (?)", (title,))
            conn.commit()
        except sqlite3.Error as e:
            conn.rollback()            # --- отменяем незавершённую транзакцию
            print(f"[DB ERROR] {e}")   # --- в реальном проекте — logging.error(...)
            return render_template(
                'index.html',
                items=fetch_all_tasks(),
                error='Не удалось сохранить задачу. Попробуйте ещё раз.'
            ), 500
        finally:
            conn.close()               # --- выполняется ВСЕГДА: и при успехе, и при ошибке

        # --- Сюда попадаем, только если в try не было ошибки
        return redirect(url_for('index'))

    return render_template('index.html', items=fetch_all_tasks())


if __name__ == '__main__':
    app.run(debug=True, port=5000)
