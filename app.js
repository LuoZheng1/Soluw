var express = require("express"),
  ejs = require("ejs");
const conexion = require('./database/db');
var {config} = require('dotenv');
var morgan = require('morgan');
var app = express();

app.use(morgan('dev'));
config()
app.set("view engine", "ejs");
app.use(express.static("public"));
app.use(express.json());
app.use(express.urlencoded({extended:false}));

app.use('/', require('./router'));

app.set("port", process.env.PORT || 3000);
  
app.listen(app.get("port"), function() {
  console.log(
    "Servidor iniciado en http://localhost:" +
      app.get("port") +
      "; presiona Ctrl-C para terminar."
  );
});




