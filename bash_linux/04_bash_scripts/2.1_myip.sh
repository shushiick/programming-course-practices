#!/bin/bash
# --- Показывает IP адреса компьютера

echo "--- Внутренние IP адреса"
# --- ip addr покажет все интерфейсы
# --- grep inet находит строки с IP
ip addr | grep inet | grep -v inet6 | while read line; do
    # --- Извлекаем IP (убираем маску /число)
    ip=$(echo "$line" | awk '{print $2}' | cut -d'/' -f1)
    # --- Пропускаем localhost
    if [ "$ip" != "127.0.0.1" ]; then
        echo "  $ip"
    fi
done

echo
echo "--- Внешний IP (через интернет)"
# --- curl запрашивает внешний IP через сервис
curl -s ifconfig.me
echo
