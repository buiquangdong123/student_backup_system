#!/bin/bash

# Tao thu muc backups neu chua ton tai
mkdir -p ../backups
mkdir -p ../logs

# Ham backup du lieu
backup_data() {
    TIME=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="backup_$TIME.tar.gz"

    tar -czf ../backups/$BACKUP_FILE ../data

    echo "[$(date)] Backup thanh cong: $BACKUP_FILE" >> ../logs/backup.log

    echo "Backup thanh cong!"
}

# Ham xem danh sach backup
list_backups() {
    echo "Danh sach file backup:"
    ls -lh ../backups
}

# Ham xem log
view_logs() {
    echo "Noi dung log:"
    cat ../logs/backup.log
}

# Kiem tra ket noi Internet
check_internet() {
    ping -c 1 google.com > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Internet dang hoat dong"
    else
        echo "Khong co ket noi Internet"
    fi
}

# Menu
while true
do
    echo "===== MENU ====="
    echo "1. Backup du lieu"
    echo "2. Xem danh sach backup"
    echo "3. Xem log"
    echo "4. Kiem tra Internet"
    echo "5. Thoat"

    read -p "Chon chuc nang: " choice

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
            check_internet
            ;;
        5)
            echo "Thoat chuong trinh"
            exit 0
            ;;
        *)
            echo "Lua chon khong hop le"
            ;;
    esac
done
