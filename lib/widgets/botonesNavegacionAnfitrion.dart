import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonesNavegacionAnfitron extends StatefulWidget {
  //const BotonesNavegacionAnfitron({Key? key}) : super(key: key);

    final int seleccionado;

  const BotonesNavegacionAnfitron({
    Key key, 
    this.seleccionado
  }) : super(key: key);


  @override
  _BotonesNavegacionAnfitronState createState() => _BotonesNavegacionAnfitronState();
}

class _BotonesNavegacionAnfitronState extends State<BotonesNavegacionAnfitron> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(
           icon: FaIcon(FontAwesomeIcons.building),
           label: 'Sucursales',
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
    Navigator.pushReplacementNamed(context, 'MisSucursales');
    if (index == 1)
    Navigator.pushReplacementNamed(context, 'MenuAnfitrion');
  }
}