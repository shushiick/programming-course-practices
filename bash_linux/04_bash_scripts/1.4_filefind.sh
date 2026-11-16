#!/bin/bash
# --- Ищет файлы по имени в текущей директории

read -p "Введите часть имени для поиска: " pattern

echo "Ищем файлы с '$pattern'..."
echo "------------------------"

# --- find . - ищет в текущей директории
# --- -name "*$pattern*" - имя содержит шаблон
# --- -type f - только файлы (не директории)
find . -type f -name "*$pattern*" 2>/dev/null | while read file; do
    # --- Убираем ./ в начале
    echo "  ${file#./}"
done

# --- Считаем количество
count=$(find . -type f -name "*$pattern*" 2>/dev/null | wc -l)
echo "------------------------"
echo "Найдено файлов: $count"
