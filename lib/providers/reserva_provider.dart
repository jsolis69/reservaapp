import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/utils/utils.dart';

class ReservaProvider with ChangeNotifier{

  DateTime _fechaSeleccionada = DateTime.now();
  List<Horario> listaHorarios = [];
  int _canhaSeleccionada = 0;
  Horario horarioSeleccionado = new Horario(
    idHorario: 0, 
    diaSemana: 
    new CatalogoGenerico(
      codigo: 0
    ), 
    estado: new CatalogoGenerico(
      codigo: 0
    ), 
    reserva: new Reserva(
      idReserva: 0, 
      estado: CatalogoGenerico(codigo: 0),
      indLlevaDosEquipos: false,
      fecha: DateTime.now(),
      equipo1: new Equipo(
        idUsuario: 0, 
        estado: new CatalogoGenerico(codigo: 0), 
        empresa: new Empresa(
          idEmpresa: 0, 
          estado: new CatalogoGenerico(codigo: 0), 
          logo: 0,
          sucursales: []
        ),
        permiteNotificar: false, 
        indEsAdministrador: false
      ), 
      equipo2: new Equipo(
        idUsuario: 0, 
        estado: new CatalogoGenerico(codigo: 0), 
        empresa: new Empresa(
          idEmpresa: 0, 
          estado: new CatalogoGenerico(codigo: 0), 
          logo: 0,
          sucursales: []
        ),
        permiteNotificar: false, 
        indEsAdministrador: false
        )));

  int get canchaSeleccionada => _canhaSeleccionada;
  set canchaSeleccionada(int valor){
    _canhaSeleccionada = valor;
    notifyListeners();
  }

  DateTime get fechaSeleccionada => _fechaSeleccionada;
  set fechaSeleccionada(DateTime valor){
    _fechaSeleccionada = valor;
    notifyListeners();
  }




InsertarReserva(Horario Horario, int IdSucursal) async {

final fSer = new DateFormat('yyyy-MM-dd');
 var url = Uri.http( Utilitarios().urlWebapi, 'Reserva.API/api/Reserva/InsertarReserva', {'IdSucursal': IdSucursal}.map((key, value) => MapEntry(key, value.toString())) );
 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdHorario': Horario.idHorario,
  'Reserva': 
    {
      'Equipo1':
        { 
          'IdUsuario': Horario.reserva.equipo1.idUsuario
        },
      'IndLlevaDosEquipos': Horario.reserva.indLlevaDosEquipos,
      'Fecha' : fSer.format(Horario.reserva.fecha),
      'Equipo2':
        { 
          'IdUsuario': Horario.reserva.equipo2.idUsuario
        },
    }
 }));
 
 

  if (response.statusCode == 200) {

    //var reservaResponse =  reservaResponseFromJson(response.body);  
    //listaCanchas = [];
    var reservaResponse = horariosResponseFromJson(response.body);

    if(reservaResponse.codigoRespuesta == 0)
    {
      //Se limpia la lista para volverla a cargar
      listaHorarios = [];
      listaHorarios = [...listaHorarios, ...reservaResponse.listaGenerica];
      notifyListeners();

    }
    return reservaResponse;
  } else {
    throw Exception('Error ejecutando el servicio.');
  }
}





ActualizarReserva(Horario Horario) async {

final fSer = new DateFormat('yyyy-MM-dd');
 var url = Uri.http( Utilitarios().urlWebapi, 'Reserva.API/api/Reserva/ActualizarReserva' );
 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdHorario': Horario.idHorario,
  'Reserva': 
    {
      'Fecha' : fSer.format(Horario.reserva.fecha),
      'Equipo2':
        { 
          'IdUsuario': Horario.reserva.equipo2.idUsuario
        },
    }
 }));
 
  if (response.statusCode == 200) {

    var reservaResponse = horariosResponseFromJson(response.body);

    if(reservaResponse.codigoRespuesta == 0)
    {
      //Se limpia la lista para volverla a cargar
      listaHorarios = [];
      listaHorarios = [...listaHorarios, ...reservaResponse.listaGenerica];
      notifyListeners();

    }
    return reservaResponse;
  } else {
    throw Exception('Error ejecutando el servicio.');
  }
}


EliminarReserva(Horario Horario) async {

 var url = Uri.http( Utilitarios().urlWebapi, 'Reserva.API/api/Reserva/EliminarReserva' );
 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'Reserva': 
    {
      'IdReserva' : Horario.reserva.idReserva,
      'Equipo1':
        { 
          'IdUsuario': Horario.reserva.equipo1.idUsuario
        },
      'Equipo2':
        { 
          'IdUsuario': Horario.reserva.equipo2.idUsuario
        },
    }
 }));
 
  if (response.statusCode == 200) {

    var reservaResponse = horariosResponseFromJson(response.body);

    if(reservaResponse.codigoRespuesta == 0)
    {
      //Se limpia la lista para volverla a cargar
      listaHorarios = [];
      listaHorarios = [...listaHorarios, ...reservaResponse.listaGenerica];
      notifyListeners();

    }
    return reservaResponse;
  } else {
    throw Exception('Error ejecutando el servicio.');
  }
}




ObtenerHorarioPorCancha(int idSucursal, String fecha) async {
   

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/ObtenerHorarioPorCancha');

 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdCancha': idSucursal.toString(),
  'Horarios':[
        { 
          'Reserva': { 
            'Fecha': fecha
          }
        }
      ]
    }));


  listaHorarios = [];
  var HorariosResponse = horariosResponseFromJson(response.body);
  listaHorarios = [...listaHorarios, ...HorariosResponse.listaGenerica];
  
  //return listaCanchas;
  notifyListeners();
  }




}