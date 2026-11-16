#!/bin/bash
# Доп. задание 1: площадь пола, площадь стен и объём комнаты

read -p "Длина комнаты (м): " length
read -p "Ширина комнаты (м): " width
read -p "Высота комнаты (м): " height

floor=$(echo "scale=2; $length * $width" | bc)
walls=$(echo "scale=2; 2 * ($length + $width) * $height" | bc)
volume=$(echo "scale=2; $length * $width * $height" | bc)

echo "---"
echo "Площадь пола: $floor м²"
echo "Площадь стен: $walls м²"
echo "Объём комнаты: $volume м³"