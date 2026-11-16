#!/bin/bash
# --- Показывает информацию о файле

# --- Запрашиваем имя файла
read -p "Введите путь к файлу: " filename

# --- Проверяем существует ли файл
if [ -e "$filename" ]; then
    echo "--- Информация о файле"
    echo "Имя: $(basename "$filename")"
    echo "Путь: $(dirname "$filename")"

    # --- Тип файла
    if [ -d "$filename" ]; then
        echo "Тип: Директория"
    elif [ -f "$filename" ]; then
        echo "Тип: Обычный файл"
    else
        echo "Тип: Другой"
    fi

    # --- Права доступа
    echo "Права: $(ls -l "$filename" | cut -d' ' -f1)"

    # --- Размер
    echo "Размер: $(du -h "$filename" | cut -f1)"
else
    echo "Файл не найден!"
fi
