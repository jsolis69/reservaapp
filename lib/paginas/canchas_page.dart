import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/horario_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';


class CanchasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
        final reservaServices = Provider.of<ReservaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Canchas')),
      body: Column(children:[
         Expanded(child: _body(selectedDate: reservaServices.fechaSeleccionada)),
         const NotificacionWidget(),
         ]),
    );
  }


}

class _body extends StatelessWidget {
  const _body({
    required this.selectedDate,
  });

  final DateTime selectedDate;

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


  final reservaServices = Provider.of<ReservaProvider>(context);
   return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  reservaServices.canchaSeleccionada = canchas[index].idCancha;
                  Navigator.pushNamed(context, 'Horarios');
                },
                child: Center(
                  child: Container(
                          margin: const EdgeInsets.all(20),
                          height: 40,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text(canchas[index].nombre),
                  ),
                ),

              );
            },
            childCount: canchas.length,
          ),
        );
}

class _horarios extends StatelessWidget {
  const _horarios({
    required this.horario,
  });

  final horario;

  @override
  Widget build(BuildContext context) {

    
  final reservaServices = Provider.of<ReservaProvider>(context);
  final notificacionModel = Provider.of<NotificacionModel>(context);
  final sucursalesServices = Provider.of<SucursalesProvider>(context);
  final horariosServices = Provider.of<HorariosProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
          Text(horario.horaInicio +' - ' + horario.horaFin),
          !horario.reserva.equipo1.nombre?.isEmpty ? 
          Text((horario.reserva.equipo1.nombre?? '') + '-' + (horario.reserva.equipo2.nombre?.isEmpty ? 'Esperando reto' : horario.reserva.equipo2.nombre))
          :Text('Disponible'),
          
          
          Row(children: [
            //si equipo 1 es vació es porque no existe reserva
            if(horario.reserva.equipo1.nombre?.isEmpty)
              IconButton(
                icon: Icon(Icons.calendar_month),
                onPressed: (){

                  //TODO hacer un dialog para validar si lleva ambos equipos
                  //showDialog(context: context, builder: Container());
                  horario.reserva.equipo1.idUsuario = PreferenciasUsuario.usuarioLogueado;
                  horario.reserva.indLlevaDosEquipos = true;
                  horario.reserva.fecha = reservaServices.fechaSeleccionada;
                  horario.reserva.equipo2.idUsuario = -1;

                  reservaServices.InsertarReserva(horario, sucursalesServices.sucursalSeleccionada).then((value){
                    notificacionModel.codigo = value.codigoRespuesta;
                        if(value.codigoRespuesta == 0)
                        {
                          notificacionModel.descripcion = "Reserva agregada satisfactoriamente";
                          notificacionModel.mostrarAlerta = true;
                          Timer(const Duration(seconds: 3), (() => { 
                            notificacionModel.mostrarAlerta = false 
                          } ));
                        }
                        else
                        {
                          notificacionModel.mostrarAlerta = true;
                          notificacionModel.descripcion = value.descripcionRespuesta;
                          Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
                        } 

                  });

                },),

            //si es propieratio tiene la posibilidad de notificar
            if(PreferenciasUsuario.esPropietario)
            IconButton(
                icon: Icon(Icons.send),
                onPressed: (){},),
            //si equipo 2 es vació es porque puedo retar al equipo 1
            if((horario.reserva.equipo1.idUsuario != -1) &&
              (horario.reserva.equipo2.nombre?.isEmpty && horario.reserva.equipo1.idUsuario != PreferenciasUsuario.usuarioLogueado))
               IconButton(
                icon: Icon(Icons.person),
                onPressed: (){

                  //TODO hacer un dialog para validar si lleva ambos equipos
                  //showDialog(context: context, builder: Container());
                  horario.reserva.fecha = reservaServices.fechaSeleccionada;
                  horario.reserva.equipo2.idUsuario = PreferenciasUsuario.usuarioLogueado;

                  reservaServices.ActualizarReserva(horario).then((value){
                    notificacionModel.codigo = value.codigoRespuesta;
                        if(value.codigoRespuesta == 0)
                        {
                          notificacionModel.descripcion = "Reserva actualizada satisfactoriamente";
                          notificacionModel.mostrarAlerta = true;
                          Timer(const Duration(seconds: 3), (() => { 
                            notificacionModel.mostrarAlerta = false 
                          } ));
                        }
                        else
                        {
                          notificacionModel.mostrarAlerta = true;
                          notificacionModel.descripcion = value.descripcionRespuesta;
                          Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
                        } 

                  });



                },),

            //si el usuario logueado es parte de la reserva, puede eliminar su reserva
            if((horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
            || (horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado))
              IconButton(
                icon: Icon(Icons.dangerous),
                onPressed: (){


          
                  if(horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado)
                    horario.reserva.equipo2.idUsuario = 0;

                  if(horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
                    horario.reserva.equipo1.idUsuario = 0;

                  reservaServices.EliminarReserva(horario).then((value){
                    notificacionModel.codigo = value.codigoRespuesta;
                        if(value.codigoRespuesta == 0)
                        {
                          notificacionModel.descripcion = "Reserva actualizada satisfactoriamente";
                          notificacionModel.mostrarAlerta = true;
                          Timer(const Duration(seconds: 3), (() => { 
                            notificacionModel.mostrarAlerta = false 
                          } ));
                        }
                        else
                        {
                          notificacionModel.mostrarAlerta = true;
                          notificacionModel.descripcion = value.descripcionRespuesta;
                          Timer(const Duration(seconds: 3), (() => { notificacionModel.mostrarAlerta = false } ));
                        } 

                  });





                },),
          ])
      ]
                
    );
  }
}