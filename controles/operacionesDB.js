//Invocamos a la conexion de la DB
const conexion = require('../database/db');
//GUARDAR un REGISTRO
exports.crear = (req, res)=>{
    const idTipoUser = 2; 
    const nombreS = req.body.nombre;
    const apellidoS = req.body.apellido;
    const edadS = req.body.edad;
    const direccionS = req.body.direccion;
    const emailS = req.body.email;
    const passwordS = req.body.contra;

    console.log(idTipoUser);
    console.log(nombreS);
    console.log(apellidoS);
    console.log(edadS);
    console.log(direccionS);
    console.log(emailS);
    console.log(passwordS);

    conexion.query('INSERT INTO usuario VALUES ?',{idUsuario:0, idTipoUser:idTipoUser, nombre:nombreS, apellido:apellidoS, email:emailS, password:passwordS, direccion:direccionS, edad:edadS}, (error, results)=>{
        if(error){
            console.log(error);
        }else{
            console.log(results);   
            res.redirect('/');         
        }
});
};

//ACTUALIZAR un REGISTRO

exports.update = (req, res)=>{
    const id = req.body.id;
    const idTipoUser = req.body.idTipoUser;
    const nombreS = req.body.nombre;
    const apellidoS = req.body.apellido;
    const emailS = req.body.email;
    const cedulaS = req.body.cedula;
    conexion.query('UPDATE usuario SET ? WHERE idUsuario = ?',[{idTipoUser:idTipoUser, nombre:nombreS, apellido:apellidoS, email:emailS, cedula:cedulaS}, id], (error, results)=>{
        if(error){
            console.log(error);
        }else{           
            res.redirect('/');         
        }
});
};