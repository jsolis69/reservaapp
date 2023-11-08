
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/usuario_provider.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:reservaapp/widgets/boton_personalizado.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';
import 'package:reservaapp/widgets/input_personalizado.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';


class LoginPage extends StatelessWidget {

   

  @override
  Widget build(BuildContext context) {
    
    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: true);
    final notificacionModel = Provider.of<NotificacionModel>(context);

    return Scaffold(
      //appBar: AppBar(
      //  title: Text('hola'),
      //),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
            child: Column(
              children: [
                _logo(),
                const EtiquetaPersonalizada(descripcion: 'Ingresar a tu cuenta', tamano: 25),
                SizedBox(height: 30.0),
                InputPersonalizado(icono: Icons.person, placeholder: 'Usuario', onChange: (value){
                  usuarioprovider.usuario = value;
                }),
                //_crearUsuario(context),
                SizedBox(height: 20.0),
                InputPersonalizado(icono: Icons.lock, esPassword: true, tipoPassword: '◍', placeholder: 'Contraseña', onChange: (value){
                  usuarioprovider.contrasenia = value;
                }),
                //_crearContrasenia(context),
                SizedBox(height: 20.0),
                BotonPersonalizado(texto: 'Ingresar', validador: (usuarioprovider.usuario.isNotEmpty && usuarioprovider.contrasenia.isNotEmpty),
                onPressed: (){
          
                  if(usuarioprovider.usuario.isNotEmpty || usuarioprovider.contrasenia.isNotEmpty)
                  {
                    usuarioprovider.login().then((resp){ 
                  if(resp.codigoRespuesta == 0){
                    Navigator.pushReplacementNamed(context, 'Sucursales');
                  }
                  else{
                      notificacionModel.mostrarAlerta = true;
                      notificacionModel.descripcion = resp.descripcionRespuesta;
                      notificacionModel.codigo = resp.codigoRespuesta;
                      Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
                    //mostrarAlerta(context, resp.descripcionRespuesta);
                  }
                  }
                  );
              
                  }
                }),
                
                //if(usuarioprovider.usuario.isEmpty && usuarioprovider.contrasenia.isEmpty)
                //BotonPersonalizado(texto: 'Ingresar', validador: false, onPressed: (){}),
                //_crearBoton(context),
                SizedBox(height: 20.0),
                //_crearBotonesLogin(),
                //SizedBox(height: 20.0),
                  TextButton(
                  onPressed: ()=> Navigator.pushReplacementNamed(context, 'Registro'), 
                  
                  child: crearTitulo('Registrarse', 20.0)
                            ),
                            
                   const NotificacionWidget(),
                //),
              ],
            ),
          ),

      )
    );
  }


  Widget _logo() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
    child: Container(
      width: double.infinity,
      height: 80,
      //color: Colors.red,
      child: Image(
        image: AssetImage('assets/img/Logo.jpg')),
      ),
  );
  }


    Widget _crearBotonesLogin( ) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: FaIcon(FontAwesomeIcons.facebook), onPressed: (){}),
          IconButton(icon: FaIcon(FontAwesomeIcons.instagram), onPressed: (){})
          //IconButton(icon: FaIcon(FontAwesomeIcons.facebook), onPressed: (){})
        ],
      );
  }
  _login(BuildContext context) {

    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: false);

    var prueba = usuarioprovider.login;

    var a = '';
    //if(respuesta['ok']){
    //  Navigator.pushReplacementNamed(context, 'Inicio');
    //}
    //else{
    //  mostrarAlerta(context, respuesta['mensaje']);
    //}
  }
}