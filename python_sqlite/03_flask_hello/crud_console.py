"""
Практическая работа №2. Базовые CRUD-операции через консоль.

Create - INSERT, Read - SELECT, Update - UPDATE, Delete - DELETE.
Все запросы параметризованные (плейсхолдер ?), это защищает от SQL-инъекций.
"""
import sqlite3

DB_PATH = 'app.db'


def get_connection():
    """Открывает соединение с базой."""
    return sqlite3.connect(DB_PATH)


def ensure_table():
    """Создаёт таблицу, если init_db.py ещё не запускали."""
    conn = get_connection()
    conn.execute("""
        CREATE TABLE IF NOT EXISTS tasks (
            id     INTEGER PRIMARY KEY,
            title  TEXT NOT NULL,
            status TEXT DEFAULT 'new'
        )
    """)
    conn.commit()
    conn.close()


def show_menu():
    print("\n--- Список задач")
    print("1. Показать все задачи")
    print("2. Добавить задачу")
    print("3. Отметить задачу выполненной")
    print("4. Удалить задачу")
    print("0. Выход")


def list_tasks():
    """READ: подключение, SELECT, fetchall, закрытие. commit не нужен."""
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, title, status FROM tasks ORDER BY id")
    rows = cursor.fetchall()
    conn.close()

    if not rows:
        print("Список пуст. Добавьте первую задачу.")
        return

    print("\n--- Ваши задачи")
    for task_id, title, status in rows:
        mark = "[x]" if status == 'done' else "[ ]"
        print(f"{task_id:>3}. {mark} {title}  ({status})")


def add_task():
    """CREATE: подключение, INSERT, commit, lastrowid, закрытие."""
    title = input("Название задачи: ").strip()
    if not title:
        print("Ошибка: название не может быть пустым.")
        return

    conn = get_connection()
    cursor = conn.cursor()
    # --- кортеж из одного элемента: запятая обязательна
    cursor.execute("INSERT INTO tasks (title) VALUES (?)", (title,))
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    print(f"Задача добавлена, id = {new_id}")


def ask_task_id(prompt):
    """Спрашивает id и проверяет, что это число. Возвращает int или None."""
    raw = input(prompt).strip()
    if not raw.isdigit():
        print("Ошибка: id должен быть числом.")
        return None
    return int(raw)


def mark_done():
    """UPDATE: подключение, UPDATE, commit, rowcount, закрытие."""
    list_tasks()
    task_id = ask_task_id("Введите id выполненной задачи: ")
    if task_id is None:
        return

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE tasks SET status = 'done' WHERE id = ?", (task_id,))
    conn.commit()
    affected = cursor.rowcount
    conn.close()

    if affected == 0:
        print(f"Задача с id={task_id} не найдена.")
    else:
        print(f"Задача {task_id} отмечена выполненной.")


def delete_task():
    """DELETE: подтверждение, подключение, DELETE, commit, rowcount, закрытие."""
    list_tasks()
    task_id = ask_task_id("Введите id задачи для удаления: ")
    if task_id is None:
        return

    confirm = input(f"Точно удалить задачу {task_id}? (y/n): ").strip().lower()
    if confirm != 'y':
        print("Отменено.")
        return

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM tasks WHERE id = ?", (task_id,))
    conn.commit()
    affected = cursor.rowcount
    conn.close()

    if affected == 0:
        print(f"Задача с id={task_id} не найдена.")
    else:
        print(f"Задача {task_id} удалена.")


def main():
    ensure_table()
    while True:
        show_menu()
        try:
            choice = input("Выберите действие: ").strip()
        except EOFError:
            # --- Ctrl+D: завершаем программу
            print("\nДо встречи!")
            break

        if choice == '1':
            list_tasks()
        elif choice == '2':
            add_task()
        elif choice == '3':
            mark_done()
        elif choice == '4':
            delete_task()
        elif choice == '0':
            print("До встречи!")
            break
        else:
            print("Нет такого пункта, попробуйте снова.")


if __name__ == '__main__':
    main()
