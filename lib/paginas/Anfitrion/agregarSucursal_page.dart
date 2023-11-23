import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/input_personalizado.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart'; 


class AgregarSucursalPage extends StatelessWidget {
  const AgregarSucursalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          _formulario(context),
          HeaderWidget(
            icono: FontAwesomeIcons.building, 
            titulo: 'Agregar Sucursal',
            color1: Colors.green,
            color2: Colors.grey,
            paginaReturn: 'MisSucursales',
          ),
          const NotificacionWidget()
        ]),
      ),
    );
    
  }

  Widget _formulario(BuildContext context){
    final sucursalprovider = Provider.of<SucursalesProvider>(context, listen: false);

    return SingleChildScrollView(child: 
     Padding(
       padding: const EdgeInsets.only(top: 120.0, left: 30.0, right: 30.0),
       child: Column(children: [
        //EtiquetaPersonalizada(descripcion: 'Crear empresa', tamano: 20.0 ),
        //SizedBox(height: 30.0),
        InputPersonalizado(icono: Icons.account_box, placeholder: 'Nombre de sucursal', onChange: (value) => { sucursalprovider.nombre = value  },),
        InputPersonalizado(icono: Icons.text_fields, placeholder: 'Teléfono', tipoTeclado: TextInputType.phone, onChange: (value) => { sucursalprovider.telefono = value  },),
        InputPersonalizado(icono: Icons.text_fields, placeholder: 'Correo', tipoTeclado: TextInputType.emailAddress, onChange: (value) => { sucursalprovider.correo = value  },),
        //InputPersonalizado(icono: Icons.lock, placeholder: 'Dígite su contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.contrasenia = value },),
        //InputPersonalizado(icono: Icons.lock, placeholder: 'Vuelva a digitar la contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.validarcontrasenia = value  },),
        //InputPersonalizado(icono: Icons.text_fields, placeholder: 'Digíte su nombre completo', tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.nombre = value  },),
                
                
        //_crearBoton(context),
         
         ],
        ),
     )
    );

  }
}