#!/bin/bash
# Все команды практической работы «Основы работы с Linux» (части 1–4) в порядке выполнения. Выполнено в Ubuntu (WSL 2).

# --- Часть 1. Файлы и директории
# 1.1 Навигация и создание структуры
pwd
ls ~
mkdir -p ~/linux_practice
cd ~/linux_practice || exit 1
pwd
mkdir -p documents projects downloads
ls

# 1.2 Создание и работа с файлами
echo "Моя первая практическая работа" > readme.txt
cat readme.txt
echo "Дата выполнения: $(date)" >> readme.txt
cat readme.txt
rm -f numbers.txt
for i in {1..10}; do echo "Число $i" >> numbers.txt; done
cat numbers.txt

# 1.3 Копирование и перемещение
cp readme.txt documents/
ls documents/
mv numbers.txt downloads/
ls downloads/
ls
cp -r documents projects/
ls projects/

# --- Часть 2. Поиск и фильтрация
# 2.1 Поиск файлов
touch file1.txt file2.log file3.txt document.pdf image.jpg
find . -name "*.txt"
find . -name "file*"
find ~/linux_practice -size +1k
find ~/linux_practice -mmin -10

# 2.2 Поиск текста (grep)
cat > data.txt << DATA
Иванов Иван 25
Петров Петр 30
Сидоров Сидор 28
Иванова Мария 22
Петрова Анна 35
DATA
grep "Петров" data.txt
grep -E "[3-9][0-9]" data.txt      # --- возраст 30 и больше
awk '$3 > 30' data.txt             # --- строго больше 30
grep -v "Иван" data.txt
grep -c "Иванов" data.txt

# 2.3 Конвейеры
head -5 data.txt
tail -3 data.txt
sort data.txt
awk '{print $1}' data.txt
awk '{print $1}' data.txt | sort | uniq
awk '{print $1}' data.txt | sort | uniq -c

# Часть 3. Права доступа
cat > script.sh << 'SCRIPT'
#!/bin/bash
echo "Hello, World!"
date
SCRIPT
ls -l script.sh
chmod +x script.sh
ls -l script.sh
./script.sh
chmod -r script.sh
cat script.sh
chmod 644 script.sh
ls -l script.sh
cat script.sh

# --- Часть 4. Сеть
# 4.1 Проверка соединения
ping -c 4 0.0.0.0
ping -c 4 ya.ru
ip addr | grep inet | grep -v inet6
ss -tuln | head -10
# --- curl -s ifconfig.me   (внешний IP в отчёт не публикуется)

# 4.2 DNS и загрузка
nslookup google.com
dig +short google.com
curl -o test.html https://example.com
head -10 test.html
curl -I https://example.com
