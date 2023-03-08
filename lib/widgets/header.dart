import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderWidget extends StatelessWidget {

  final IconData icono;
  final String titulo;
  final String subTitulo;
  final Color color1;
  final Color color2;

  const HeaderWidget({ 
  required this.icono, 
  required this.titulo, 
  this.subTitulo = '',
  this.color1 = Colors.greenAccent,
  this.color2 = Colors.green
  });

  @override
  Widget build(BuildContext context) {
    
    final _color = Colors.white.withOpacity(0.9);

    return Stack(
      children: [
        _FondoHeader(color1: this.color1, color2: this.color2),

        Positioned(
          top: -5,
          right: -20,
          child: FaIcon(this.icono, size: 90, color: Colors.white.withOpacity(0.2),)),

        Column(
          children: [
            SizedBox(height: 40, width: double.infinity,),
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
    required this.color1, 
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: <Color>[
            this.color1
            ,this.color2
          ]
        )
      ),

    );
  }
}