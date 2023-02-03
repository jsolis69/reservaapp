import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/utils/utils.dart';


class HorariosProvider with ChangeNotifier{

  List<Cancha> listaCanchas = [];


 Future<List<Cancha>> ObtenerHorarioPorSucursal(int idSucursal, String fecha) async {
   

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/ObtenerHorarioPorSucursal');

 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdSucursal': idSucursal.toString(),
  'Canchas': [
    {
      'Horarios':[
        { 
          'Reserva': { 
            'Fecha': fecha
          }
        }
      ]
    }
  ]
 }));



  var cancionesResponse = horariosCanchaResponseFromJson(response.body);
  listaCanchas = [...listaCanchas, ...cancionesResponse.objeto.canchas];

  return listaCanchas;

  }

}
