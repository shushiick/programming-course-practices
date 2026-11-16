#!/bin/bash
# --- Раздел 5. Цикл while

# --- Чтение файла построчно
while read line; do
    echo "Строка: $line"
done < /etc/passwd

# --- Цикл с условием
COUNT=1
while [ $COUNT -le 5 ]; do
    echo "Счетчик: $COUNT"
    ((COUNT++))
done
