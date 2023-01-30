
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservaapp/widgets/botonesNavegacion_widget.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';

class SucursalesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //timeDilation = 3.0; // Changing the value to normal animation speed.
    String titulo = 'Reservar';
    Color colorPrimario = Color(0xff08088A);
    Color colorSecundario = Color(0xff5858FA);

  
    return Scaffold(
      body: Stack(
        children: [
          
          _contenido(),
          HeaderWidget(
            icono: FontAwesomeIcons.calendarDay, 
            titulo: titulo,
            color1: colorPrimario,
            color2: colorSecundario
          )
        ],
      ),
      bottomNavigationBar: BotonesNavegacion(seleccionado: 1,)
    );
  }
}

class _contenido extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
  final sucursalesServices = Provider.of<SucursalesProvider>(context);
    return FutureBuilder(
      future: sucursalesServices.obtenerSucursalesPorUbicacion(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
       else if (snapshot.hasData) {
        
        return Container(
      margin: EdgeInsets.only(top: 170),
      child: 
      ListView.builder(
      itemCount: snapshot.data.listaGenerica.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding: EdgeInsets.all(15),
            //tileColor: Colors.red,
            //leading: const Icon(Icons.list),
            trailing: const Icon(Icons.calendar_today_outlined),
            title: Text(snapshot.data.listaGenerica[index].nombre),
            subtitle:  Text(snapshot.data.listaGenerica[index].NombreEmpresa),
            //isThreeLine: true,
            onTap: (){
              sucursalesServices.sucursalSeleccionada = snapshot.data.listaGenerica[index].idSucursal;
              Navigator.pushNamed(context, 'Canchas');
              
            },
            ),
        );
      },
    )
      //Stack(
      //  children: [
      //    _crearFormularioReservar(context),
      //    SizedBox(height: 100),
      //  ],
      //),
    );



      }
        
    }
    return const Center(child: CircularProgressIndicator());



      },
    );
  }
}
