#!/bin/bash
# --- Следит за изменениями в файле

read -p "Файл для наблюдения: " filename

if [ ! -f "$filename" ]; then
    echo "Файл не найден!"
    exit 1
fi

echo "Слежу за $filename (нажмите Ctrl+C для выхода)"
echo "Последние 3 строки:"

# --- tail -f показывает новые строки в реальном времени
tail -f "$filename"
