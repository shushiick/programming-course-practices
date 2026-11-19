"""
Практическая работа №7. Мини-проект «Список задач» (итоговая работа).

Полный CRUD через браузер:
  R — главная страница со списком задач (SELECT)
  C — форма добавления (INSERT)
  U — кнопка «Готово» / «Вернуть» переключает статус (UPDATE)
  D — кнопка «Удалить» удаляет задачу (DELETE)

Правила: параметризованные запросы, commit/rollback, close в finally,
PRG-паттерн (redirect после POST), серверная валидация, sqlite3.Row.
"""
import sqlite3
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

DB_PATH = 'app.db'
MAX_TITLE_LENGTH = 200


# --- РАБОТА С БАЗОЙ

def get_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row      # --- доступ к колонкам по имени: row['title']
    return conn


def init_db():
    """Создаёт таблицу при запуске, если init_db.py ещё не запускали."""
    conn = get_connection()
    try:
        conn.execute("""
            CREATE TABLE IF NOT EXISTS tasks (
                id     INTEGER PRIMARY KEY,
                title  TEXT NOT NULL,
                status TEXT DEFAULT 'new'
            )
        """)
        conn.commit()
    finally:
        conn.close()


def fetch_all_tasks():
    """R: вернуть все задачи."""
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT id, title, status FROM tasks ORDER BY id")
        return cursor.fetchall()
    except sqlite3.Error as e:
        print(f"[DB ERROR fetch] {e}")
        return []
    finally:
        conn.close()


def insert_task(title):
    """C: вставить новую задачу. Возвращает (success, message)."""
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("INSERT INTO tasks (title) VALUES (?)", (title,))
        conn.commit()
        return True, None
    except sqlite3.Error as e:
        conn.rollback()
        print(f"[DB ERROR insert] {e}")
        return False, "Не удалось сохранить задачу."
    finally:
        conn.close()


def toggle_task_status(task_id):
    """U: переключить статус new <-> done. Возвращает число затронутых строк."""
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute(
            """
            UPDATE tasks
            SET status = CASE WHEN status = 'done' THEN 'new' ELSE 'done' END
            WHERE id = ?
            """,
            (task_id,)
        )
        conn.commit()
        return cursor.rowcount
    except sqlite3.Error as e:
        conn.rollback()
        print(f"[DB ERROR toggle] {e}")
        return 0
    finally:
        conn.close()


def delete_task_by_id(task_id):
    """D: удалить задачу. Возвращает число затронутых строк."""
    conn = get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM tasks WHERE id = ?", (task_id,))
        conn.commit()
        return cursor.rowcount
    except sqlite3.Error as e:
        conn.rollback()
        print(f"[DB ERROR delete] {e}")
        return 0
    finally:
        conn.close()


def render_with_error(message, status_code):
    """Главная страница с сообщением об ошибке и подходящим HTTP-кодом."""
    return render_template('index.html', items=fetch_all_tasks(), error=message), status_code


# --- МАРШРУТЫ FLASK

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        title = request.form.get('title', '').strip()
        if not title:
            return render_with_error('Название задачи не может быть пустым.', 400)
        if len(title) > MAX_TITLE_LENGTH:
            return render_with_error(f'Название не длиннее {MAX_TITLE_LENGTH} символов.', 400)

        success, message = insert_task(title)
        if not success:
            return render_with_error(message, 500)

        return redirect(url_for('index'))          # --- PRG

    return render_template('index.html', items=fetch_all_tasks())


@app.route('/toggle/<int:task_id>', methods=['POST'])
def toggle_done(task_id):
    # --- <int:task_id> — Flask сам приводит к int и вернёт 404, если в URL не число
    if toggle_task_status(task_id) == 0:
        return render_with_error(f'Задача #{task_id} не найдена.', 404)
    return redirect(url_for('index'))


@app.route('/delete/<int:task_id>', methods=['POST'])
def delete_task(task_id):
    if delete_task_by_id(task_id) == 0:
        return render_with_error(f'Задача #{task_id} не найдена.', 404)
    return redirect(url_for('index'))


init_db()

if __name__ == '__main__':
    app.run(debug=True, port=5000)
