#!/bin/bash
# Доп. задание 2: доход по вкладу за 1 год
read -p "Сумма вклада (руб.): " sum
read -p "Процентная ставка (% годовых): " rate

income=$((sum * rate / 100))
total=$((sum + income))

echo "---"
echo "Доход за год: $income руб."
echo "Сумма через год: $total руб."