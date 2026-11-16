#!/bin/bash
# --- Раздел 3. Ввод данных

echo "Введите ваше имя:"
read USERNAME
echo "Привет, $USERNAME!"

# --- read -p выводит подсказку в той же строке
read -p "Введите ваш возраст: " AGE
echo "Вам $AGE лет"

# --- Скрытый ввод (для паролей)
read -s -p "Введите пароль: " PASSWORD
echo
echo "Пароль принят"
