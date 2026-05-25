#!/bin/bash

# Di chuyen den thu muc project
cd ~/student_backup_system

# Tao thu muc neu chua ton tai
mkdir -p backups
mkdir -p logs

# Ham backup
backup_data() {

    TIME=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="backup_$TIME.tar.gz"

    # Nen thu muc data
    tar -czf backups/$BACKUP_FILE data

    # Ghi log
    echo "[$(date)] Backup thanh cong: $BACKUP_FILE" >> logs/backup.log

    # Kiem tra Internet
    ping -c 1 google.com > /dev/null 2>&1

    if [ $? -eq 0 ]; then

        # Push GitHub
        git add .

        git commit -m "Auto backup $TIME"

        git push origin main

        echo "[$(date)] Push GitHub thanh cong" >> logs/backup.log

    else
        echo "[$(date)] Khong co ket noi Internet" >> logs/backup.log
    fi

    echo "Backup hoan tat!"
}

# Xem danh sach backup
list_backups() {
    ls -lh backups
}

# Xem log
view_logs() {
    cat logs/backup.log
}

# Neu script duoc goi boi cronjob
if [ "$1" == "auto" ]; then
    backup_data
    exit 0
fi

# Menu thu cong
while true
do
    echo "===== MENU ====="
    echo "1. Backup du lieu"
    echo "2. Xem danh sach backup"
    echo "3. Xem log"
    echo "4. Thoat"

    read -p "Chon: " choice

    case $choice in
        1)
            backup_data
            ;;
        2)
            list_backups
            ;;
        3)
            view_logs
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Lua chon khong hop le"
            ;;
    esac
done