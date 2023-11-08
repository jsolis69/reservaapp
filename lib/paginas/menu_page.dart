import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/providers/tema_provider.dart';
import 'package:reservaapp/widgets/botonesNavegacion_widget.dart';
import 'package:reservaapp/widgets/header.dart';


import 'package:reservaapp/providers/usuario_provider.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  //const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    IconData icono = FontAwesomeIcons.user;
    String titulo = 'Menú';
    Color colorPrimario = Color(0xffFA5858);
    Color colorSecundario = Color(0xffDF0101);

  
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: ListView(
              children: [
                  
                if(PreferenciasUsuario.esPropietario)...[
                //Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Cambiar a modo anfitrión'),
                  trailing: FaIcon(FontAwesomeIcons.exchangeAlt),
                  onTap: (){
                    Navigator.pushNamed(context, 'MisSucursales');
                  },
                ),
                ]
                else...[
                //Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('¿Quieres ser anfitrión?'),
                  trailing: FaIcon(FontAwesomeIcons.school),
                  onTap: (){
                    Navigator.pushNamed(context, 'RegistrarEmpresa');
                  },
                ),
                ],
                
                     
                Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Ayuda'),
                  trailing: FaIcon(FontAwesomeIcons.question),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, 'Ayuda', arguments: 'Menu');
                  },
                ),
                Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Envíanos tus comentarios'),
                  trailing: FaIcon(FontAwesomeIcons.comment),
                  onTap: (){
                    Navigator.pushNamed(context, 'Comentarios', arguments: 'Menu');
                  },
                  ),
                  
                  Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Modo oscuro'),
                  trailing: Switch.adaptive(
                    value: PreferenciasUsuario.esModoOscuro, 
                    //activeColor: PreferenciasUsuario.temaActual.accentColor,
                    onChanged: (value){
                      PreferenciasUsuario.esModoOscuro = value;
                      final temaServicio = Provider.of<TemaServicio>(context, listen: false);
                      value ? temaServicio.setModoOscuro() : temaServicio.setModoClaro();
                      setState(() {
                      });
                    }
                    )
                  ),
                  
                Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Cerrar sesión'),
                  trailing: FaIcon(FontAwesomeIcons.signOutAlt),
                  onTap: (){
                  
                    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: false);
                    usuarioprovider.usuario = '';
                    usuarioprovider.contrasenia = '';
                  
                  
                    Navigator.pushReplacementNamed(context, 'Login');
                  },
                  )
              ],
              ),
            ),
            
            HeaderWidget(
              icono: icono, 
              titulo: titulo,
              color1: colorPrimario,
              color2: colorSecundario
            )
          ],
        ),
      ),
      bottomNavigationBar: BotonesNavegacion(seleccionado: 2),  
    );

  }
}