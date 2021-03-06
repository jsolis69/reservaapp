import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderWidget extends StatelessWidget {

  final IconData icono;
  final String titulo;
  final String subTitulo;
  final Color color1;
  final Color color2;

  const HeaderWidget({Key key, 
  @required this.icono, 
  @required this.titulo, 
  this.subTitulo = '',
  this.color1 = Colors.greenAccent,
  this.color2 = Colors.green
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final _color = Colors.white.withOpacity(0.9);

    return Stack(
      children: [
        _FondoHeader(color1: this.color1, color2: this.color2),

        Positioned(
          top: -5,
          right: -20,
          child: FaIcon(this.icono, size: 120, color: Colors.white.withOpacity(0.2),)),

        Column(
          children: [
            SizedBox(height: 80, width: double.infinity,),
            Text(titulo, style: TextStyle(fontSize: 20, color: _color)),
            SizedBox(height: 20),
            //Text(texto, style: TextStyle(fontSize: 20, color: _color),)
          ],
        )
      ],
    );
  }
}

class _FondoHeader extends StatelessWidget {

  final Color color1;
  final Color color2;

  const _FondoHeader({
    Key key, this.color1, this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            this.color1
            ,this.color2
          ]
        )
      ),

    );
  }
}