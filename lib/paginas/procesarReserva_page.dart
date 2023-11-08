import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/providers/horarios_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';
import 'package:reservaapp/widgets/notificacion_widget.dart';

class ProcesarReservaPage extends StatelessWidget {
  const ProcesarReservaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF333A47),
      appBar: AppBar(
        title: Text('Procesar Reserva'),
      ),
      body: Column(
        children: [
          Expanded(child: _horario()),
          const NotificacionWidget(),
        ],
      ),
      //bottomNavigationBar: BotonesNavegacion(seleccionado: 1,),
    );
  }
}

class _horario extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final reservaService = Provider.of<ReservaProvider>(context, listen: true);
    final horarioService = Provider.of<HorarioProvider>(context);
    final horario = horarioService.horarioSeleccionado;
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
                else if (horario.reserva.indLlevaDosEquipos)
                  EtiquetaPersonalizada(descripcion: 'Cancha reservada por: ${horario.reserva.equipo1.nombre}', tamano: 15,)
                else
                  Text(horario.reserva.equipo1.nombre! + ' vrs ' + (horario.reserva.equipo2.nombre!.isEmpty ? 'Necesita Reto' : horario.reserva.equipo2.nombre!)),
    
               SwitchListTile(
                    value: horarioService.horarioSeleccionado.reserva.indLlevaDosEquipos, 
                    onChanged: horario.reserva.equipo1.nombre!.isNotEmpty ? null : (value){
                    //print(value);
                    horario.reserva.indLlevaDosEquipos = value;
                    horarioService.horarioSeleccionado = horario;
                    },
                    title: EtiquetaPersonalizada(descripcion: 'Lleva los dos equipos', tamano: 15),
                    activeColor:Colors.amber,
                    controlAffinity: ListTileControlAffinity.leading,
                    inactiveThumbColor: horario.reserva.equipo1.nombre!.isNotEmpty ? Colors.red :Colors.amber,
                  ),

                _listaBotones1(horario: horario),

              ],
            ),
          ),
        ),
        
        ]
      ),
    );
  }


}

class _listaBotones1 extends StatelessWidget {
  const _listaBotones1({
    required this.horario,
  });

  
  final horario;
  
  
  @override
  Widget build(BuildContext context) {


  final reservaServices = Provider.of<ReservaProvider>(context, listen: true);
  final horarioServices = Provider.of<HorarioProvider>(context);
    //Horario horario = reservaServices.horarioSeleccionado;

  final notificacionModel = Provider.of<NotificacionModel>(context);
  final sucursalesServices = Provider.of<SucursalesProvider>(context);

    return Expanded(
  child:   Row(
  
            mainAxisAlignment: MainAxisAlignment.center,
  
            children: [
  
          if(horario.reserva.equipo1.idUsuario <= 0)
            ElevatedButton(onPressed: (){
                  horario.reserva.equipo1.idUsuario = PreferenciasUsuario.usuarioLogueado;
                  horario.reserva.fecha = reservaServices.fechaSeleccionada;
                  horario.reserva.equipo2.idUsuario = -1;

                  reservaServices.InsertarReserva(horario, sucursalesServices.sucursalSeleccionada).then((value){
                    notificacionModel.codigo = value.codigoRespuesta;
                        if(value.codigoRespuesta == 0)
                        {
                          horarioServices.horarioSeleccionado = value.listaGenerica.where((i) => i.idHorario == horario.idHorario).first;
                          
    
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

                


            }, child: Row(
            children: [
              Text('Reservar'),
              Icon(Icons.calendar_month),
            ],
  
          ), ),
  
  
            if((horario.reserva.equipo1.idUsuario > 0) &&
             (horario.reserva.equipo2.idUsuario <= 0 && horario.reserva.equipo1.idUsuario != PreferenciasUsuario.usuarioLogueado)
             && !horario.reserva.indLlevaDosEquipos
             )
                 ElevatedButton(onPressed: (){

                  horario.reserva.fecha = reservaServices.fechaSeleccionada;
                  horario.reserva.equipo2.idUsuario = PreferenciasUsuario.usuarioLogueado;

                  reservaServices.ActualizarReserva(horario).then((value){
                    notificacionModel.codigo = value.codigoRespuesta;
                        if(value.codigoRespuesta == 0)
                        {
                          horarioServices.horarioSeleccionado = value.listaGenerica.where((i) => i.idHorario == horario.idHorario).first;
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


                 }, child: Row(
                children: [
              Text('Retar'),
              Icon(Icons.person),
            ],
  
          ), ),
  
  
          //si el usuario logueado es parte de la reserva, puede eliminar su reserva
             if((horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
             || (horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado))
                 ElevatedButton(onPressed: (){



          
                  if(horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado)
                    horario.reserva.equipo2.idUsuario = 0;
                    //horario.reserva.equipo1.idUsuario = 0;

                  if(horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
                    horario.reserva.equipo1.idUsuario = 0;
                    //horario.reserva.equipo2.idUsuario = 0;


                  reservaServices.EliminarReserva(horario).then((value){
                    notificacionModel.codigo = value.codigoRespuesta;
                        if(value.codigoRespuesta == 0)
                        {
                          horarioServices.horarioSeleccionado = value.listaGenerica.where((i) => i.idHorario == horario.idHorario).first;
                          //reservaServices.horarioSeleccionado = value.listaGenerica.where((i) => i.idHorario == horario.idHorario).first;
                          
                          //horario = reservaServices.horarioSeleccionado;
                          //var horarioresp = value.listaGenerica.where((i) => i.idHorario = horario.idHorario).first();
                          //horario.reserva.equipo1.idUsuario = horarioresp.reserva.equipo1.idUsuario;
                          //horario.reserva.equipo2.idUsuario = horarioresp.reserva.equipo2.idUsuario;
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





                 }, child: Row(
            children: [
              Text('Cancelar'),
              Icon(Icons.dangerous),
            ],
  
          ), ),


      //Se comenta para buscar la forma de obtener si es propietario de cual comercio
      //ahorita sale solo como es propietario, pero no se sabe de cual comercio
      //si es propieratio tiene la posibilidad de notificar
      //if(PreferenciasUsuario.esPropietario)
      //      ElevatedButton(onPressed: (){}, child: Row(children: [Text('Notificar'), Icon(Icons.send)],),),
          
  
            ],
  
          ),
);
  }
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

