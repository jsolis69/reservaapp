import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/sucursales_model.dart';
import 'package:reservaapp/utils/utils.dart';

class SucursalesProvider with ChangeNotifier{





  Future<SucursalesXUbicacionResponse> obtenerSucursalesPorUbicacion( int idprovincia, int idcanton, int iddistrito ) async {
    

   final autData = {
    "Ubicacion": {
        "CodigoProvincia": "$idprovincia",
        "Cantones": [
          {
            "CodigoCanton": "$idcanton",
            "Distritos": [
                {
                    "CodigoDistrito": "$iddistrito"
                }
            ]
          }
        ]
    }
  };

 final url = Uri.http( Utilitarios().urlWebapi + 'Sucursal/ObtenerSucursalesPorUbicacion');
 final datos = json.encode( autData );


   final resp = await http.post(
      url,
      body: datos
      ,headers: Utilitarios().header
   );

  return sucursalesXUbicacionResponseFromJson(resp.body);

   //Map<String, dynamic> decodeResp = json.decode(resp.body);

   //return decodeResp;
  }

  
}