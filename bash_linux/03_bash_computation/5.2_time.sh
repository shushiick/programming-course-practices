#!/bin/bash
# --- Перевод секунд в часы, минуты, секунды
# --- Задание 6: число можно передать аргументом, иначе спрашиваем через read
if [ -z "$1" ]; then
    read -p "Введите количество секунд: " total
else
    total=$1
fi

hours=$((total / 3600))
remainder=$((total % 3600))
minutes=$((remainder / 60))
seconds=$((remainder % 60))

echo "---"
echo "$total секунд = $hours ч $minutes мин $seconds с"