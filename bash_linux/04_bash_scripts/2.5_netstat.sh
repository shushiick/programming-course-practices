#!/bin/bash
# --- Показывает активные сетевые соединения

echo "--- Активные соединения"
# --- ss -tun показывает все TCP/UDP соединения
ss -tun | tail -n +2 | while read line; do
    # --- Извлекаем состояние и адреса
    state=$(echo "$line" | awk '{print $1}')
    src=$(echo "$line" | awk '{print $5}')
    dst=$(echo "$line" | awk '{print $6}')

    # --- Пропускаем слушающие порты
    if [ "$state" != "LISTEN" ] && [ "$state" != "UNCONN" ]; then
        # --- Убираем IPv6 префикс если есть
        src_clean=$(echo "$src" | sed 's/\[::ffff://g' | sed 's/\]//g')
        dst_clean=$(echo "$dst" | sed 's/\[::ffff://g' | sed 's/\]//g')
        echo "  $src_clean -> $dst_clean ($state)"
    fi
done

# --- Считаем количество
count=$(ss -tun | tail -n +2 | grep -v LISTEN | grep -v UNCONN | wc -l)
echo "------------------------"
echo "Всего активных соединений: $count"
