import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/models/reserva_model.dart';
import 'package:reservaapp/utils/utils.dart';

class ReservaProvider with ChangeNotifier{


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

    var reservaResponse =  insertarReservaResponseFromJson(response.body);

    if(reservaResponse.codigoRespuesta == 0)
    {
      //Se limpia la lista para volverla a cargar
      //listaCanciones = [];
      //listaCanciones = [...listaCanciones, ...cancionesResponse.listaGenerica];
      notifyListeners();

    }
    return reservaResponse;
  } else {
    throw Exception('Failed to create album.');
  }
}



}