import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/providers/tema_provider.dart';
import 'package:reservaapp/widgets/botonesNavegacionAnfitrion.dart';
import 'package:reservaapp/widgets/header.dart';

class MenuAnfitrionPage extends StatefulWidget {
  @override
  State<MenuAnfitrionPage> createState() => _MenuAnfitrionPageState();
}

class _MenuAnfitrionPageState extends State<MenuAnfitrionPage> {
  //const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    IconData icono = FontAwesomeIcons.user;
    String titulo = 'Menú';
    Color colorPrimario = Color(0xffFA5858);
    Color colorSecundario = Color(0xffDF0101);

     //final temaAplicacion = Provider.of<TemaServicio>(context);
    return Scaffold(

 

      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 200),
              child: ListView(
              children: [
                Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Cambiar a modo mejenguero'),
                  trailing: FaIcon(FontAwesomeIcons.exchangeAlt),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, 'Sucursales');
                  },
                ),
                Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Ayuda'),
                  trailing: FaIcon(FontAwesomeIcons.question),
                  onTap: (){
                    Navigator.pushNamed(context, 'Ayuda', arguments: 'Anfitrion');
                  },
                ),
                Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Envíanos tus comentarios'),
                  trailing: FaIcon(FontAwesomeIcons.comment),
                  onTap: (){
                    Navigator.pushNamed(context, 'Comentarios', arguments: 'Anfitrion');
                  },
                  ),
      
                  Divider(height: 20, color: Colors.red, thickness: 1,),
                ListTile(
                  title: Text('Modo oscuro'),
                  trailing: Switch.adaptive(
                    //activeColor: temaAplicacion.temaActual.accentColor,
                    value: PreferenciasUsuario.esModoOscuro, 
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
      bottomNavigationBar: BotonesNavegacionAnfitron(seleccionado: 1),  
    );

  }
}