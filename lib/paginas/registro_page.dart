import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/usuario_provider.dart';
import 'package:reservaapp/widgets/boton_personalizado.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/input_personalizado.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';

class RegistroPage extends StatefulWidget {

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
   //int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            HeaderWidget(
            icono: FontAwesomeIcons.registered, 
            titulo: 'Registro',
            color1: Colors.green,
            color2: Colors.grey
          ),
            _formulario(context),
            //_widgetOptions.elementAt(_selectedIndex),
            //_formulario(context)
            const NotificacionWidget(),
          ],
        ),
      ),
      //bottomNavigationBar: BottomNavigationBar(
      //  items: const <BottomNavigationBarItem>[
      //    BottomNavigationBarItem(
      //      icon: FaIcon(FontAwesomeIcons.personBooth),
      //      label: 'Registro',
      //    ),
      //    BottomNavigationBarItem(
      //      icon: FaIcon(FontAwesomeIcons.facebook),
      //      label: 'Facebook',
      //    ),
      //    BottomNavigationBarItem(
      //      icon: FaIcon(FontAwesomeIcons.instagram),
      //      label: 'Instagram',
      //    ),
      //    //BottomNavigationBarItem(
      //    //  icon: FaIcon(FontAwesomeIcons.google),
      //    //  label: 'Google',
      //    //),
      //  ],
      //  currentIndex: _selectedIndex,
      //  //selectedItemColor: Colors.amber[800],
      //  onTap: _onItemTapped,
      //),
    );
  }

  //Widget obtenerPantalla(BuildContext context, int index){
  //  if(index == 0)
  //  {
  //   return  _formulario(context);
  //  }
  //  else if(index == 1){
  //    return Text(
  //    'Login Google',
  //  );
  //  }
  //  else{
  //    return Text(
  //    'Login facebook',
  //  );
  //  }
//
  //}
  //void _onItemTapped(int index) {
  //  setState(() {
  //    _selectedIndex = index;
  //  });
  //}



  Widget _formulario(BuildContext context) {
    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: true);
    //final notificacionModel = Provider.of<NotificacionModel>(context);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 120.0, left: 30.0, right: 30.0),
        child: Column(
              children: [
                //EtiquetaPersonalizada(descripcion: 'Registro', tamano: 20.0 ),
                //SizedBox(height: 120.0),
                InputPersonalizado(icono: Icons.text_fields, placeholder: 'Nombre', tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.nombre = value  },),
                InputPersonalizado(icono: Icons.account_box, placeholder: 'Usuario', onChange: (value) => { usuarioprovider.usuario = value  },),
                InputPersonalizado(icono: Icons.lock, placeholder: 'Contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.contrasenia = value },),
                InputPersonalizado(icono: Icons.lock, placeholder: 'Reingresar Contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.validarcontrasenia = value  },),
                InputPersonalizado(icono: Icons.text_fields, placeholder: 'Correo', tipoTeclado: TextInputType.emailAddress, onChange: (value) => { usuarioprovider.correo = value  },),
                InputPersonalizado(icono: Icons.text_fields, placeholder: 'Teléfono', tipoTeclado: TextInputType.phone, onChange: (value) => { usuarioprovider.telefono = value  },),
                _crearBoton(),
              
            
            TextButton(
              onPressed: ()=> Navigator.pushReplacementNamed(context, 'Login'), 
              child: Text('Ya tienes cuenta? Login')//, style: estiloTextos)
            ),
        ]),
      )
    );
  }
  
  Widget _crearBoton() {
    
    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: true);
    final notificacionModel = Provider.of<NotificacionModel>(context);
    
    return BotonPersonalizado(
      texto: 'Guardar',
      onPressed: () {
        
        if(usuarioprovider.contrasenia == usuarioprovider.validarcontrasenia)
        {
          usuarioprovider.registrarUsuario().then((resp)
          { 
            if(resp.codigoRespuesta == 0)
            {
              Navigator.pushReplacementNamed(context, 'Login');
            }
            else
            {
              notificacionModel.mostrarAlerta = true;
              notificacionModel.descripcion = resp.descripcionRespuesta;
              notificacionModel.codigo = resp.codigoRespuesta;
              Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
            }
          });
        }
        else
        {
          notificacionModel.mostrarAlerta = true;
          notificacionModel.descripcion = 'Las contraseñas no coinciden, favor validar';
          notificacionModel.codigo = 3;
          Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
        }

      },
      validador: _validarRegistro(context),
    );
      //texto: 'Ingresar', validador: (usuarioprovider.usuario.isNotEmpty && usuarioprovider.contrasenia.isNotEmpty),
      //onPressed: 
      //  if(usuarioprovider.usuario.isNotEmpty || usuarioprovider.contrasenia.isNotEmpty)
      //  {
      //    usuarioprovider.login().then((resp){ 
      //  if(resp.codigoRespuesta == 0){
      //    Navigator.pushReplacementNamed(context, 'Sucursales');
      //  }
      //  else{
      //      notificacionModel.mostrarAlerta = true;
      //      notificacionModel.descripcion = resp.descripcionRespuesta;
      //      notificacionModel.codigo = resp.codigoRespuesta;
      //      Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
      //    //mostrarAlerta(context, resp.descripcionRespuesta);
      //  }
      //  }
      //  );
    //
      //  }
      //}),
  }

//  Widget _crearContrasenia(String label, String textoAyuda, IconData icono, bool esContrasena) {
//      final usuarioprovider = Provider.of<UsuarioProvider>(context);
//    return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//        obscureText: true,
//        keyboardType: TextInputType.emailAddress,
//        decoration: InputDecoration(
//         hintText: textoAyuda,
//         labelText: label,
//          //suffixIcon: Validadores().asignarIcono(snapshot.error),
//          errorText: usuarioprovider.contrasenia.error,
//        ),
//        onChanged: (value){
//        usuarioprovider.cambiarContrasenia(value);
//      }//bloc.cambiarUsuario,
//      )
//    );  
//  }
//
//  Widget _crearConfirmarContrasenia(String label, String textoAyuda) {
//     
//     final usuarioprovider = Provider.of<UsuarioProvider>(context);
//    return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//        obscureText: true,
//        keyboardType: TextInputType.emailAddress,
//        decoration: InputDecoration(
//         hintText: textoAyuda,
//         labelText: label,
//          //suffixIcon: Validadores().asignarIcono(snapshot.error),
//         errorText: usuarioprovider.validarcontrasenia.error,
//        ),
//        onChanged: (value){
//        usuarioprovider.cambiarConfirmarcontrasenia(value);
//      }//bloc.cambiarUsuario,
//      )
//    ); 
//  }
//
//  Widget _crearUsuario(String label, String textoAyuda, IconData icono, bool esContrasena) {
// 
//    final usuarioprovider = Provider.of<UsuarioProvider>(context);
//
//     return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//          textCapitalization: TextCapitalization.sentences,
//          decoration: InputDecoration(
//            hintText: textoAyuda,
//            labelText: label,
//            //helperText: 'Sólo es el nombre',
//            //suffixIcon: Validadores().asignarIcono(snapshot.error),
//            errorText: usuarioprovider.usuario.error
//          ),
//         onChanged: (value){
//        usuarioprovider.cambiarUsuario(value);
//      }//bloc.cambiarUsuario,
//    )
//    );
//  }
//
//  Widget _crearNombre(String label, String textoAyuda, IconData icono, bool esContrasena) {
// 
//  final usuarioprovider = Provider.of<UsuarioProvider>(context);
//
//     return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//          textCapitalization: TextCapitalization.sentences,
//          decoration: InputDecoration(
//            hintText: textoAyuda,
//            labelText: label,
//            //helperText: 'Sólo es el nombre',
//            //suffixIcon: Validadores().asignarIcono(snapshot.error),
//            errorText: usuarioprovider.nombre.error,
//          ),
//      onChanged: (value){
//        usuarioprovider.cambiarNombre(value);
//      }
//    )
//    );
//  }
//
//  Widget _crearPrimerApellido(String label, String textoAyuda, IconData icono, bool esContrasena) {
// 
//
//    final usuarioprovider = Provider.of<UsuarioProvider>(context);
//     return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//          textCapitalization: TextCapitalization.sentences,
//          decoration: InputDecoration(
//            hintText: textoAyuda,
//            labelText: label,
//            //helperText: 'Sólo es el nombre',
//           // suffixIcon: Validadores().asignarIcono(snapshot.error),
//           errorText: usuarioprovider.primerApellido.error,
//          ),
//      onChanged: (value){
//        usuarioprovider.cambiarPrimerApellido(value);
//      }
//    )
//    );
//  }
//
//  Widget _crearSegundoApellido(String label, String textoAyuda, IconData icono, bool esContrasena) {
// 
//     final usuarioprovider = Provider.of<UsuarioProvider>(context);
//     return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//          textCapitalization: TextCapitalization.sentences,
//          decoration: InputDecoration(
//            hintText: textoAyuda,
//            labelText: label,
//            //helperText: 'Sólo es el nombre',
//            //suffixIcon: Validadores().asignarIcono(snapshot.error),
//            errorText: usuarioprovider.segundoApellido.error,
//          ),
//      onChanged: (value){
//        usuarioprovider.cambiarSegundoApellido(value);
//      }
//    )
//    );
//  }
//
//  Widget _crearTelefono(String label, String textoAyuda, IconData icono, bool esContrasena) {
// 
//     final usuarioprovider = Provider.of<UsuarioProvider>(context);
//     return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//          textCapitalization: TextCapitalization.sentences,
//          keyboardType: TextInputType.number,
//          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//          decoration: InputDecoration(
//            hintText: textoAyuda,
//            labelText: label,
//            //helperText: 'Sólo es el nombre',
//            //suffixIcon: Validadores().asignarIcono(snapshot.error),
//            errorText: usuarioprovider.telefono.error,
//          ),
//      onChanged: (value){
//        usuarioprovider.cambiarTelefono(value);
//      }
//    )
//    );
//  }
//
//  Widget _crearCorreo(String label, String textoAyuda, IconData icono, bool esContrasena) {
// 
//     final usuarioprovider = Provider.of<UsuarioProvider>(context);
//     return Container(
//        padding: EdgeInsets.symmetric( horizontal: 20.0),
//        child: TextField(
//          textCapitalization: TextCapitalization.sentences,
//          decoration: InputDecoration(
//            hintText: textoAyuda,
//            labelText: label,
//            //helperText: 'Sólo es el nombre',
//            //suffixIcon: Validadores().asignarIcono(snapshot.error),
//            errorText: usuarioprovider.correo.error,
//          ),
//      onChanged: (value){
//        usuarioprovider.cambiarCorreo(value);
//      }
//    )
//    );
//  }
//
//  Widget _crearDireccion(String label, String textoAyuda, IconData icono) {
//    
//    final usuarioprovider = Provider.of<UsuarioProvider>(context);
//     return Container(
//      padding: EdgeInsets.symmetric( horizontal: 20.0),
//      child: TextField(
//        maxLines: 3,
//      textCapitalization: TextCapitalization.sentences,
//      decoration: InputDecoration(
//        hintText: textoAyuda,
//        labelText: label,
//        //helperText: 'Sólo es el nombre',
//        //suffixIcon: Validadores().asignarIcono(snapshot.error),
//        errorText: usuarioprovider.direccion.error,
//        //icon: Icon( Icons.account_box )
//      ),
//      onChanged: (value){
//        usuarioprovider.cambiarDireccion(value);
//      }
//    )
//    );
//  }
//
//  Widget _crearBoton( ) {
//    
//    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: false);
//    return ElevatedButton(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
//         child: crearTitulo('Ingresar', 15.0),
//         
//      ),
//      //shape: RoundedRectangleBorder(
//      //  borderRadius: BorderRadius.circular(5.0)
//      //),
//      //elevation: 0.0,
//      //color: Color.fromRGBO(234, 101, 57, 1.0),
//      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(234, 101, 57, 1.0))),
//      onPressed: (!usuarioprovider.registroValido ? null : usuarioprovider.registrarUsuario),
//    );
//     
//  }

   //_registro(RegistroBloc bloc, BuildContext context) async {
//
   // final respuesta = await usuarioprovider.registrarUsuario(bloc);
   // if(respuesta['ok']){
   //  Navigator.pushReplacementNamed(context, 'Inicio');
   // }
   // else{
   //  mostrarAlerta(context, respuesta['mensaje']);
   // }
//
   // }
}

bool _validarRegistro(BuildContext context) { 
  final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: true);

  if(usuarioprovider.usuario.isEmpty)
    return false;
    if(usuarioprovider.contrasenia.isEmpty)
  return false;
    if(usuarioprovider.validarcontrasenia.isEmpty)
  return false;
    if(usuarioprovider.nombre.isEmpty)
  return false;
    if(usuarioprovider.correo.isEmpty)
  return false;
    if(usuarioprovider.telefono.isEmpty)
  return false;

  return true;
}
