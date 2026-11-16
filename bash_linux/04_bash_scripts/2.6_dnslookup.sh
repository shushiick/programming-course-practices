#!/bin/bash
# --- Узнаёт IP адрес домена

read -p "Введите домен (например: google.com): " domain

echo "--- DNS информация для $domain"

# --- Получаем IP адреса
echo "IP адреса:"
dig +short "$domain" | while read ip; do
    echo "  $ip"
done

# --- Показываем полную информацию
echo
echo "Подробная информация:"
# --- nslookup показывает все записи
nslookup "$domain" | grep -v "Server:" | grep -v "Address:" | grep -v "Non-authoritative" | grep -v "^$" | while read line; do
    echo "  $line"
done
