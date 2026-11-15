#!/bin/bash
# --- Дополнительные задания 1 и 2

# --- Задание 1 (лёгкое): структура папок проекта
mkdir -p myproject/src/main myproject/src/test myproject/docs myproject/logs myproject/backup
echo "--- Структура myproject"
find myproject -type d | sort

# --- Задание 2 (среднее): 5 самых больших .log файлов
# --- find находит файлы, ls -S сортирует по размеру (по убыванию), head оставляет 5
echo
echo "--- 5 самых больших .log файлов"
# --- создаём тестовые логи разного размера, чтобы было что сортировать
for i in 1 2 3 4 5 6 7; do
    head -c $((i * 700)) /dev/zero | tr '\0' 'x' > "myproject/logs/app$i.log"
done
find . -name "*.log" -type f -exec ls -lS {} + | head -5
