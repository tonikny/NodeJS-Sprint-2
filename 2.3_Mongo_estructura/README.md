# NodeJS Estructures MongoDB

* ## Arxius *_schema.js -->  validacions, indexs i inserts
* ## Arxius *.png ---> model gràfic
* ## Arxiu dbLoader.js -->  carregador de l'esquema, validacions, indexs i inserts
  * Ús: 
    
        node dbLoader.js arxiu-schema [drop]
    * __drop__: esborra la bd i la torna a crear (opcional)
* ## Configuració:
  * ### A cada *_schema.js s'ha de configurar la url de la base de dades
    * (actualment la ip del meu docker mongoDb)