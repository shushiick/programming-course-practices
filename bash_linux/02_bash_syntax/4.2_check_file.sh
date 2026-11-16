#!/bin/bash
# --- Раздел 4. Пример проверки файла

FILE="/etc/passwd"

if [ -f "$FILE" ]; then
    echo "Файл $FILE существует"
    if [ -r "$FILE" ]; then
        echo "Файл доступен для чтения"
    fi
else
    echo "Файл не существует"
fi
