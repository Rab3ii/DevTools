#!/bin/bash

# Function to display the menu
display_menu() {
    clear
    echo "Installation Menu:"
    echo "1. Install LAMP Server (Apache, MySQL, PHP)"
    echo "2. Install PHPMyAdmin"
    echo "3. Install Git"
    echo "4. Quit"
}

# Function to install the LAMP Server
install_lamp() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt install apache2 -y
    sudo apt install mysql-server -y
    sudo apt install php php-mysql -y
    sudo systemctl restart apache2
    sudo systemctl restart mysql
    sudo systemctl enable apache2
    sudo systemctl enable mysql
    echo "LAMP Server installation completed."
    echo "Please make a note of your MySQL root password below."
    read -p "Press Enter to continue..."
}

# Function to install PHPMyAdmin
install_phpmyadmin() {
    sudo apt update
    sudo apt install phpmyadmin -y
    sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
    sudo a2enconf phpmyadmin.conf
    sudo systemctl restart apache2
    echo "PHPMyAdmin installation completed."
    read -p "Press Enter to continue..."
}

# Function to install Git
install_git() {
    sudo apt update
    sudo apt install git -y
    echo "Git installation completed."
    read -p "Press Enter to continue..."
}

# Main menu
while true
do
    display_menu
    read -p "Enter the number of the option you want (1-4): " choice
    case $choice in
        1) install_lamp ;;
        2) install_phpmyadmin ;;
        3) install_git ;;
        4) exit ;;
        *) echo "Invalid option. Please enter a valid number (1-4)." ;;
    esac
done
