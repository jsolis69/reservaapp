import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';

class ProcesarReservaPage extends StatelessWidget {
  const ProcesarReservaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Procesar Reserva'),
      ),
      body: _horario(),
    );
  }
}

class _horario extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
                 //si equipo 1 es vació es porque no existe reserva
              //if(horario.reserva.equipo1.nombre?.isEmpty)
                //_iconoReservar(horario: horario),
              
              //if((horario.reserva.equipo1.idUsuario != -1) &&
              //(horario.reserva.equipo2.nombre?.isEmpty && horario.reserva.equipo1.idUsuario != PreferenciasUsuario.usuarioLogueado))
                _iconoRetar(),
    
              //si el usuario logueado es parte de la reserva, puede eliminar su reserva
              //if((horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
              //|| (horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado))
              _iconoEliminar(),
    
    
              if(PreferenciasUsuario.esPropietario)
                _iconoNotificar(),
            ],
          );
  }

  //IconButton _iconoReservar() => IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month));

  IconButton _iconoRetar() => IconButton(onPressed: (){}, icon: Icon(Icons.dangerous));
  IconButton _iconoEliminar() => IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month));
  IconButton _iconoNotificar() => IconButton(onPressed: (){}, icon: Icon(Icons.send));
}


class _iconoReservar extends StatelessWidget {
  const _iconoReservar({
    required this.horario,
  });

  final horario;
  @override
  Widget build(BuildContext context) {

  final reservaServices = Provider.of<ReservaProvider>(context, listen: true);
  final notificacionModel = Provider.of<NotificacionModel>(context);
  final sucursalesServices = Provider.of<SucursalesProvider>(context);

    return IconButton(onPressed: (){
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

                


    }, icon: Icon(Icons.calendar_month));
  }
}

