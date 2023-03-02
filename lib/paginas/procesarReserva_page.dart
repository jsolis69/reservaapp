import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/botonesNavegacion_widget.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';

class ProcesarReservaPage extends StatelessWidget {
  const ProcesarReservaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF333A47),
      appBar: AppBar(
        title: Text('Procesar Reserva'),
      ),
      body: _horario(),
      //bottomNavigationBar: BotonesNavegacion(seleccionado: 1,),
    );
  }
}

class _horario extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final reservaService = Provider.of<ReservaProvider>(context);
    final horario = reservaService.horarioSeleccionado;
    final f = new DateFormat('dd-MM-yyyy');
    
    return SingleChildScrollView (
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        
        children: [ Card(
          //color: Colors.white,
          shadowColor: Colors.amber,
          elevation: 8.0,
          child: SizedBox(
            //width: 300,
            height: 250,
            child: Column(
              children: [
    
    
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 110,
                      child: Center(child: Column(
                        children: [
                          EtiquetaPersonalizada(descripcion: 'Fecha', tamano: 15,),
                          EtiquetaPersonalizada(descripcion: f.format(reservaService.fechaSeleccionada), tamano: 15,),
                        ],
                      )),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)
                    ),
                      ),
    
                  Expanded(child: SizedBox()),
    
                  Container(
                  height: 40,
                  width: 110,
                  child: Center(child: Column(
                    children: [
                      EtiquetaPersonalizada(descripcion: 'Hora', tamano: 15,),
                      EtiquetaPersonalizada(descripcion: horario.horaInicio!.substring(0, 5) + ' - ' + horario.horaFin!.substring(0, 5), tamano: 15,),
                    ],
                  )),
                              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10)
                              ),
                  ),
                    
                  ],
                ),
                  SizedBox(height: 40,),
                  
                
                if(horario.reserva.equipo1.nombre!.isEmpty)
                  EtiquetaPersonalizada(descripcion: 'Disponible', tamano: 15,)
                else
                  Text(horario.reserva.equipo1.nombre! + ' vrs ' + (horario.reserva.equipo2.nombre!.isEmpty ? 'Necesita Reto' : horario.reserva.equipo2.nombre!)),
    

Expanded(
  child:   Row(
  
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
            children: [
  
            ElevatedButton(onPressed: (){}, child: Row(
  
            children: [
  
              Text('Reservar'),
  
              Icon(Icons.calendar_month),
  
            ],
  
          ), ),
  
  
  
                 ElevatedButton(onPressed: (){}, child: Row(
  
            children: [
  
              Text('Retar'),
  
              Icon(Icons.person),
  
            ],
  
          ), ),
  
  
  
                 ElevatedButton(onPressed: (){}, child: Row(
  
            children: [
  
              Text('Cancelar'),
  
              Icon(Icons.dangerous),
  
            ],
  
          ), ),
  
            ],
  
          ),
),

        

              ],
            ),
          ),
        ),
        
        ]
      ),
    );

    //eturn Row(
    //       children: [

    //         Text(horario.reserva.equipo1.nombre.toString()),
    //            //si equipo 1 es vació es porque no existe reserva
    //         if(horario.reserva.equipo1.nombre!.isEmpty)
    //           _iconoReservar(horario: horario),
    //         
    //         if((horario.reserva.equipo1.idUsuario != -1) &&
    //         (horario.reserva.equipo2.nombre!.isEmpty && horario.reserva.equipo1.idUsuario != PreferenciasUsuario.usuarioLogueado))
    //           _iconoRetar(),
    //
    //         //si el usuario logueado es parte de la reserva, puede eliminar su reserva
    //         if((horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
    //         || (horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado))
    //         _iconoEliminar(),
    //
    //
    //         if(PreferenciasUsuario.esPropietario)
    //           _iconoNotificar(),
    //       ],
    //     );
  }

  //IconButton _iconoReservar() => IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month));

  IconButton _iconoRetar() => IconButton(onPressed: (){}, icon: Icon(Icons.person));
  IconButton _iconoEliminar() => IconButton(onPressed: (){}, icon: Icon(Icons.dangerous));
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

