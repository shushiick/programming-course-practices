#!/bin/bash
# --- Приблизительный тест скорости сети
# --- Отличия от методички:
# --- - сервер speedtest.tele2.net у меня не отвечает, поэтому файл 1 МБ скачивается с Cloudflare;
# --- - из строки ping берётся среднее (avg), а не последнее число (это было mdev);
# --- - время считается в миллисекундах: файл качается быстрее секунды,
# ---   и в методичке скорость не выводилась (деление на 0 секунд).

echo "--- Тест скорости сети"
echo "Измеряем задержку..."

# --- Проверяем ping до Google DNS
ping_time=$(ping -c 3 8.8.8.8 | grep "avg" | cut -d= -f2 | cut -d/ -f2)

if [ -n "$ping_time" ]; then
    echo "Задержка (ping): ${ping_time}ms"
else
    echo "Не удалось измерить задержку"
fi

echo
echo "Измеряем скорость скачивания..."
# --- Скачиваем тестовый файл 1 МБ и замеряем время
start=$(date +%s%N)
curl -s -o /tmp/speedtest "https://speed.cloudflare.com/__down?bytes=1048576"
end=$(date +%s%N)

ms=$(( (end - start) / 1000000 ))
if [ -s /tmp/speedtest ] && [ $ms -gt 0 ]; then
    speed=$(echo "scale=2; 1000 / $ms" | bc | sed 's/^\./0./')  # --- bc пишет .86 без нуля
    echo "Скачано 1 МБ за $ms мс"
    echo "Скорость: примерно ${speed} MB/s"
else
    echo "Не удалось скачать тестовый файл"
fi

rm -f /tmp/speedtest
