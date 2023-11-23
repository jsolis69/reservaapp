import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/cancha_model.dart';
import 'package:reservaapp/utils/utils.dart';

class CanchasProvider with ChangeNotifier{
  
  List<Cancha> listaCanchas = [];
  int _canchaSeleccionada = 0;
  
  int get canchaSeleccionada => _canchaSeleccionada;
  set canchaSeleccionada(int valor){
    _canchaSeleccionada = valor;
    notifyListeners();
  }
  
  ObtenerCanchasPorSucursal(int idSucursal) async {
    var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Cancha/ObtenerCanchasXSucursal');
    final response = await http.post(url,
    headers: Utilitarios().header,
    body: jsonEncode({
      'IdSucursal': idSucursal.toString(),
    }));

    var cancionesResponse = canchaResponseFromJson(response.body);
    
    return cancionesResponse.listaGenerica;
  }
}