#!/bin/bash
# --- Проверяет доступность хоста
# --- Отличие от методички: в Ubuntu ошибка «хост не найден» пишется в stderr
# --- текстом «Name or service not known», поэтому добавлено 2>&1 и этот текст в grep.

read -p "Введите адрес (google.com или IP): " host

echo "Проверяем соединение с $host..."
echo "------------------------"

# --- ping -c 4 отправляет 4 пакета
# --- -W 2 таймаут 2 секунды
ping -c 4 -W 2 "$host" 2>&1 | while read line; do
    if echo "$line" | grep -q "bytes from"; then
        # --- Извлекаем время ответа
        time=$(echo "$line" | grep -o "time=[0-9.]*" | cut -d= -f2)
        echo "Ответ: ${time}ms"
    elif echo "$line" | grep -q "packet loss"; then
        # --- Извлекаем процент потерь
        loss=$(echo "$line" | grep -o "[0-9]*%")
        echo "Потеря пакетов: $loss"
    elif echo "$line" | grep -q -e "unknown host" -e "not known"; then
        echo "Хост не найден!"
        exit 1
    fi
done
