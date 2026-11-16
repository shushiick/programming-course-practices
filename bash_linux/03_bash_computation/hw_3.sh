#!/bin/bash
# Доп. задание 3: чётность и делимость на 3 и 5
read -p "Введите число N: " n

if [ $((n % 2)) -eq 0 ]; then
    echo "$n - чётное"
else
    echo "$n - нечётное"
fi

if [ $((n % 3)) -eq 0 ]; then
    echo "$n делится на 3"
else
    echo "$n не делится на 3 (остаток $((n % 3)))"
fi

if [ $((n % 5)) -eq 0 ]; then
    echo "$n делится на 5"
else
    echo "$n не делится на 5 (остаток $((n % 5)))"
fi