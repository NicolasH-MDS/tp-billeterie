#!/bin/bash
# scripts/rotate-jwt.sh
# Rotation automatique du secret JWT avec historique (clé du jour + veille)

SECRET_FILE="/app/secrets/jwt_secret"
TMP_FILE="/app/secrets/jwt_secret.tmp"

# Lire l'ancien secret (ligne 1)
OLD_SECRET=""
if [ -f "$SECRET_FILE" ]; then
  OLD_SECRET=$(head -n 1 "$SECRET_FILE")
fi

# Générer le nouveau secret
openssl rand -base64 32 > "$TMP_FILE"

# Écrire le nouveau secret (ligne 1) et l'ancien secret (ligne 2)
echo "$OLD_SECRET" >> "$TMP_FILE"

# Remplacer le fichier atomiquement
mv "$TMP_FILE" "$SECRET_FILE"

# Logger l'action
LOG_FILE="/app/logs/security.log"
echo "[$(date)] Rotation automatique du secret JWT effectuée." >> "$LOG_FILE"
