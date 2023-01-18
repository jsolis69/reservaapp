import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BotonesNavegacion extends StatefulWidget {

  final int seleccionado;

  const BotonesNavegacion({
    required this.seleccionado
  });

  @override
  _BotonesNavegacionState createState() => _BotonesNavegacionState();
}

class _BotonesNavegacionState extends State<BotonesNavegacion> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
       items: <BottomNavigationBarItem>[
         
         BottomNavigationBarItem(
           icon: FaIcon(FontAwesomeIcons.user),
           label: 'Mi perfil',
         ),
         BottomNavigationBarItem(
           icon: FaIcon(FontAwesomeIcons.calendarDay),
           label: 'Reservar',
         ),
         BottomNavigationBarItem(
           icon: FaIcon(FontAwesomeIcons.spinner),
           label: 'Menú',
         ),
         //BottomNavigationBarItem(
         //  icon: FaIcon(FontAwesomeIcons.google),
         //  label: 'Google',
         //),
       
       ],
       currentIndex: widget.seleccionado,
       //selectedItemColor: Colors.amber[800],
       onTap: _onItemTapped,
     );
  }

    void _onItemTapped(int index) {
      if(index == 0)
    Navigator.pushReplacementNamed(context, 'MiPerfil');
    if (index == 1)
    Navigator.pushReplacementNamed(context, 'Sucursales');
    if (index == 2)
    Navigator.pushReplacementNamed(context, 'Menu');
  }
}

