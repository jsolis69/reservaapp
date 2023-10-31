import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';
import 'package:reservaapp/widgets/input_personalizado.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart'; 


class AgregarSucursalPage extends StatelessWidget {
  const AgregarSucursalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _formulario(context),
        const NotificacionWidget()
      ]),
    );
    
  }

  Widget _formulario(BuildContext context){
    final sucursalprovider = Provider.of<SucursalesProvider>(context, listen: false);

    return SingleChildScrollView(child: 
      Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 10.0,
            ),
          ),
    Column(children: [
      EtiquetaPersonalizada(descripcion: 'Crear empresa', tamano: 20.0 ),
      SizedBox(height: 30.0),
      InputPersonalizado(icono: Icons.account_box, placeholder: 'Nombre de sucursal', onChange: (value) => { sucursalprovider.nombre = value  },),
      InputPersonalizado(icono: Icons.text_fields, placeholder: 'Teléfono', tipoTeclado: TextInputType.phone, onChange: (value) => { sucursalprovider.telefono = value  },),
      InputPersonalizado(icono: Icons.text_fields, placeholder: 'Correo', tipoTeclado: TextInputType.emailAddress, onChange: (value) => { sucursalprovider.correo = value  },),
      //InputPersonalizado(icono: Icons.lock, placeholder: 'Dígite su contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.contrasenia = value },),
      //InputPersonalizado(icono: Icons.lock, placeholder: 'Vuelva a digitar la contraseña', tipoPassword: '◍', esPassword: true, tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.validarcontrasenia = value  },),
      //InputPersonalizado(icono: Icons.text_fields, placeholder: 'Digíte su nombre completo', tipoTeclado: TextInputType.visiblePassword, onChange: (value) => { usuarioprovider.nombre = value  },),
              
              
      //_crearBoton(context),
    ], )
       ],
      )
    );

  }
}