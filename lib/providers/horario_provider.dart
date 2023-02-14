import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/utils/utils.dart';


class HorariosProvider with ChangeNotifier{

  List<Horario> listaCanchas = [];


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



  var cancionesResponse = horariosResponseFromJson(response.body);
  listaCanchas = [...listaCanchas, ...cancionesResponse.listaGenerica];
  
  return listaCanchas;
  //notifyListeners();
  }

}
