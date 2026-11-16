#!/bin/bash
# --- Раздел 5. Цикл for

# --- Простой цикл
for i in 1 2 3 4 5; do
    echo "Итерация: $i"
done

# --- Цикл по файлам
for file in *.txt; do
    echo "Обрабатываю файл: $file"
done

# --- Цикл с диапазоном
for i in {1..5}; do
    echo "Число: $i"
done
