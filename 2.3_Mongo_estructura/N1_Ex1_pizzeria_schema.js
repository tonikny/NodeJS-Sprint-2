const { ObjectId } = require("bson");


/**
 * Connexió dal servidor
 */
const url = 'mongodb://172.17.0.4:27017'; // mongodb docker
/**
 * Base de dades
 */
const database = "pizzeria";


/**
 * Esquema de la base de dades
 */
const schemaBD = {
  client: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'client',
      additionalProperties: false,
      required: ['_id', 'nom', 'cognoms'],
      properties: {
        _id: { bsonType: 'objectId' },
        nom: { bsonType: 'string' },
        cognoms: { bsonType: 'string' },
        adreca: { bsonType: 'string' },
        cp: { bsonType: 'string' },
        localitat: { bsonType: 'string' },
        provincia: { bsonType: 'string' },
        telf: { bsonType: 'string' }
      }
    },
  },
  producte: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'producte',
      additionalProperties: false,
      required: ['_id', 'nom', 'preu'],
      properties: {
        _id: { bsonType: 'objectId' },
        nom: { bsonType: 'string' },
        descripcio: { bsonType: 'string' },
        imatge: { bsonType: 'string' },
        preu: { bsonType: 'number' },
        tipus: { enum: ['pizza', 'hamburguesa', 'beguda'] },
        categoria: { bsonType: 'string' },
      }
    }
  },
  botiga: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'botiga',
      additionalProperties: false,
      required: ['_id'],
      properties: {
        _id: { bsonType: 'objectId' },
        adreca: { bsonType: 'string' },
        cp: { bsonType: 'string' },
        localitat: { bsonType: 'string' },
        província: { bsonType: 'string' },
        empleat: {
          bsonType: ["array"],
          additionalProperties: false,
          items: {
            bsonType: ["object"],
            additionalProperties: false,
            required: ['_id', 'nom', 'cognoms', 'nif', 'carrec'],
            properties: {
              _id: { bsonType: 'objectId' },
              nom: { bsonType: 'string' },
              cognoms: { bsonType: 'string' },
              nif: { bsonType: 'string' },
              telf: { bsonType: 'string' },
              carrec: { enum: ['cuiner', 'repartidor'] }
            }
          },
        }
      }
    }
  },
  comanda: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'comanda',
      additionalProperties: false,
      required: ['_id', 'data'],
      properties: {
        _id: { bsonType: 'objectId' },
        client_id: { bsonType: 'objectId', description: 'FK a client' },
        botiga_id: { bsonType: 'objectId', description: 'FK a botiga' },
        a_domicili: { bsonType: 'bool' },
        data: { bsonType: 'date' },
        preu: { bsonType: 'number' },
        linia: {
          bsonType: ["array"],
          minItems: 1,
          uniqueItems: true,
          additionalProperties: false,
          items: {
            bsonType: ["object", 'string'],
            additionalProperties: false,
            properties: {
              producte: {
                bsonType: ["object"],
                required: ["nom"],
                additionalProperties: false,
                properties: {
                  producte_id: { bsonType: 'objectId', description: 'FK a producte' },
                  nom: { bsonType: "string" },
                }
              },
              quantitat: { bsonType: 'number' },
            }
          }
        },
        repartidor: {
          bsonType: 'object',
          additionalProperties: false,
          required: ['_id', 'nom'],
          properties: {
            _id: { bsonType: 'objectId', description: 'FK a empleat' },
            nom: { bsonType: 'string' }
          }
        },
        lliurament: { bsonType: 'date' },
      }
    }
  }
};


/**
 * Indexs unique de la base de dades
 */
const indexBD = {

};


/**
 * Inserts a la base de dades
 */
const inserts = {
  client: [
    { _id: ObjectId("619e4faa96adebe31fc2dc2b"), nom: 'Pere', cognoms: 'Primer Segon', adreca: 'Balmes,159', cp: '08999', localitat: 'Bcn', provincia: 'Bcn', telf: '+34666554411' },
    { _id: ObjectId("619f5e1b96adebe31fc2dc31"), nom: 'Joan', cognoms: 'Primer Segon', adreca: 'Balmes,157', cp: '08999', localitat: 'Bcn', provincia: 'Bcn', telf: '+34666554444' },
  ],
  producte: [
    { _id: ObjectId("619e4f4d96adebe31fc2dc29"), nom: 'pizza margarita', descripcio: 'pizza bàsica', imatge: 'http:/imageserver/margarita', preu: 8.5, tipus: 'pizza', categoria: 'basica' },
    { _id: ObjectId("619f645596adebe31fc2dc32"), nom: 'hamburguesa completa', descripcio: 'hamburguesa completa', imatge: 'http:/imageserver/hamcomp', preu: 6.0, tipus: 'hamburguesa' },
    { _id: ObjectId("619f64a996adebe31fc2dc33"), nom: 'cervesa', descripcio: 'cervesa normal', imatge: 'http:/imageserver/cervesa', preu: 1.8, tipus: 'beguda' },
  ],
  botiga: [
    {
      _id: ObjectId("619f663396adebe31fc2dc34"), adreca: 'Balmes, 180', cp: '08999', localitat: 'Bcn', província: 'Bcn',
      empleat: [
        { _id: ObjectId("619f66b496adebe31fc2dc35"), nom: 'Josep', cognoms: ' Un Dos', nif: '12341234Z', telf: '666778899', carrec: 'repartidor' },
        { _id: ObjectId("619f674696adebe31fc2dc36"), nom: 'Joan', cognoms: 'Dos Tres', nif: '44441234Y', telf: '666991122', carrec: 'cuiner' }
      ]
    }
  ],
  comanda: [
    {
      _id: ObjectId("619f68e196adebe31fc2dc37"), client_id: ObjectId("619e4faa96adebe31fc2dc2b"), botiga_id: ObjectId("619f663396adebe31fc2dc34"),
      a_domicili: false, data: new Date(Date.now()), preu: 7.8,
      linia: [
        { producte: { producte_id: ObjectId("619f645596adebe31fc2dc32"), nom: 'hamburguesa completa' }, quantitat: 1 },
        { producte: { producte_id: ObjectId("619f64a996adebe31fc2dc33"), nom: 'cervesa' }, quantitat: 1 }
      ]
    } 
  ],
};


module.exports = { url, database, schemaBD, indexBD, inserts }