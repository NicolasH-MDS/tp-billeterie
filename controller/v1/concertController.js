//Déclarer nos middleware 'routeur' frontaux : manipule la requete et la réponse.

const concertRepository = require('../../repository/concertRepository');

/**
 * GET /concerts
 * Retourne la liste des concerts à venir
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 */
function all(req, res, next) {

  //1. Appeller le repository pour récupérer les données
  const concerts = concertRepository.all();

  //Fabrication de la réponse HTTP
  //Content type
  res.set('Content-Type', 'application/hal+json');
  //Code status
  res.status(200);
  //Fin au cycle requete/repose
  res.json(concerts);
}

module.exports = { all };
