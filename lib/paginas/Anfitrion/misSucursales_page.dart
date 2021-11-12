import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservaapp/widgets/botonesNavegacionAnfitrion.dart';
import 'package:reservaapp/widgets/botones_grandes.dart';
import 'package:reservaapp/widgets/tarjeta_widget.dart';

class MisSucursalesPage extends StatelessWidget {
  //const MisSucursales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Sucursales'),
          Column(
            children: [
          IconButton(
            onPressed: (){}, 
            icon: FaIcon(FontAwesomeIcons.plusCircle)),
            Text('Agregar sucursal')
            ],
          ),
          listaScurusales(),

        ],
      ),
      bottomNavigationBar: BotonesNavegacionAnfitron(seleccionado: 0,)
    );
  }

  Widget listaScurusales() {

    return ListView(
      shrinkWrap: true,
      children: [
        TarjetaWidget(
           ancho: double.infinity,
            alto: 120.0,
            color1: Colors.greenAccent,
            color2: Color(0xff4CAF50),
        ),
      ],
    );

  }
}