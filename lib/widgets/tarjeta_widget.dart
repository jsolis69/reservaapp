import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TarjetaWidget extends StatelessWidget {
    final double ancho;
  final double alto;
  final Color color1;
  final Color color2;
  final Image imagen;
  final String titulo;

  const TarjetaWidget({
      this.ancho = 150.0, 
      this.alto = 150.0, 
      this.color1 = Colors.greenAccent, 
      this.color2 = Colors.green, 
      this.imagen = const Image(image: AssetImage('assets/img/canchafutbol.jpg')), 
      required this.titulo
    });
  //const TarjetaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          _TarjetaFondo(
            ancho: this.ancho, 
            alto: this.alto, 
            color1: this.color1, 
            color2: this.color2),
           Row(
               children: [
                Container(
               margin: EdgeInsets.all(20.0),
               width: 80.0,
               height: 80.0,
               child: imagen),
               //Image(
               //  image: AssetImage('assets/img/canchafutbol.jpg') ),
             //),
             Expanded(child: Text(this.titulo)),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: FaIcon(FontAwesomeIcons.arrowCircleRight, color: Colors.white,),
             )
               ],
             )
        ],
      ),
    );
  }
}



class _TarjetaFondo extends StatelessWidget {

  final double ancho;
  final double alto;
  final Color color1;
  final Color color2;

  const _TarjetaFondo({
    required this.ancho,
    required this.alto,
    required this.color1,
    required this.color2
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho,
      height: alto,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,//AlignmentGeometry.lerp(1, b, t),
          colors: <Color>[
            this.color1,
            this.color2
          ])

      ),
    );
  }

}
