import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/horario_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';


class CanchasPage extends StatelessWidget {

      //Future<void> _seleccionarFecha(BuildContext context)async {
//
      //  final reservaServices = Provider.of<ReservaProvider>(context);
      // //final prueba = '';
//
      //      DateTime? pickedDate = await showDatePicker(
      //        locale: const Locale("es", "ES"),
      //        context: context, 
      //        initialDate: reservaServices.fechaSeleccionada, 
      //        firstDate: DateTime.now().add(const Duration(days: -30)), 
      //        lastDate: DateTime.now().add(const Duration(days: 30 ))
      //        );
      //       
      //       reservaServices.fechaSeleccionada = pickedDate!;
      //    }

  @override
  Widget build(BuildContext context) {
    
        final reservaServices = Provider.of<ReservaProvider>(context);
  final f = new DateFormat('dd-MM-yyyy');
    return Scaffold(
      appBar: _appBar(f, context),
      body: Column(children:[
         Expanded(child: _body(selectedDate: reservaServices.fechaSeleccionada)),
         const NotificacionWidget(),
         ]),
    );
  }

  AppBar _appBar(DateFormat f, BuildContext context) {
    
    final reservaServices = Provider.of<ReservaProvider>(context);
    return AppBar(
    title: Center(child: Text(f.format(reservaServices.fechaSeleccionada))),
    actions: [
      IconButton(
        onPressed: () async {

            DateTime? pickedDate = await showDatePicker(
              locale: const Locale("es", "ES"),
              context: context, 
              initialDate: reservaServices.fechaSeleccionada, 
              firstDate: DateTime.now().add(const Duration(days: -30)), 
              lastDate: DateTime.now().add(const Duration(days: 30 ))
              );
             
             reservaServices.fechaSeleccionada = pickedDate!;



          //_seleccionarFecha(context);
        },
        icon: Icon(Icons.calendar_month),
        )
    ],
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

    final horariosServices = Provider.of<HorariosProvider>(context);
    final sucursalesServices = Provider.of<SucursalesProvider>(context);
    final fSer = new DateFormat('yyyy-MM-dd');


    return FutureBuilder(
    future: horariosServices.ObtenerHorarioPorSucursal(sucursalesServices.sucursalSeleccionada, fSer.format(selectedDate)),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
      else if (snapshot.hasData) {
        return CustomScrollView(
          slivers: _sliverList(context),
        );
      }
    }


    return const Center(child: CircularProgressIndicator());

    }
    );
  }
}

List<Widget> _sliverList( BuildContext context ) {

    final horariosServices = Provider.of<HorariosProvider>(context);
    var canchas = horariosServices.listaCanchas;
    var widgetList = <Widget>[];
    for (int contador = 0; contador < canchas.length; contador++)
      widgetList
        ..add(SliverAppBar(
          flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 165, 93, 4),
                      Color.fromARGB(255, 192, 118, 6),
                    ],
                  ),
                ),
              ),
           leading: Icon(Icons.sports_soccer_sharp),
           title: Text(canchas[contador].nombre),
           pinned: true,
         ))
        ..add(SliverFixedExtentList(
          itemExtent: 50.0,
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {

                final horario = canchas[contador].horarios[index];


                return Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: _horarios(horario: horario),
                );
              }, childCount: canchas[contador].horarios.length),
        ));

   return widgetList;
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