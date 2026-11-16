#!/bin/bash
# --- Скачивает файл из интернета

read -p "URL для скачивания: " url
read -p "Имя для сохранения: " filename

echo "Скачиваем $url ..."

# --- wget -O сохраняет с указанным именем
if wget -O "$filename" "$url" 2>/dev/null; then
    echo "Файл сохранён как: $filename"
    echo "Размер: $(du -h "$filename" | cut -f1)"
else
    echo "Ошибка скачивания!"
fi
