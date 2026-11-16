#!/bin/bash
# --- Раздел 7. Скрипт для автоматического обновления системы

echo "Начало обновления системы: $(date)"

# --- Для Ubuntu
sudo apt update && sudo apt upgrade -y

# --- Для Kali Linux (раскомментировать если нужно)
# sudo apt update && sudo apt full-upgrade -y

echo "Обновление завершено: $(date)"
