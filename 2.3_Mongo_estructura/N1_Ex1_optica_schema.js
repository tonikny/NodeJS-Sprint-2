const { ObjectId } = require("bson");


/**
 * Connexió dal servidor
 */
 const url = 'mongodb://172.20.0.2:27017'; // mongodb docker
/**
 * Base de dades
 */
 const database = "optica";


/**
 * Esquema de la base de dades
 */
const schemaBD = {
  proveidor: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'proveidor',
      additionalProperties: false,
      required: ['_id', 'nom'],
      properties: {
        _id: { bsonType: 'objectId' },
        nom: { bsonType: 'string' },
        nif: { bsonType: 'string' },
        fax: { bsonType: 'string' },
        telf: { bsonType: 'string' },
        adreca: {
          bsonType: 'object',
          additionalProperties: false,
          properties: {
            carrer: { bsonType: 'string' },
            num: { bsonType: 'string' },
            pis: { bsonType: 'string' },
            porta: { bsonType: 'string' },
            cp: { bsonType: 'string' },
            ciutat: { bsonType: 'string' },
            pais: { bsonType: 'string' }
          }
        }
      }
    }
  },
  venda: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'venda',
      additionalProperties: false,
      required: ['_id', 'graduacio_esq', 'graduacio_dta', 'preu'],
      properties: {
        _id: { bsonType: 'objectId' },
        graduacio_esq: { bsonType: 'double' },
        graduacio_dta: { bsonType: 'double' },
        color_vidres: { bsonType: 'string' },
        montura: { bsonType: 'string' },
        color_mont: { bsonType: 'string' },
        marca: { bsonType: 'string' },
        preu: { bsonType: 'double' },
        empleat: {
          bsonType: 'object',
          additionalProperties: false,
          properties: {
            codi: { bsonType: 'string' },
            nom: { bsonType: 'string' }
          }
        },
        client: {
          bsonType: 'object',
          title: 'client',
          additionalProperties: false,
          required: ['_id', 'nom', 'data_registre'],
          properties: {
            _id: { bsonType: 'objectId' },
            nom: { bsonType: 'string' },
            telf: { bsonType: 'string' },
            email: { bsonType: 'string' },
            data_registre: { bsonType: 'date' },
            adreca: {
              bsonType: 'object',
              additionalProperties: false,
              properties: {
                carrer: { bsonType: 'string' },
                num: { bsonType: 'string' },
                pis: { bsonType: 'string' },
                porta: { bsonType: 'string' },
                cp: { bsonType: 'string' },
                ciutat: { bsonType: 'string' },
                pais: { bsonType: 'string' }
              }
            },
            recomanaId: { bsonType: 'objectId' }
          }
        },
        proveidorId: { bsonType: 'objectId', description: 'FK a proveidor' },
        data_venda: { bsonType: 'date' }
      }
    }
  }
};


/**
 * Indexs unique de la base de dades
 */
const indexBD = {
  proveidor: [
    { nif: 1 }
  ]
};


/**
 * Inserts a la base de dades
 */
const inserts = {
  proveidor: [
    {_id:ObjectId("619e4f4d96adebe31fc2dc29"),nom:'DistriOpti',nif:'12345678A'},
    {_id:ObjectId("619e4f8896adebe31fc2dc2a"),nom:'DisOpticas',nif:'12348768A'}
  ],
  venda: [
    {_id:ObjectId("619e4fd796adebe31fc2dc2e"),graduacio_esq:0.5,graduacio_dta:1.4,color_vidres:'blanc',montura:'pasta',color_mont:'verd',marca:'Rayblan',preu:39.99,
    empleat:{codi:'A002',nom:'Jordi'},client:{_id:ObjectId("619e4faa96adebe31fc2dc2b"),nom:'Pere',data_registre:new Date(Date.now())},
    proveidorId:ObjectId("619e4f4d96adebe31fc2dc29"),data_venda:new Date('2021-02-02') },
    {_id:ObjectId("619e53fb96adebe31fc2dc2f"),graduacio_esq:2.5,graduacio_dta:1.9,color_vidres:'blanc',montura:'metal',color_mont:'negre',marca:'Optiglass',preu:69.99,
    empleat:{codi:'C003',nom:'Pep'},client:{_id:ObjectId("619e4fbb96adebe31fc2dc2c"),nom:'Joan',data_registre:new Date(Date.now()),recomanaId:ObjectId("619e4faa96adebe31fc2dc2b")},
    proveidorId:ObjectId("619e4f4d96adebe31fc2dc29"),data_venda:new Date('2021-02-02') },
  ]
};


  module.exports = { url, database, schemaBD, indexBD, inserts }