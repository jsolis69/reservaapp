import 'package:flutter/material.dart';
import 'package:reservaapp/utils/utils.dart';

class MenuWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
            decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: crearTitulo('Menú', 24)
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: crearTitulo('Inicio', 20),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'Principal');
          }
        ),
        //ListTile(
        //  leading: Icon(Icons.account_circle),
        //  title: Text('Profile'),
        //),
        ListTile(
          leading: Icon(Icons.settings),
          title: crearTitulo('Configuración', 20),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'Configuracion');
          }
        ),
      ],
    ),
      );
  }
}