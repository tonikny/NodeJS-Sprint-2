const MongoClient = require('mongodb').MongoClient;

/**
 * Importació de l'esquema a partir del paràmetre
 */
let schema;
const schema_file = process.argv[2];
if (!schema_file) {
  console.log("Falta l'arxiu d'esquema");
  console.log("Ús: node dbLoader.js arxiu-schema [drop]");
  return;
}
try {
  schema = require("./" + schema_file);
} catch (err) {
  if (err.code == 'MODULE_NOT_FOUND') {
    console.log("Arxiu d'esquema no trobat");
    return;
  } else {
    throw (err);
  }
}
// Si el seguent paràmetre es 'drop' esborrem la bd previament
let drop = false;
if (process.argv[3] == 'drop') drop = true;

/**
 * Comencem les operacions
 */
start();

/**
 * Funcions d'accions
 */

async function start() {
  const client = await MongoClient.connect(schema.url, { useNewUrlParser: true })
    .catch(err => { console.log('No connectat a la bd', err); });
  if (!client) {
    console.log('No hi ha client de la bd');
    return;
  }
  try {
    const db = client.db(schema.database);
    console.log('--------- Esborrant base de dades -----');
    if (drop) {
      /**
       * Drop database
       */
      db.dropDatabase();
      console.log(schema.database, 'esborrada');
    }
    console.log('\n--------- Creant schemas --------------');
    for (const [col, sch] of Object.entries(schema.schemaBD)) {
      /**
       * Creació dels schemas i validadors
       */
      await validator(db, col, sch);
    }

    console.log('\n--------- Creant indexs ---------------');
    for (const [col, idxs] of Object.entries(schema.indexBD)) {
      /**
       * Creació dels indexs
       */
      await indexs(db, col, idxs);
    }

    console.log('\n--------- Inserint documents ----------');
    for (const [col, idxs] of Object.entries(schema.inserts)) {
      /**
       * Inserció de dades
       */
      await insert(db, col, idxs);
    }
  } catch (err) {
    console.log('Consulta fallida\n', err);
  } finally {
    client.close();
  }
}

async function validator(db, col, schema) {
  try {
    const res = await db.createCollection(col, { validator: schema, validationAction: "error" });
    console.log('Creant col·lecció:', col);
  } catch (err) {
    if (err.codeName == 'NamespaceExists') {  // MongoServerError: Collection already exists.
      const res = await db.command({ collMod: col, validator: schema, validationAction: "error" });
      console.log('Modificar col·lecció:', col, res);
    }
    else {
      console.log(err);
    }
  }
}

async function indexs(db, col, idxs) {
  console.log(col);
  for (const idx of idxs) {
    try {
      const res = await db.collection(col).createIndex(idx, { unique: true });
      console.log('  - index', res);
    } catch (err) {
      if (err.codeName == 'IndexOptionsConflict') {  // MongoServerError: Index already exists with a different name
        console.log("Ja exixteix l'index amb un altre nom");
      }
      else {
        console.log(err);
      }
    }
  }
}

async function insert(db, col, objs) {
  try {
    const res = await db.collection(col).insertMany(objs, { ordered: false });
    console.log('Inserits (', col, '):', res.insertedCount);
  } catch (err) {
    //console.log('---', err.writeErrors.length);
    if (err.code == 121) {  // MongoBulkWriteError: Document failed validation 
      console.log(col, "Error de validació", JSON.stringify(err));
    } else if (err.code == 11000) {  // MongoBulkWriteError: E11000 duplicate key error collection
      console.log(col, "Error _id duplicat");
    } else {
      console.log('ERR', err);
      return;
    }
    console.log(col, 'Documents processats:', err.result.result.insertedIds.length);
    console.log(col, 'Documents insertats :', err.result.result.nInserted);
  }
}



async function findAll(db, col) {
  let collection = db.collection(col);
  let res = await collection.find();
  return await res.toArray();
}
