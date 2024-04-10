#!/bin/bash

# Remplacez ces valeurs par les vôtres
GITHUB_USERNAME="Rab3ii"
GITHUB_TOKEN="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"

# Demande à l'utilisateur d'entrer le nom du projet
read -p "Veuillez entrer le nom du projet GitHub : " PROJECT_NAME

# Configure le cache d'informations d'identification
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
git config --global credential.https://github.com.username "$GITHUB_USERNAME"

# Met à jour l'URL du remote avec le jeton d'accès et le nom du projet
git remote set-url origin "https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$PROJECT_NAME.git"
