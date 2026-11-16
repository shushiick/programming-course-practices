#!/bin/bash
# --- Пример меню с выбором действий

while true; do
    clear
    echo "--- ГЛАВНОЕ МЕНЮ"
    echo "1) Показать дату"
    echo "2) Показать кто в системе"
    echo "3) Показать свободное место"
    echo "4) Выход"
    echo
    read -p "Выберите пункт: " choice

    case $choice in
        1)
            date
            read -p "Нажмите Enter..."
            ;;
        2)
            who
            read -p "Нажмите Enter..."
            ;;
        3)
            df -h
            read -p "Нажмите Enter..."
            ;;
        4)
            echo "До свидания!"
            exit 0
            ;;
        *)
            echo "Неверный выбор!"
            read -p "Нажмите Enter..."
            ;;
    esac
done
