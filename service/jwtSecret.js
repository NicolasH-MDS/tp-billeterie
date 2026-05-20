// service/jwtSecret.js
// Utilitaire pour lire dynamiquement le secret JWT (supporte rotation)

const fs = require('fs');
const path = require('path');

// Chemin du secret (adapter pour prod/dev)
const SECRET_PATH = process.env.JWT_SECRET_PATH || '/run/secrets/jwt_secret';

function readSecrets() {
  try {
    const content = fs.readFileSync(SECRET_PATH, 'utf8');
    const [current, previous] = content.split('\n');
    return { current: current.trim(), previous: (previous || '').trim() };
  } catch (err) {
    throw new Error('Impossible de lire le secret JWT : ' + err.message, { cause: err });
  }
}

module.exports = {
  getSigningKey: () => readSecrets().current,
  getVerificationKeys: () => {
    const { current, previous } = readSecrets();
    return [current, previous].filter(Boolean);
  }
};
