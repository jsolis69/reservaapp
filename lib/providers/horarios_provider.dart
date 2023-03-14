import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:http/http.dart' as http;


class HorarioProvider with ChangeNotifier
{

   List<Horario> misHorarios = [];

  
  ObtenerMisHorarios(int IdCancha) async {
   

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/ObtenerHorario');

 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdCancha': IdCancha.toString()
    }));


  //misHorarios = [];
  var HorariosResponse = horariosResponseFromJson(response.body);

  return HorariosResponse;
  //misHorarios = [...misHorarios, ...HorariosResponse.listaGenerica];
  
  //return listaCanchas;
  //notifyListeners();
  }


}