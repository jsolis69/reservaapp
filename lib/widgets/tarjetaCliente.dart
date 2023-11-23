import 'package:flutter/material.dart';


class TarjetaCliente extends StatelessWidget {
  final Color color1;
  final AssetImage imagen;
  final String titulo;
  final String subTitulo;
  final VoidCallback ontap;

  const TarjetaCliente({
    required this.color1, 
    required this.imagen, 
    required this.titulo, 
    this.subTitulo = '',
    required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: this.color1, width: 1)) ,
    contentPadding: EdgeInsets.all(15),
    //tileColor: Colors.red,
    //splashColor: Colors.green,
    leading: Image(image: this.imagen),// Icon(Icons.list),
    trailing: const Icon(Icons.arrow_forward_ios_sharp),
    title: Center(
      child: Text(this.titulo),
    ),
    subtitle:  Center(child: Text(this.subTitulo)),
    //isThreeLine: true,
    onTap: this.ontap,
    ),
    );
    }
}