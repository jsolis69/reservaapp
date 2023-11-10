import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/usuario_provider.dart';
import 'package:reservaapp/widgets/boton_personalizado.dart';
import 'package:reservaapp/widgets/botonesNavegacion_widget.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/input_personalizado.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';


class MiPerfilPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    IconData icono = FontAwesomeIcons.user;
    String titulo = 'Mi perfil';
    Color colorPrimario = Color(0xff237229);
    Color colorSecundario = Color(0xff35AD3E);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _formulario(context),
            HeaderWidget(
              icono: icono, 
              titulo: titulo,
              color1: colorPrimario,
              color2: colorSecundario
            ),
            const NotificacionWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BotonesNavegacion(seleccionado: 0),  
    );

    
  }

 Widget _formulario(BuildContext context) {
    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: true);
    //final notificacionModel = Provider.of<NotificacionModel>(context);


  //Cambiar por un futurebuilder

    if(usuarioprovider.idUsuario <= 0)
    {
      usuarioprovider.idUsuario = PreferenciasUsuario.usuarioLogueado;
      usuarioprovider.obtenerUsuario().then((value) {
        usuarioprovider.idUsuario = value.objeto.idUsuario;
        usuarioprovider.nombre = value.objeto.nombre;
        usuarioprovider.contrasenia = value.objeto.contrasenia;
        usuarioprovider.correo = value.objeto.email;
        usuarioprovider.telefono = value.objeto.telefono;
      });
    }
    
    return FutureBuilder(
      future: usuarioprovider.obtenerUsuario(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
        else if (snapshot.hasData)
        { 
           return SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.only(top: 120.0, left: 30.0, right: 30.0),
            child: Column(
                children: [
                  //EtiquetaPersonalizada(descripcion: 'Registro', tamano: 20.0 ),
                  //SizedBox(height: 120.0),
                  InputPersonalizado(valorDefecto:snapshot.data.objeto.nombre, icono: Icons.text_fields, placeholder: 'Nombre', tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.nombre = value  }),
                  InputPersonalizado(valorDefecto: snapshot.data.objeto.codUsuario, estaHabilitado: false, icono: Icons.account_box, placeholder: 'Usuario', onChange: (value) => { usuarioprovider.usuario = value  },),
                  InputPersonalizado(valorDefecto:snapshot.data.objeto.contrasenia,icono: Icons.lock, placeholder: 'Contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.contrasenia = value },),
                  InputPersonalizado(icono: Icons.lock, placeholder: 'Reingresar Contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.validarcontrasenia = value  },),
                  InputPersonalizado(valorDefecto:snapshot.data.objeto.email,icono: Icons.text_fields, placeholder: 'Correo', tipoTeclado: TextInputType.emailAddress, onChange: (value) => { usuarioprovider.correo = value  },),
                  InputPersonalizado(valorDefecto:snapshot.data.objeto.telefono,icono: Icons.text_fields, placeholder: 'Teléfono', tipoTeclado: TextInputType.phone, onChange: (value) => { usuarioprovider.telefono = value  },),
                  _crearBoton(context),
          ]),
        )
      );
      }
      }
          return const Center(child: CircularProgressIndicator());
      }
    );
  }

  Widget _crearBoton(BuildContext context) {
    
    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: true);
    final notificacionModel = Provider.of<NotificacionModel>(context);
    
    return BotonPersonalizado(
      texto: 'Actualizar',
      onPressed: () {
        
        if(usuarioprovider.contrasenia == usuarioprovider.validarcontrasenia)
        {
          usuarioprovider.actualizarUsuario().then((resp)
          { 
            if(resp.codigoRespuesta == 0)
            {
              resp.descripcionRespuesta = "Se actualizó correctamente el usuario";
            }
            //else
            //{
              notificacionModel.mostrarAlerta = true;
              notificacionModel.descripcion = resp.descripcionRespuesta;
              notificacionModel.codigo = resp.codigoRespuesta;
              Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
            //}
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
}
 

