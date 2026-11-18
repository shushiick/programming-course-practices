"""
Практическая работа №1. Инициализация базы данных SQLite.

Создаёт файл базы данных app.db и таблицу tasks (задачи).
Повторный запуск не вызывает ошибку благодаря CREATE TABLE IF NOT EXISTS.
"""
import sqlite3

# 1. Подключение: если файла app.db нет, он будет создан
conn = sqlite3.connect('app.db')

# 2. Курсор: через него отправляем SQL-команды
cursor = conn.cursor()

# 3. Создание таблицы
# id     INTEGER PRIMARY KEY - уникальный номер, SQLite заполняет его сам
# title  TEXT NOT NULL       - название задачи, обязательное поле
# status TEXT DEFAULT 'new'  - статус, по умолчанию 'new'
cursor.execute("""
    CREATE TABLE IF NOT EXISTS tasks (
        id     INTEGER PRIMARY KEY,
        title  TEXT NOT NULL,
        status TEXT DEFAULT 'new'
    )
""")

# 4. Фиксация: без commit() изменения не сохранятся в файл
conn.commit()

# 5. Закрытие соединения
conn.close()

print("База данных и таблица tasks успешно созданы.")
