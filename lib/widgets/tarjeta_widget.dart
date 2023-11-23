import 'package:flutter/material.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TarjetaWidget extends StatelessWidget {
  final double ancho;
  final double alto;
  final Color color1;
  final Color color2;
  final AssetImage imagen;
  final String titulo;
  final VoidCallback ontap;
  final IconData icono;

  const TarjetaWidget({
      this.ancho = 150.0, 
      this.alto = 150.0, 
      this.color1 = Colors.greenAccent, 
      this.color2 = Colors.green, 
      this.imagen = const AssetImage('assets/img/cancha.jpg'),
      this.icono = FontAwesomeIcons.calendarDay,
      required this.titulo, 
      required this.ontap
    });
  //const TarjetaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
            width: this.ancho,
            height: this.alto,
            child: GestureDetector(
              onTap: this.ontap,
              child: Stack(
                children: [
                  Container(
                    width: this.ancho,
                    height: this.alto,
                    decoration: BoxDecoration(
                      //image: DecorationImage(fit: BoxFit.cover, image: this.imagen),
                      color: color1,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: color2.withOpacity(0.5),
                          offset: Offset(5, 5),
                          blurRadius: 10.0
                        ),
                      ],
                      //gradient: LinearGradient(colors: [
                      //  this.color1,
                      //  this.color2
                      //])
                    ),
                    //child: GestureDetector(onTap: this.ontap),
                  ),
                  Center(child: EtiquetaPersonalizada(descripcion: this.titulo, tamano: 20, color: color2,)),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: FaIcon(icono, size: 70, color: color2.withOpacity(0.2))),
                ],
              ),
            ),
          )
    );
  }
}
