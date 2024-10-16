#!/bin/bash

# Остановка выполнения скрипта в случае ошибки
set -e

# Установка необходимых зависимостей
echo "Установка необходимых зависимостей..."
sudo apt update
sudo apt install -y git build-essential libssl-dev zlib1g-dev ufw

# Клонирование репозитория OpenTracker
echo "Скачивание OpenTracker..."
git clone git://erdgeist.org/opentracker
cd opentracker

# Сборка OpenTracker
echo "Сборка OpenTracker..."
make

# Открытие порта 6969 в фаерволе (TCP и UDP)
echo "Открытие порта 6969 в фаерволе..."
sudo ufw allow 6969/tcp
sudo ufw allow 6969/udp

# Запуск OpenTracker
echo "Запуск OpenTracker..."
./opentracker &

# Получение текущего IP-адреса
IP=$(hostname -I | awk '{print $1}')

echo "OpenTracker успешно запущен!"

# Информация о доступе к статистике трекера
echo "Трекер доступен по адресу: http://$IP:6969/stats"
