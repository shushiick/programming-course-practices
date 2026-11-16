#!/bin/bash
# Задание 8: среднее трёх чисел через bc
read -p "Первое число: " a
read -p "Второе число: " b
read -p "Третье число: " c

avg=$(echo "scale=2; ($a + $b + $c) / 3" | bc)

echo "---"
echo "Среднее: $avg"