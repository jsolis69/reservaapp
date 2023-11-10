import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/horarios_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';


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
            SizedBox(height: 100),
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
        return CustomScrollView(
          slivers: [_sliverList(context, snapshot.data)],
        );
      }
    }
    
    
    return const Center(child: CircularProgressIndicator());
    
    }
    );
  }
}

 _sliverList( BuildContext context, dynamic canchas ) {

  //final horariosServices = Provider.of<HorarioProvider>(context, listen: false);
  //final fSer = new DateFormat('yyyy-MM-dd');
  //final reservaServices = Provider.of<ReservaProvider>(context);
  final canchasServices = Provider.of<CanchasProvider>(context);


  return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  canchasServices.canchaSeleccionada = canchas[index].idCancha;

                  //horariosServices.ObtenerHorarioPorCancha(canchasServices.canchaSeleccionada, fSer.format(reservaServices.fechaSeleccionada))
                  //.then((value){
                  //if(value.codigoRespuesta == 0)
                  //{
                  //if(horariosServices.horariosXReserva.length > 0)
                    Navigator.pushNamed(context, 'Horarios');
                 // }
                  //});



                },
                child: Center(           
                  child: Container(
                          margin: const EdgeInsets.all(20),
                          height: 40,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Text(canchas[index].nombre),
                  ),
                ),

              );
            },
            childCount: canchas.length,
          ),
        );
}