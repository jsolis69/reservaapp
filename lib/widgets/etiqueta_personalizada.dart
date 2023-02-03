import 'package:flutter/material.dart';

class EtiquetaPersonalizada extends StatelessWidget {
  final String descripcion;
  final Color? color;
  final double tamano;

  const EtiquetaPersonalizada({
    super.key, 
  required this.descripcion, 
  this.color, 
  required this.tamano});

  @override
  Widget build(BuildContext context) {
    return Text(descripcion, style: TextStyle(color: color, fontSize: tamano));
  }
}