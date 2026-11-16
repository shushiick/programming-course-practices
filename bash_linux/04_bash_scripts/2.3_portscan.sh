#!/bin/bash
# --- Проверяет открытые порты на локальной машине

echo "--- Открытые TCP порты"
# --- ss -tln показывает слушающие TCP порты
# --- grep -v 127.0.0.1 исключает локальные
ss -tln | grep LISTEN | grep -v 127.0.0.1 | while read line; do
    # --- Извлекаем порт
    port=$(echo "$line" | awk '{print $4}' | rev | cut -d: -f1 | rev)

    # --- Пытаемся определить сервис
    service=$(getent services "$port" 2>/dev/null | cut -d' ' -f1)

    if [ -n "$service" ]; then
        echo "  Порт $port ($service)"
    else
        echo "  Порт $port"
    fi
done

echo
echo "--- Открытые UDP порты"
# --- В методичке тут $5, но в ss -uln адрес с портом стоит в 4-м столбце
# --- (в 5-м адрес собеседника, там «*»), поэтому $4
ss -uln | grep UNCONN | grep -v 127.0.0.1 | while read line; do
    port=$(echo "$line" | awk '{print $4}' | rev | cut -d: -f1 | rev)
    service=$(getent services "$port" 2>/dev/null | cut -d' ' -f1)

    if [ -n "$service" ]; then
        echo "  Порт $port ($service)"
    else
        echo "  Порт $port"
    fi
done
