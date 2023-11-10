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
  }
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
