"""
Проверка структуры базы app.db: список таблиц и колонок таблицы tasks.
"""
import sqlite3

conn = sqlite3.connect('app.db')
cursor = conn.cursor()

# sqlite_master: системная таблица с описанием всех таблиц
cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables = cursor.fetchall()
print("Таблицы в базе:", tables)

# PRAGMA table_info: номер, имя, тип, NOT NULL, значение по умолчанию, первичный ключ
cursor.execute("PRAGMA table_info(tasks)")
print("\nКолонки таблицы tasks:")
for cid, name, col_type, not_null, default, pk in cursor.fetchall():
    flags = []
    if pk:
        flags.append("PRIMARY KEY")
    if not_null:
        flags.append("NOT NULL")
    if default is not None:
        flags.append(f"DEFAULT {default}")
    print(f"  {name:<7} {col_type:<8} {' '.join(flags)}")

conn.close()