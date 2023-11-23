import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';
import 'package:reservaapp/widgets/tarjetaCliente.dart';


class CanchasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
       
    String titulo = 'Canchas';
    Color colorPrimario = Color(0xff08088A);
    Color colorSecundario = Color(0xff5858FA);
        //final reservaServices = Provider.of<ReservaProvider>(context);
    return Scaffold(
      //appBar: AppBar(title: const Text('Canchas')),
      body: SafeArea(
        child: Stack(
          children: [
            
            Column( 
              children:[
             Expanded(child: _body()),
             const NotificacionWidget(),
             ]),

            HeaderWidget(
              icono: FontAwesomeIcons.calendarDay, 
              titulo: titulo,
              color1: colorPrimario,
              color2: colorSecundario,
              paginaReturn: 'Sucursales',
            )
        ]
        ),
      ),
    );
  }


}

class _body extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final canchasServices = Provider.of<CanchasProvider>(context, listen: false);
    final sucursalesServices = Provider.of<SucursalesProvider>(context, listen: false);
    return FutureBuilder(
    future: canchasServices.ObtenerCanchasPorSucursal(sucursalesServices.sucursalSeleccionada),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
      else if (snapshot.hasData) {

      return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              margin: EdgeInsets.only(top: 120),
              child: 
              ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
          return TarjetaCliente(
            color1: Color(0xff5858FA),
            titulo: snapshot.data[index].nombre,
            ontap: (){
                  canchasServices.canchaSeleccionada = snapshot.data[index].idCancha;
                  Navigator.pushNamed(context, 'Horarios');
                },
              imagen: AssetImage('assets/img/soccerIcon.png'),
          );
              },
            )
            ),
        );
      }
    }
    return const Center(child: CircularProgressIndicator());
    }
    );
  }
}