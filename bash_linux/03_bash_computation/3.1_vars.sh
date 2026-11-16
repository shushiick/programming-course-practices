#!/bin/bash
# --- Переменные и подстановка

# --- Объявляем переменные
price=150       # --- цена товара
quantity=3      # --- количество

# --- Считаем стоимость
total=$((price * quantity))

# --- Вывод с подстановкой
echo "Цена: $price руб."
echo "Количество: $quantity шт."
echo "Итого: $total руб."
echo "---"

# --- Меняем значение переменной
quantity=5
total=$((price * quantity))

echo "После изменения количества:"
echo "Количество: $quantity шт."
echo "Итого: $total руб."
