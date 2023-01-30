import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/sucursales_model.dart';
import 'package:reservaapp/utils/utils.dart';

class SucursalesProvider with ChangeNotifier{


  int _sucursalSeleccionada = 0;
  int get sucursalSeleccionada => _sucursalSeleccionada;
  set sucursalSeleccionada(int valor){
    _sucursalSeleccionada = valor;
    notifyListeners();
  }

  Future<SucursalesXUbicacionResponse> obtenerSucursalesPorUbicacion() async {
   

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Sucursal/ObtenerSucursalesPorUbicacion');

 final response = await http.get(url);


   //final resp = await http.post(
   //   url,
   //   body: datos
   //   ,headers: Utilitarios().header
   //);
//if (response.statusCode == 200) {


  return sucursalesXUbicacionResponseFromJson(response.body);
  //}
   //Map<String, dynamic> decodeResp = json.decode(resp.body);

   //return decodeResp;
  }

  
}