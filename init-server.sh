#!/bin/bash
# init-server.sh (À lancer une seule fois par l'Ops sur le serveur)
echo "Initialisation du serveur de Production..."

# 1. Créer le dossier secret s'il n'existe pas
mkdir -p ./secrets

# 2. Générer un secret JWT hautement sécurisé de manière aléatoire
openssl rand -base64 32 > ./secrets/jwt_secret

# 3. Sécuriser les permissions du fichier (seul l'admin et Docker peuvent le lire)
chmod 600 ./secrets/jwt_secret

echo "Fichier jwt_secret généré avec succès en local sur le serveur."
