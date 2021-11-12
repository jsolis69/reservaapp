
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservaapp/widgets/botonesNavegacion_widget.dart';
import 'package:reservaapp/widgets/header.dart';
class MiPerfilPage extends StatefulWidget {

  @override
  _MiPerfilPageState createState() => _MiPerfilPageState();
}

class _MiPerfilPageState extends State<MiPerfilPage> {


  @override
  Widget build(BuildContext context) {


    IconData icono = FontAwesomeIcons.user;
    String titulo = 'Mi perfil';
    Color colorPrimario = Color(0xff237229);
    Color colorSecundario = Color(0xff35AD3E);

    return Scaffold(
      body: Stack(
        children: [
          Container(),
          HeaderWidget(
            icono: icono, 
            titulo: titulo,
            color1: colorPrimario,
            color2: colorSecundario
          )
        ],
      ),
      bottomNavigationBar: BotonesNavegacion(seleccionado: 0),  
    );

    
  }
}