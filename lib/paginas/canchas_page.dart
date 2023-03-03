import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';


class CanchasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
        //final reservaServices = Provider.of<ReservaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Canchas')),
      body: Column(children:[
         Expanded(child: _body()),
         const NotificacionWidget(),
         ]),
    );
  }


}

class _body extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final canchasServices = Provider.of<CanchasProvider>(context);
    final sucursalesServices = Provider.of<SucursalesProvider>(context);
    return Center(
      child: FutureBuilder(
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
      ),
    );
  }
}

 _sliverList( BuildContext context, dynamic canchas ) {

  final horariosServices = Provider.of<ReservaProvider>(context);
  final fSer = new DateFormat('yyyy-MM-dd');
  final reservaServices = Provider.of<ReservaProvider>(context);


  return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  reservaServices.canchaSeleccionada = canchas[index].idCancha;

                  horariosServices.ObtenerHorarioPorCancha(reservaServices.canchaSeleccionada, fSer.format(reservaServices.fechaSeleccionada));
                  //.then((value){
                  //if(value.codigoRespuesta == 0)
                  //{
                  Navigator.pushNamed(context, 'Horarios');
                  //}
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