import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
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
            _listaCanchas(),
            HeaderWidget(
            icono: FontAwesomeIcons.solidFutbol, 
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

class _listaCanchas extends StatelessWidget {

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
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(), 
                children: [
                  SlidableAction(
                    onPressed: (value){print(value);},
                    label: 'Borrar',
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,)
                ]),
              child: TarjetaWidget(
             ancho: double.infinity,
              alto: 120.0,
              color1: PreferenciasUsuario.esModoOscuro ? Colors.grey.shade800 : Colors.white,
              color2: Colors.blue,
              titulo: snapshot.data[index].nombre,
              icono: FontAwesomeIcons.solidFutbol,
              ontap: (){ 
                canchasServices.canchaSeleccionada = snapshot.data[index].idCancha;
                //print(snapshot.data[index].nombre); 
                Navigator.pushNamed(context, 'MisHorarios');
                },
          ),
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