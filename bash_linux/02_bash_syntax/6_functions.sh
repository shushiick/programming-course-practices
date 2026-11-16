#!/bin/bash
# --- Раздел 6. Функции

# --- Определение функции
greet_user() {
    local name=$1
    echo "Привет, $name!"
    return 0
}

# --- Функция с возвращаемым значением
check_file() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

# --- Вызов функций
greet_user "Анна"

if check_file "/etc/hosts"; then
    echo "Файл существует"
else
    echo "Файл не найден"
fi
