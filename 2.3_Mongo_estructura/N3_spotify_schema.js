const { ObjectId } = require("bson");


/**
 * Connexió dal servidor
 */
const url = 'mongodb://172.20.0.2:27017'; // mongodb docker
/**
 * Base de dades
 */
const database = "spotify";


/**
 * Esquema de la base de dades
 */
const schemaBD = {
  usuari: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'usuari',
      additionalProperties: false,
      required: ['_id', 'email', 'password', 'username'],
      properties: {
        _id: { bsonType: 'objectId' },
        email: { bsonType: 'string' },
        password: { bsonType: 'string' },
        username: { bsonType: 'string' },
        data_neixament: { bsonType: 'date' },
        sexe: { bsonType: 'string' },
        pais: { bsonType: 'string' },
        cp: { bsonType: 'string' },
        premium: { bsonType: 'bool' },
        subscripcio: {
          bsonType: 'object',
          title: 'subscripcio',
          additionalProperties: false,
          required: ['_id', 'data_inici', 'data_renovacio'],
          properties: {
            _id: { bsonType: 'objectId' },
            data_inici: { bsonType: 'date' },
            data_renovacio: { bsonType: 'date' },
            pagament: {
              bsonType: 'object',
              additionalProperties: false,
              required: ['num_ordre', 'data', 'total'],
              properties: {
                num_ordre: { bsonType: 'number' },
                data: { bsonType: 'date' },
                total: { bsonType: 'number' },
                username_paypal: { bsonType: 'string' },
                num_card: { bsonType: 'string' },
                mes_card: { bsonType: 'string' },
                any_card: { bsonType: 'string' },
                codi_card: { bsonType: 'string' },
              },
              oneOf: [
                { required: ["username_paypal"] },
                { required: ["num_card", "mes_card", "any_card", "codi_card"] }
              ]
            }
          }
        },
        artistes_seguits: {
          bsonType: ['array'],
          additionalProperties: false,
          items: { bsonType: ['objectId'], description: 'Ref a artista' }
        },
        albums_favorits: {
          bsonType: ['array'],
          additionalProperties: false,
          items: { bsonType: ['objectId'], description: 'Ref a album' }
        },
        cancons_favorites: {
          bsonType: ['array'],
          additionalProperties: false,
          items: { bsonType: ['objectId'], description: 'Ref a canco' }
        },
      }
    }
  },
  artista: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'artista',
      additionalProperties: false,
      required: ['_id', 'nom'],
      properties: {
        _id: { bsonType: 'objectId' },
        nom: { bsonType: 'string' },
        imatge: { bsonType: 'string' },
        relacio: {
          bsonType: ['array'],
          additionalProperties: false,
          items: { bsonType: ['objectId'], description: 'Ref a artista' }
        },
        album: {
          bsonType: ['array'],
          additionalProperties: false,
          items: {
            bsonType: 'object',
            title: 'album',
            additionalProperties: false,
            required: ['_id', 'titol'],
            properties: {
              _id: { bsonType: 'objectId' },
              titol: { bsonType: 'string' },
              any: { bsonType: 'string' },
              imatge: { bsonType: 'string' },
              canco: {
                bsonType: ['array'],
                additionalProperties: false,
                items: {
                  bsonType: 'object',
                  title: 'canco',
                  additionalProperties: false,
                  required: ['_id', 'titol'],
                  properties: {
                    _id: { bsonType: 'objectId' },
                    titol: { bsonType: 'string' },
                    durada: { bsonType: 'number' },
                    n_reproduccions: { bsonType: 'number' },
                  }
                }
              }
            }
          }
        }
      }
    }
  },
  playlist: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'playlist',
      required: ['_id', 'titol', 'data_creacio'],
      additionalProperties: false,
      properties: {
        _id: { bsonType: 'objectId' },
        titol: { bsonType: 'string' },
        data_creacio: { bsonType: 'date' },
        data_esborrat: { bsonType: 'date' },
        creada_per: { bsonType: 'objectId', description: 'Ref a usuari' },
        cancons: {
          bsonType: ['array'],
          additionalProperties: false,
          items: {
            bsonType: ['object'],
            additionalProperties: false,
            properties: {
              canco_id: { bsonType: 'objectId', description: 'Ref a canco' },
              titol: { bsonType: 'string' },
              compartida_per: { bsonType: 'objectId' },
              compartida_al: { bsonType: 'date' },
            }
          }
        }
      }
    }
  },

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
  artista: [
    {
      _id: ObjectId('61aa2c91b4422cb67be5bfb2'), nom: 'First Band', imatge: 'http://url.a.a.imatge/arxiu1'
    },
    {
      _id: ObjectId('61aa2dabb4422cb67be5bfb3'), nom: 'More RnR', imatge: 'http://url.a.a.imatge/arxiu2',
      relacio: [ObjectId('61aa2c91b4422cb67be5bfb2')],
      album: [
        {
          _id: ObjectId('61aa2ec4b4422cb67be5bfb4'), titol: 'The Beginning', any: '2004', imatge: 'http://url.a.a.imatge/album1',
          canco: [
            {
              _id: ObjectId('61aa2ecbb4422cb67be5bfb5'), titol: 'In the beginning', durada: 303, n_reproduccions: 15,
            },
            {
              _id: ObjectId('61aa308cb4422cb67be5bfb7'), titol: 'The last one', durada: 163, n_reproduccions: 25,
            }
          ]
        },
        {
          _id: ObjectId('61aa2f54b4422cb67be5bfb6'), titol: 'The End', any: '2005', imatge: 'http://url.a.a.imatge/album2',
          canco: [
            {
              _id: ObjectId('61aa30d1b4422cb67be5bfb8'), titol: 'Summer', durada: 144, n_reproduccions: 33
            }
          ]
        }
      ],
    }
  ],
  usuari: [
    {
      _id: ObjectId("61aa31a5b4422cb67be5bfb9"), email: 'pep@aaaa.com', password: '3kjn324jdi0', username: 'pep',
      data_neixament: new Date('1999-12-12'), sexe: 'M', pais: 'Andorra', cp: '00001', //premium: true,
      subscripcio: {
        _id: ObjectId("61aa3355b4422cb67be5bfba"), data_inici: new Date('2012-12-12'), data_renovacio: new Date('2013-12-12'),
        pagament: { num_ordre: 22, data: new Date('2012-12-12'), total: 24.99, username_paypal: 'pepep' }
      },
      artistes_seguits: [ObjectId('61aa2dabb4422cb67be5bfb3')],
      albums_favorits: [ObjectId('61aa2ec4b4422cb67be5bfb4')],
      cancons_favorites: [ObjectId('61aa30d1b4422cb67be5bfb8')]
    }
  ],
  playlist: [
    {
      _id: ObjectId('61aa3fd7b4422cb67be5bfbb'), titol: 'myplaylist', data_creacio: new Date('2015-12-12'),
      creada_per: ObjectId("61aa31a5b4422cb67be5bfb9"),
      cancons: [
        {
          canco_id: ObjectId('61aa30d1b4422cb67be5bfb8'), titol: 'Summer',
          compartida_per: ObjectId("61aa31a5b4422cb67be5bfb9"), compartida_al: new Date('2015-12-15')
        }
      ]
    }
  ]
};


module.exports = { url, database, schemaBD, indexBD, inserts }