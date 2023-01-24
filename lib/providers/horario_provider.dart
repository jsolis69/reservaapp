import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/utils/utils.dart';


class HorariosProvider with ChangeNotifier{

 Future<HorariosCanchaResponse> ObtenerHorarioPorSucursal(int idSucursal) async {
   

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
            'Fecha': '2023-01-17'
          }
        }
      ]
    }
  ]
 }));


   //final resp = await http.post(
   //   url,
   //   body: datos
   //   ,headers: Utilitarios().header
   //);
//if (response.statusCode == 200) {


  return horariosCanchaResponseFromJson(response.body);
  //}
   //Map<String, dynamic> decodeResp = json.decode(resp.body);

   //return decodeResp;
  }

}
