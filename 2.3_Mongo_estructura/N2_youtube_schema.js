const { ObjectId } = require("bson");


/**
 * Connexió dal servidor
 */
const url = 'mongodb://172.20.0.2:27017'; // mongodb docker
/**
 * Base de dades
 */
const database = "youtube";


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
        dis_like: {
          bsonType: ['array'],
          additionalProperties: false,
          items: {
            bsonType: ['object'],
            required: ['video_id', 'datahora', 'like'],
            additionalProperties: false,
            properties: {
              video_id: { bsonType: 'objectId', description: 'Ref a video' },
              datahora: { bsonType: 'date' },
              like: { bsonType: 'bool' }
            }
          }
        },
        subscripcions: {
          bsonType: ['array'],
          additionalProperties: false,
          items: { 
            bsonType: ['object'],
            required: ['canal_id', 'nom'],
            additionalProperties: false,
            properties: {
              canal_id: { bsonType: 'objectId', description: 'Ref a canal' },
              nom: { bsonType: 'string' }
            }
          }
        }
      }
    }
  },
  video: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'video',
      description: 'Fiquem tota la info necessaria per mostrar un video',
      additionalProperties: false,
      required: ['_id', 'titol', 'arxiu'],
      properties: {
        _id: { bsonType: 'objectId' },
        titol: { bsonType: 'string' },
        descripcio: { bsonType: 'string' },
        mida: { bsonType: 'number' },
        arxiu: { bsonType: 'string' },
        durada: { bsonType: 'number' },
        thumb: { bsonType: 'string' },
        n_reproduccions: { bsonType: 'number' },
        n_likes: { bsonType: 'number' },
        n_dislikes: { bsonType: 'number' },
        estat: { enum: ['public', 'ocult', 'privat'] },
        data_publicacio: { bsonType: 'date' },
        publicat_per: {
          bsonType: 'object',
          additionalProperties: false,
          properties: {
            usuari_id: { bsonType: 'objectId' },
            username: { bsonType: 'string', description: '(Extended Reference Pattern)' },
          }
        },
        etiquetes: {
          bsonType: ['array'],
          additionalProperties: false,
          items: { bsonType: ['string'] }
        },
        comentaris_recents: {
          bsonType: ['array'],
          description: 'Ultims 20 comentaris del video (Subset Pattern)',
          maxItems: 20,
          additionalProperties: false,
          items: {
            bsonType: ['object'],
            additionalProperties: false,
            properties: {
              _id: { bsonType: 'objectId' },
              creat_per: { bsonType: 'objectId' },
              username: { bsonType: 'string' },
              datahora: { bsonType: 'date' },
              text: { bsonType: 'string' }
            }
          }
        }
      }
    }
  },
  comentari: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'comentari',
      additionalProperties: false,
      required: ['_id', 'creat_per', 'username', 'video_id', 'datahora', 'text'],
      properties: {
        _id: { bsonType: 'objectId' },
        creat_per: { bsonType: 'objectId', description: 'Ref a usuari' },
        username: { bsonType: 'string', description: '(Extended Reference Pattern)' },
        video_id: { bsonType: 'objectId' },
        datahora: { bsonType: 'date' },
        text: { bsonType: 'string' },
        des_agrada: {
          bsonType: ['array'],
          required: ['usuari_id', 'datahora', 'agrada'],
          additionalProperties: false,
          items: {
            bsonType: ['object'],
            additionalProperties: false,
            properties: {
              usuari_id: { bsonType: 'objectId', description: 'Ref a usuari' },
              datahora: { bsonType: 'date' },
              agrada: { bsonType: 'bool' }
            }
          }
        },
      }
    }
  },
  playlist: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'playlist',
      required: ['_id','nom','datahora','estat','creada_per'],
      additionalProperties: false,
      properties: {
        _id: { bsonType: 'objectId' },
        nom: { bsonType: 'string' },
        datahora: { bsonType: 'date' },
        estat: { enum: ['public', 'ocult', 'privat'] },
        creada_per: { bsonType: 'objectId' },
        videos: {
          bsonType: ['array'],
          additionalProperties: false,
          items: { bsonType: ['objectId'] }
        }
      }
    }
  },
  canal: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'canal',
      additionalProperties: false,
      properties: {
        _id: { bsonType: 'objectId' },
        nom: { bsonType: 'string' },
        descripcio: { bsonType: 'string' },
        data_creacio: { bsonType: 'date' },
        creat_per: { bsonType: 'objectId', description: 'Ref a usuari' },
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
     usuari: [
      {
        _id: ObjectId('61a65f76b4422cb67be5bfa9'), email: 'pep@aaa.com', password: 'secret1', username: 'pep', data_neixament: new Date('2000-01-01'), sexe: 'M', pais: 'Andorra', cp: '00001',
      },
      {
        _id: ObjectId('61a66095b4422cb67be5bfaa'), email: 'joan@bbb.com', password: 'secret2', username: 'joan', data_neixament: new Date('1980-01-01'), sexe: 'M', pais: 'Andorra', cp: '00001',
        subscripcions: [{canal_id: ObjectId('61a67af5b4422cb67be5bfb0'), nom: 'canal js'}],
      },
      {
        _id: ObjectId('61a6609db4422cb67be5bfab'), email: 'maria@ccc.com', password: 'secret3', username: 'maria', data_neixament: new Date('1999-01-01'), sexe: 'F', pais: 'Espanya', cp: '08080',
        dis_like: [{ video_id: ObjectId('61a661c9b4422cb67be5bfac'), datahora: new Date('2020-02-02'), like: true }],
      }
  
    ],
     video: [
      {
        _id: ObjectId('61a661c9b4422cb67be5bfac'), titol: 'JavaScript Crash Course', descripcio: 'Learn JavaScript', mida: 1238877, arxiu: 'js_course.mp4',
        durada: 2103, thumb: 'th_js_course.png', n_reproduccions: 33, n_likes: 22, n_dislikes: 3, estat: 'public', data_publicacio: new Date('2020-01-01'),
        publicat_per: { usuari_id: ObjectId('61a65f76b4422cb67be5bfa9'), username: 'pep' },
        etiquetes: ['javascript', 'programming', 'course'],
        comentaris_recents: [
          {
            _id: ObjectId('61a676dab4422cb67be5bfae'), creat_per: ObjectId('61a66095b4422cb67be5bfaa'), username: 'joan',
            datahora: new Date('2020-03-03'), text: 'Molt bon video!!'
          }
        ]
      },
      {
        _id: ObjectId('61a664c7b4422cb67be5bfad'), titol: 'Learn JS', descripcio: 'Learn JavaScript', mida: 3238877, arxiu: 'learn_js.mp4',
        durada: 2503, thumb: 'th_learn_js.png', n_reproduccions: 15, n_likes: 4, n_dislikes: 4, estat: 'public', data_publicacio: new Date('2021-01-01'),
        publicat_per: { usuari_id: ObjectId('61a65f76b4422cb67be5bfa9'), username: 'pep' },
        etiquetes: ['javascript', 'programming']
      },
    ],
    comentari: [
      {
        _id: ObjectId('61a676dab4422cb67be5bfae'), creat_per: ObjectId('61a66095b4422cb67be5bfaa'), username: 'joan',
        video_id: ObjectId('61a661c9b4422cb67be5bfac'), datahora: new Date('2020-03-03'),
        text: 'Molt bon video!!',
        des_agrada: [
          { usuari_id: ObjectId('61a6609db4422cb67be5bfab'), datahora: new Date('2020-05-04'), agrada: true },
        ]
      }
    ], 
  playlist: [
    {
      _id: ObjectId('61a679f5b4422cb67be5bfaf'), nom: 'javascript', 
      datahora: new Date('2020-05-05'), estat: 'public', creada_per:ObjectId('61a65f76b4422cb67be5bfa9'),
      videos: [ObjectId('61a661c9b4422cb67be5bfac'), ObjectId('61a664c7b4422cb67be5bfad')]
    }
  ],
  canal: [
    {
      _id: ObjectId('61a67af5b4422cb67be5bfb0'), nom: 'canal js', descripcio: 'Videos de js',
      data_creacio: new Date('2020-05-01'), creat_per: ObjectId('61a65f76b4422cb67be5bfa9')
    }
  ]
};


module.exports = { url, database, schemaBD, indexBD, inserts }