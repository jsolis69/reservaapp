import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/empresa_provider.dart';
import 'package:reservaapp/widgets/boton_personalizado.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';
import 'package:reservaapp/widgets/input_personalizado.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';

class RegistrarEmpresaPage extends StatelessWidget {
  const RegistrarEmpresaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          _formulario(context),
          const NotificacionWidget()
        ],
      ),
    );
  }

Widget _formulario(BuildContext context) {
    final empresaprovider = Provider.of<EmpresaProvider>(context, listen: false);
    //final notificacionModel = Provider.of<NotificacionModel>(context);
    
    return SingleChildScrollView(
      child: 
      //Column(
        //children: <Widget>[
        //  SafeArea(
        //    child: Container(
        //      height: 10.0,
        //    ),
        //  ),
          Column(
            children: [
              EtiquetaPersonalizada(descripcion: 'Crear empresa', tamano: 20.0 ),
              SizedBox(height: 30.0),
              InputPersonalizado(icono: Icons.account_box, placeholder: 'Digíte el nombre de su empresa', onChange: (value) => { empresaprovider.nombre = value  },),
              InputPersonalizado(icono: Icons.text_fields, placeholder: 'Digíte su teléfono', tipoTeclado: TextInputType.phone, onChange: (value) => { empresaprovider.telefono = value  },),
              InputPersonalizado(icono: Icons.text_fields, placeholder: 'Digíte su correo', tipoTeclado: TextInputType.emailAddress, onChange: (value) => { empresaprovider.correo = value  },),
              //InputPersonalizado(icono: Icons.lock, placeholder: 'Dígite su contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.contrasenia = value },),
              //InputPersonalizado(icono: Icons.lock, placeholder: 'Vuelva a digitar la contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.validarcontrasenia = value  },),
              //InputPersonalizado(icono: Icons.text_fields, placeholder: 'Digíte su nombre completo', tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.nombre = value  },),
              
              
             _crearBoton(context),
            ],
          ),
       // ],
      //)
    );

    
  }

  Widget _crearBoton(BuildContext context) {
    
    //final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: false);
    final empresaprovider = Provider.of<EmpresaProvider>(context, listen: false);
    final notificacionModel = Provider.of<NotificacionModel>(context);
    
    return BotonPersonalizado(
      texto: 'Guardar',
      onPressed: () {
        empresaprovider.idUsuario = PreferenciasUsuario.usuarioLogueado;
          empresaprovider.InsertarEmpresa().then((resp)
          { 
            if(resp.codigoRespuesta == 0)
            {
              PreferenciasUsuario.esPropietario = true;
              Navigator.pushReplacementNamed(context, 'MisSucursales');
            }
            else
            {
              notificacionModel.mostrarAlerta = true;
              notificacionModel.descripcion = resp.descripcionRespuesta;
              notificacionModel.codigo = resp.codigoRespuesta;
              Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
            }
          });
      },
      validador: _validarRegistro(context),
    );
  }
}

bool _validarRegistro(BuildContext context) { 
  //final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: false);
  final empresaprovider = Provider.of<EmpresaProvider>(context, listen: true);
  //if(empresaprovider.idUsuario.isEmpty)
   // return false;
  if(empresaprovider.nombre.isEmpty)
    return false;
  if(empresaprovider.telefono.isEmpty)
    return false;
  if(empresaprovider.correo.isEmpty)
    return false;

  return true;
}