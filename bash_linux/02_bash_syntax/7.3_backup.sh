#!/bin/bash
# --- Раздел 7. Простой скрипт бэкапа
# --- Папки из методички (/home/backup, /home/user/documents) заменены на папки
# --- в текущем каталоге: для /home нужны права root, а user у меня нет.

BACKUP_DIR="./backup"
SOURCE_DIR="./documents"
DATE=$(date +%Y-%m-%d)

# --- Создаём тестовые документы, если папки нет
if [ ! -d "$SOURCE_DIR" ]; then
    mkdir -p "$SOURCE_DIR"
    echo "Документ 1" > "$SOURCE_DIR/doc1.txt"
    echo "Документ 2" > "$SOURCE_DIR/doc2.txt"
fi

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE_DIR"
echo "Бэкап создан: $BACKUP_DIR/backup_$DATE.tar.gz"
