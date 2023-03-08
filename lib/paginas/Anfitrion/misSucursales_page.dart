import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/botonesNavegacionAnfitrion.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/tarjeta_widget.dart';

class MisSucursalesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            HeaderWidget(
            icono: FontAwesomeIcons.calendarDay, 
            titulo: 'Sucursales',
            color1: Colors.green,
            color2: Colors.grey
          ),
            
            _listaScurusales(),
            
          ],
        ),
      ),
      bottomNavigationBar: BotonesNavegacionAnfitron(seleccionado: 0,)
    );
  }

  
}

class _listaScurusales extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final sucursalesServices = Provider.of<SucursalesProvider>(context);
    return FutureBuilder(
      future: sucursalesServices.ObtenerSucursalesPorPropietario(PreferenciasUsuario.usuarioLogueado),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
       else if (snapshot.hasData) {
        
        return ListView.builder(
          padding: EdgeInsets.only(top: 110),
          //itemExtent: 50,
          itemCount: snapshot.data.listaGenerica.length,
          itemBuilder: (BuildContext context, int index) {
            return TarjetaWidget(
             ancho: double.infinity,
              alto: 120.0,
              color1: Colors.grey,
              color2: Colors.black,
              titulo: snapshot.data.listaGenerica[index].nombre
          );
          },
        
        );

      }
        
    }
    return const Center(child: CircularProgressIndicator());



      },
    );

  }
  }