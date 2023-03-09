import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/botonesNavegacionAnfitrion.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/tarjeta_widget.dart';

class MisCanchasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue[600],
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _listaScurusales(),
            HeaderWidget(
            icono: FontAwesomeIcons.footballBall, 
            titulo: 'Canchas',
            color1: Colors.blue,
            color2: Colors.grey,
            paginaReturn: 'MisSucursales',
          ),
            
            
            
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

  final canchasServices = Provider.of<CanchasProvider>(context);
  final sucursalesServices = Provider.of<SucursalesProvider>(context);
  
    return FutureBuilder(
      future: canchasServices.ObtenerCanchasPorSucursal(sucursalesServices.sucursalSeleccionada),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
       else if (snapshot.hasData) {
        
        return ListView.builder(
          padding: EdgeInsets.only(top: 110),
          //itemExtent: 50,
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return TarjetaWidget(
             ancho: double.infinity,
              alto: 120.0,
              color1: Colors.grey,
              color2: Colors.grey.shade400,
              titulo: snapshot.data[index].nombre,
              ontap: (){ 
                canchasServices.canchaSeleccionada = snapshot.data[index].idCancha;
                //print(snapshot.data[index].nombre); 
                },
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