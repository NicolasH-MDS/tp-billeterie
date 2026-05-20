# ---- Etape 1 : Build des dépendances ----
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

# ---- Etape 2 : Runtime sécurisé ----
FROM node:20-alpine AS runtime

WORKDIR /app

# Copie uniquement les fichiers nécessaires
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json ./
COPY --from=build /app/index.js ./
COPY --from=build /app/controller ./controller
COPY --from=build /app/data ./data
COPY --from=build /app/model ./model
COPY --from=build /app/repository ./repository
COPY --from=build /app/router ./router
COPY --from=build /app/service ./service

# Variables d'environnement par défaut
ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "index.js"]
