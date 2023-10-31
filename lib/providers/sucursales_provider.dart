import 'dart:convert';

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


  String _nombre = '';
  String get nombre => _nombre;
  set nombre(String valor){
    _nombre = valor;
    notifyListeners();
  }

    String _telefono = '';
  String get TableBorder => _telefono;
  set telefono(String valor){
    _telefono = valor;
    notifyListeners();
  }

  String _correo = '';
  String get correo => _correo;
  set correo(String valor){
    _correo = valor;
    notifyListeners();
  }



  Future<SucursalesXUbicacionResponse> obtenerSucursalesPorUbicacion() async {
   

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Sucursal/ObtenerSucursalesPorUbicacion');

  final response = await http.get(url);

  return sucursalesXUbicacionResponseFromJson(response.body);

  }

   Future<SucursalesXUbicacionResponse> ObtenerSucursalesPorPropietario(idUsurio) async {
   

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Sucursal/ObtenerSucursalesPorPropietario');

  final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdUsuario': idUsurio.toString(),
  }));

  return sucursalesXUbicacionResponseFromJson(response.body);

  }

  
}