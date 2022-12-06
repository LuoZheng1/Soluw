const express = require('express');
const router = express.Router();
const axios = require('axios');
const bcryptjs=require('bcryptjs');
const conexion = require('./database/db');
const session =require('express-session');

let login = false;
let idU = 0;

const dotenv = require('dotenv');
dotenv.config({path:'./views/sections/login.ejs'});

router.use(session({
  secret:'secret',
  resave:true,
  saveUninitialized:true
}));

const CLIENT_ID = process.env.CLIENT_ID;
const SECRET = process.env.SECRET;
const PAYPAL_API = process.env.PAYPAL_API;
const HOST = process.env.HOST;

//Pagina 1 - Principal
router.get('/', (req, res)=>{     
    conexion.query('SELECT servicio_tecnico.idServicoTecnico, especializacion.nombreEspecializacion, servicio.nombreServicio, servicio_tecnico.imagen, servicio.precioServicio, usuario.nombre, usuario.apellido FROM especializacion INNER JOIN servicio ON especializacion.idEspecializacion=servicio.idEspecializacion INNER JOIN servicio_tecnico ON servicio.idServicio=servicio_tecnico.idServicio INNER JOIN tecnico ON servicio_tecnico.idTecnico=tecnico.idTecnico INNER JOIN usuario ON tecnico.idUsuario=usuario.idUsuario WHERE servicio.esPromocion=true',(error, results)=>{
        if(error){
            throw error;
        } else {
            conexion.query('SELECT usuario.idUsuario, usuario.nombre, usuario.apellido, tecnico.valoracion, tecnico.foto FROM usuario INNER JOIN tecnico ON usuario.idUsuario = tecnico.idUsuario WHERE valoracion > 4 LIMIT 3;',(error, tecnico)=>{
              if(error){
                  throw error;
              } else {                       
                  res.render("index", {pagina:1,results:results,tecnico:tecnico});         
              }   
          })              
        }   
    })
})

//Pagina 2 - Servicios
router.get('/Servicios', (req, res)=>{     
  conexion.query('SELECT servicio_tecnico.idServicoTecnico, especializacion.nombreEspecializacion, servicio.nombreServicio, servicio_tecnico.imagen, servicio.precioServicio, usuario.nombre, usuario.apellido FROM especializacion INNER JOIN servicio ON especializacion.idEspecializacion=servicio.idEspecializacion INNER JOIN servicio_tecnico ON servicio.idServicio=servicio_tecnico.idServicio INNER JOIN tecnico ON servicio_tecnico.idTecnico=tecnico.idTecnico INNER JOIN usuario ON tecnico.idUsuario=usuario.idUsuario',(error, results)=>{
      if(error){
          throw error;
      } else {                    
          res.render("index", {pagina:2,results:results});         
      } 
  })
})

//Pagina 3 - Tecnicos
router.get('/Tecnicos', (req, res)=>{     
  conexion.query('SELECT usuario.idUsuario, usuario.nombre, usuario.apellido, tecnico.valoracion, tecnico.foto, especializacion.nombreEspecializacion FROM usuario INNER JOIN tecnico ON usuario.idUsuario = tecnico.idUsuario JOIN tecnico_especializacion ON tecnico.idTecnico = tecnico_especializacion.idTecnico JOIN especializacion ON tecnico_especializacion.idEspecializacion = especializacion.idEspecializacion',(error, tecnicos)=>{
      if(error){
          throw error;
      } else {                     
          res.render("index", {pagina:3,tecnicos:tecnicos});         
      } 
  })
})

//Pagina 4 - Preguntas Frecuentes
router.get("/Preguntas", function(req, res) {
  res.type("text/html");
  res.render(
    "index",
    {
      pagina: 4
    },
    function(err, html) {
      if (err) throw err;
      res.send(html);
    }
  );
});

//Pagina 5 - Sobre Nosotros
router.get("/Contactenos", function(req, res) {
  res.type("text/html");
  res.render(
    "index",
    {
      pagina: 5
    },
    function(err, html) {
      if (err) throw err;
      res.send(html);
    }
  );
});


//Pagina 6 - GET para cargar los elementos del carrito en base a la sesion del usuario
router.get('/cart', (req, res)=>{
  console.log(login);
  const estado = 'Carrito';  
  if (login){
    console.log(idU);
    conexion.query('SELECT * FROM orden WHERE idUsuario=? AND estadoOrden=?',[idU,estado],(error, carrito)=>{ 
      //console.log(carrito);
      if(carrito!=null){
        res.render("index", {pagina:6,carrito:carrito});
      }
      else{
        res.redirect('/Servicios');
      }
    });
  }
  else{
    res.redirect('/Servicios');
  }
});

//POST para eliminar un servicio del carrito
router.get('/eliminar/:id', (req,res)=>{
  const id_Orden=req.params.id;
  conexion.query('DELETE FROM orden WHERE idOrden = ?',[id_Orden], (error, results)=>{
    if(error){
      console.log("Ha ocurrido un error...");
      throw error;
    }
    else{
      console.log("Borrado Exitosamente");
      res.redirect('/cart');
    }
  });
});

//Pagina 7 - Login
router.get("/login", function(req, res) {
	conexion.query('SELECT * FROM usuario WHERE idUsuario =?',[idU], async(err,result)=>{
		if (result.length == 0 || !(idU == result[0].idUsuario)){
      console.log("No se ha logeado aun");
			res.render("index", {pagina:7,result:result[0]});
		}
		else{
      console.log("Esta logueado");
			res.render("index", {pagina:7,result:result[0]});
		}
	});
});

//Pagina 8 - Politicas de privacidad
router.get("/politicas", function(req, res) {
  res.type("text/html");
  res.render(
    "index",
    {
      pagina: 8
    },
    function(err, html) {
      if (err) throw err;
      res.send(html);
    }
  );
});

//Pagina 9 - Registrarse
router.get('/registrarse', (req,res)=>{
  res.type("text/html");
  res.render(
    "index",
    { pagina: 9},
    function(err, html) {
      if (err) throw err;
      res.send(html);
    }
  );
});


//Pagina 10 - GET para cargar el perfil de un tecnico
router.get('/perfil-tecnico/:id', (req, res)=>{     
  const id_Usuario = req.params.id;
  conexion.query('SELECT servicio_tecnico.idServicoTecnico, servicio_tecnico.imagen, especializacion.nombreEspecializacion, servicio.nombreServicio, servicio.precioServicio, usuario.nombre, usuario.apellido FROM especializacion INNER JOIN servicio ON especializacion.idEspecializacion=servicio.idEspecializacion INNER JOIN servicio_tecnico ON servicio.idServicio=servicio_tecnico.idServicio INNER JOIN tecnico ON servicio_tecnico.idTecnico=tecnico.idTecnico INNER JOIN usuario ON tecnico.idUsuario=usuario.idUsuario WHERE usuario.idUsuario=?', [id_Usuario],(error, results)=>{
    if(error){
        throw error;
    } else {
        conexion.query('SELECT telefono_tecnico.numTelefono, usuario.idUsuario, usuario.nombre, usuario.apellido, tecnico.valoracion, tecnico.foto, especializacion.nombreEspecializacion FROM usuario INNER JOIN tecnico ON usuario.idUsuario = tecnico.idUsuario JOIN tecnico_especializacion ON tecnico.idTecnico = tecnico_especializacion.idTecnico JOIN especializacion ON tecnico_especializacion.idEspecializacion = especializacion.idEspecializacion JOIN telefono_tecnico ON tecnico.idTecnico = telefono_tecnico.idTecnico WHERE usuario.idUsuario=?', [id_Usuario], (error, tecnico)=>{
          if(error){
              throw error;
          } else {                       
              res.render("index", {pagina:10,results:results,tecnico:tecnico[0]});         
          }   
      })              
    }   
})
})

//POST para agregar un servicio al carrito, con sus datos especificos
router.post('/carrito', async (req,res)=>{
   //console.log("BODY ",req.body);
   const fecha = req.body.fecha;
   const corregimiento = req.body.corregimiento;
   const barriada = req.body.barriada;
   const casa = req.body.casa;

  const idServicoTecnico = req.body.idServicioTecnico;
  const nombreServicio = req.body.nombreServicio;
  const precioServicio = req.body.precioServicio;
  const nombre = req.body.nombre;
  const apellido = req.body.apellido;

  const nombreCompleto = nombre + " " + apellido;
  
  if(login){
    conexion.query("INSERT INTO orden SET ?",{idOrden:0,idServicoTecnico:idServicoTecnico,idUsuario:idU,nombreServicio:nombreServicio,precioServicio:precioServicio,nombreTecnico:nombreCompleto,corregimiento:corregimiento,barriada:barriada,casa:casa,fechaAccion:fecha,estadoOrden:"Carrito"}, async(err,result)=>{
      if(err){
        console.log(err);
      }else{
       
        res.redirect("/Servicios");
      }
    });
  }
  else{
    console.log("No se ha inciado sesion...");
    res.redirect("/Servicios");
  }
});


//Pagina 11 - GET para cargar el formulario a llenar para un servicio
router.get('/formularioServicio/:id', (req, res)=>{     
  const id_ServicioTecnico = req.params.id;
  conexion.query('SELECT servicio_tecnico.idServicoTecnico, servicio_tecnico.imagen, especializacion.nombreEspecializacion, servicio.nombreServicio, servicio.precioServicio, usuario.nombre, usuario.apellido FROM especializacion INNER JOIN servicio ON especializacion.idEspecializacion=servicio.idEspecializacion INNER JOIN servicio_tecnico ON servicio.idServicio=servicio_tecnico.idServicio INNER JOIN tecnico ON servicio_tecnico.idTecnico=tecnico.idTecnico INNER JOIN usuario ON tecnico.idUsuario=usuario.idUsuario WHERE servicio_tecnico.idServicoTecnico=?', [id_ServicioTecnico],(error, results)=>{
    if(error){
        throw error;
    } else {
      res.render("index", {pagina:11,results:results[0]});                    
    }   
})
})

//Post para iniciar sesion
router.post('/auth',async(req,res)=>{
  const email=req.body.email;
  const contra=req.body.contra;
  if(email && contra)
  {
    conexion.query('SELECT * FROM usuario WHERE email =?',[email], async(err,result)=>{
      console.log(result[0]);
      //console.log(contra);
      if(result.length == 0 || !(await bcryptjs.compare(contra, result[0].password))){
        console.log("usuario o contra incorrecta");
        res.redirect("/login");
      }else{
        console.log("Incio de sesion exitoso");
        req.session.loggedin=true;
        login = req.session.loggedin;
        req.session.user = result[0].idUsuario;
        idU = req.session.user;
        res.redirect("/");
      }
    })
  }
  else{
    res.send("Porfavor, ingrese un usuario y contraseña;");
  }
})

//Router para cerrar sesion
router.use(function(req, res, next) {
  if (!req.user)
      res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
  next();
});
//Destruye la sesión.
router.get('/logout', function (req, res) {
  login=false;
  idU=0;
	req.session.destroy(() => {
	  res.redirect('/') // siempre se ejecutará después de que se destruya la sesión
	})
});

//Post para guardar un usuario
router.post("/registrarse", async (req,res)=>{
  const nombre=req.body.nombre
  const ape=req.body.apellido;
  const edad=req.body.edad;
  const dire=req.body.direccion;
  const email=req.body.email;
  const rol=req.body.rol;
  const pass=req.body.contra;
  let passhash= await bcryptjs.hash(pass,8);
  conexion.query("INSERT INTO usuario SET ?",{nombre:nombre,apellido:ape,email:email,password:passhash,direccion:dire,edad:edad,idTipoUser:rol}, async(err,result)=>{
    if(err){
      console.log('Parece que ha ocurrido un error...')
      console.log(err);
    }else{
      console.log("Usuario creado exitosamente");
      res.redirect("/");
    }
  });
})


//Pasarela - Crear Orden de Compra (Pagar servicios en carrito)
router.post('/crear-orden/:total', async (req, res) =>{
  try {
    console.log(req.params.total);
    const order = {
      intent: "CAPTURE",
      purchase_units: [ //Aqui va el carrito, hacer un for each para cada servicio
        {
          amount: {
            currency_code: "USD",
            value: req.params.total,
          },
          description: "Servicios Tecnicos SOLUW"
        },
      ],
      application_context: {
        brand_name: "SOLUW",
        landing_page: "LOGIN",
        user_action: "PAY_NOW",
        return_url: `${HOST}/capturar-orden`,
        cancel_url: `${HOST}/cancelar-orden`
      },
    };
  
    const params = new URLSearchParams();
    params.append("grant_type", "client_credentials");
  
    const {data: {access_token}} = await axios.post(`${PAYPAL_API}/v1/oauth2/token`, params, {
      headers: {
        "Content-type": "application/x-www-form-urlencoded",
      },
      auth: {
        username: CLIENT_ID,
        password: SECRET,
      },
    }); 
    //console.log(access_token);
    const response = await axios.post(`${PAYPAL_API}/v2/checkout/orders`, order, {
      headers: {
        Authorization: `Bearer ${access_token}`
      }
    });
    //console.log(response.data);
    res.json(response.data);
  } catch (error) { 
    return res.redirect(`${HOST}/404`);
  }
})

router.get('/capturar-orden', async (req, res) =>{
  try {
    const {token} = req.query
  
    const response = await axios.post(`${PAYPAL_API}/v2/checkout/orders/${token}/capture`, {},
      {
        auth: {
          username: CLIENT_ID,
          password: SECRET,
        },
      });

    // console.log(response.data);
    return res.redirect(`${HOST}/thankyou`)
  } catch (error) {
    return res.send(`${HOST}/404`);
  }
})

router.get('/cancelar-orden', (req, res) =>{
  res.redirect('/');
})

//Pagina 12 - Gracias
router.get('/thankyou', (req,res)=>{
  const actual="Carrito";
  const nuevo="En Proceso";
  conexion.query('UPDATE orden SET ? WHERE estadoOrden = ?',[{estadoOrden:nuevo},actual],(error, results)=>{
    if(error){
        throw error;
    } else {                     
        res.render("index", {pagina:12});         
    } 
  });
});

//Pagina 13 - Historial de Ordenes
router.get('/historial', (req,res)=>{

  conexion.query('SELECT * FROM orden WHERE orden.idUsuario=?',[idU],(error, results)=>{
    if(error){
        throw error;
    } else {                     
        res.render("index", {pagina:13,results:results});         
    } 
  });
});

//Error 404
router.use(function(req, res) {
  res.type("text/html");
  res.status(404);
  res.render(
    "index",
    {
      pagina: 20
    },
    function(err, html) {
      if (err) throw err;
      res.send(html);
    }
  );
});

// Pagina de error 500
router.use(function(err, req, res, next) {
  console.error(err.stack);
  res.type("text/plain");
  res.status(500);
  res.send("500 - Server Error");
});

const operaciones = require('./controles/operacionesDB');
router.post('/crear', operaciones.crear);
module.exports = router;
/*router.post('/update', crud.update);*/


