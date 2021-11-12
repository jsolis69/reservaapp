

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void mostrarAlerta(BuildContext context, String mensaje){

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Ok'))
        ],
      );
    }
  );

}

bool tokenActivo(String fechaExpira){
bool bandera = true;

  if(fechaExpira == "")
    bandera = false;


if(bandera)
{

final fecha = DateTime.parse(fechaExpira);
if(fecha.difference(DateTime.now()).isNegative)
  bandera = false;
else
  bandera= true;
}

return bandera;

}


  Widget crearTitulo(String texto, double fontsize) {
    return Text(texto, style: TextStyle(fontSize: fontsize));
  }

  Widget fondo() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.white,
    child: CustomPaint(
      painter: HeaderDiagonalPainter(),
    ),
    );
  }


  class HeaderDiagonalPainter extends CustomPainter {
  
  @override
  void paint(Canvas canvas, Size size) {
    
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xff008000);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.moveTo( 0, size.height * 0.30 );
    path.lineTo( size.width, size.height * 0.20 );
    path.lineTo( size.width, 0 );
    path.lineTo( 0, 0 );


    canvas.drawPath(path, lapiz );
  }

    @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Utilitarios {

  final urlWebapi = "http://192.168.0.2/Reserva.API/api/";

  final header = {
    'content-type': "application/json",
  };

}

class ValidacioItem{

  final String value;
  final String error;

  ValidacioItem(this.value, this.error);

}