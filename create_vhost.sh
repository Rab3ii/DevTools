#!/bin/bash

# Vérifie si l'utilisateur a les privilèges d'administrateur (root)
if [ "$(whoami)" != "root" ]; then
    echo "Ce script doit être exécuté en tant qu'administrateur (root)."
    exit 1
fi

# Vérifie si Apache est installé
if ! [ -x "$(command -v apache2)" ]; then
    echo "Apache n'est pas installé sur ce système. Veuillez installer Apache d'abord."
    exit 1
fi

# Vérifie si le module rewrite est déjà activé
if apache2ctl -M | grep -q 'rewrite_module'; then
    echo "Le module rewrite est déjà activé."
else
    # Active le module rewrite
    sudo a2enmod rewrite
    echo "Le module rewrite a été activé avec succès."
fi

# Demande à l'utilisateur de saisir les informations pour le virtual host
read -p "Nom de domaine de l'hôte virtuel (ex: monsite.local) : " nom_domaine
read -p "Chemin absolu du dossier racine (ex: /chemin/vers/mon/projet) : " dossier_racine

# Crée le fichier de configuration de l'hôte virtuel
fichier_conf_apache="/etc/apache2/sites-available/$nom_domaine.conf"
echo "<VirtualHost *:80>
    ServerAdmin webmaster@$nom_domaine
    ServerName $nom_domaine
    DocumentRoot $dossier_racine
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    <Directory $dossier_racine>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee $fichier_conf_apache > /dev/null

# Crée un lien symbolique vers le fichier de configuration dans sites-enabled
sudo ln -s $fichier_conf_apache /etc/apache2/sites-enabled/

# Redémarre Apache pour appliquer les changements
sudo systemctl restart apache2

# Ajoute une entrée dans le fichier hosts pour le domaine local
echo "127.0.0.1   $nom_domaine" | sudo tee -a /etc/hosts > /dev/null

# Message de confirmation
echo "Hôte virtuel $nom_domaine créé avec succès."

