import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonesGrantes extends StatelessWidget {

  final String titulo;
  final String subtitulo;
  final Color color1;
  final Color color2;
  final IconData icono;

  const BotonesGrantes({
    Key key, 
    @required this.titulo, 
    this.subtitulo = '', 
    this.color1 = Colors.greenAccent, 
    this.color2 = Colors.green, 
    @required this.icono
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _BotonesGrandesFondo(color1: this.color1, color2: this.color2, icono: this.icono),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150),
            Expanded(
              child: Column(children: [
                Text(this.titulo, style: TextStyle(color: Colors.white, fontSize: 20),),
                Text(this.subtitulo, style: TextStyle(color: Colors.white, fontSize: 10),),
                ]
              ),
            ),
            SizedBox(width: 140,),
            FaIcon( this.icono, color: Colors.white, size: 30, semanticLabel: 'dsadsa',),
          //FaIcon( this.icono, color: Colors.white, size: 30,),
          SizedBox(width: 40,),
        ],)
      ] 
      );
  }
}

class _BotonesGrandesFondo extends StatelessWidget {

  final Color color1;
  final Color color2;
  final IconData icono;

  const _BotonesGrandesFondo({Key key, this.color1, this.color2, this.icono}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -10,
              child: FaIcon( this.icono, size: 180, color: Colors.white.withOpacity(0.2), ))
          ],
        ),
      ),
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: <Color>[
            this.color1,
            this.color2
        ]),

        boxShadow: <BoxShadow>[
          BoxShadow( 
            color: Colors.black.withOpacity(0.3),
            offset: Offset(4,6),
            blurRadius: 10 
            )
        ], 
      ),
    );
  }
}