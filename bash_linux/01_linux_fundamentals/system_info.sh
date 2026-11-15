#!/bin/bash
# --- Дополнительное задание 3: информация о системе.

echo "--- Информация о системе"

echo "Имя хоста:        $(hostname)"
echo "Версия ядра:      $(uname -r)"
echo "Пользователь:     $(whoami)"
echo "Свободная память: $(free -h | awk '/Mem/ {print $4}')"
echo "Время работы:     $(uptime -p)"

echo
echo "--- Запущенные процессы (первые 10)"
ps aux | head -11
