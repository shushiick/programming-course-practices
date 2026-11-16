#!/bin/bash
# Доп. задание 4: игра «Угадай число»
# Число загадывается случайно от 1 до 10 ($RANDOM - встроенный генератор bash)
secret=$((RANDOM % 10 + 1))

read -p "Я загадал число от 1 до 10. Ваш вариант: " guess

if [ "$guess" -eq "$secret" ]; then
    echo "Победа!"
else
    echo "Не угадал, было $secret"
fi