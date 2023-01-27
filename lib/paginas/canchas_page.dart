import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/horario_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';


class CanchasPage extends StatefulWidget {

  @override
  State<CanchasPage> createState() => _CanchasPageState();
}

class _CanchasPageState extends State<CanchasPage> {

    DateTime selectedDate = DateTime.now();
      Future<void> _seleccionarFecha(BuildContext context)async {
            DateTime? pickedDate = await showDatePicker(
              locale: const Locale("es", "ES"),
              context: context, 
              initialDate: selectedDate, 
              firstDate: DateTime.now().add(const Duration(days: -30)), 
              lastDate: DateTime.now().add(const Duration(days: 30 ))
              );
              setState(() {
                selectedDate = pickedDate!;
              });
          }

  @override
  Widget build(BuildContext context) {
  final f = new DateFormat('dd-MM-yyyy');
    return Scaffold(
      appBar: _appBar(f, context),
      body: Column(children:[
         Expanded(child: _body(selectedDate: selectedDate)),
         const NotificacionWidget(),
         ]),
    );
  }

  AppBar _appBar(DateFormat f, BuildContext context) {
    return AppBar(
    title: Center(child: Text(f.format(selectedDate))),
    actions: [
      IconButton(
        onPressed: () {
          _seleccionarFecha(context);
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
    final fSer = new DateFormat('yyyy-MM-dd');


    return FutureBuilder(
    future: horariosServices.ObtenerHorarioPorSucursal(2, fSer.format(selectedDate)),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
      else if (snapshot.hasData) {
        return CustomScrollView(
          slivers: _sliverList(snapshot.data.objeto.canchas),
        );
      }
    }


    return const Center(child: CircularProgressIndicator());

    }
    );
  }
}

List<Widget> _sliverList( dynamic canchas) {
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
                  horario.reserva.equipo1.idUsuario = PreferenciasUsuario.usuarioLogueado;
                  horario.reserva.indLlevaDosEquipos = true;
                  horario.reserva.fecha = DateTime.now();
                  horario.reserva.equipo2.idUsuario = -1;

                  reservaServices.InsertarReserva(horario, 2).then((value){
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
                onPressed: (){},),

            //si el usuario logueado es parte de la reserva, puede eliminar su reserva
            if((horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
            || (horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado))
              IconButton(
                icon: Icon(Icons.dangerous),
                onPressed: (){},),
          ])
      ]
                
    );
  }
}