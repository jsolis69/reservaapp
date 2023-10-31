import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/ubicaciones_model.dart';
import 'package:reservaapp/utils/utils.dart';

class UbicacionesProvider with ChangeNotifier{


  //ListaUbicaciones _provinciaSeleccionada;
  //List<Cantone> _cantonesxProvincia;
//
  //List<Cantone> get cantonesxProvincia => _cantonesxProvincia;
  //ListaUbicaciones get provinciaSeleccionada => _provinciaSeleccionada;
//
  //set provinciaSeleccionada(ListaUbicaciones provincia){
//
  //  this._provinciaSeleccionada = provincia;
  //  notifyListeners();
  //}
//
  //set cantonesxProvincia(List<Cantone> cantones){
//
  //  this._cantonesxProvincia = cantones;
  //  notifyListeners();
  //}




//  Future<UbicacionesResponse> obtenerProvincias( ) async {
//    
//
//   final autData = {
//    "CodigoProvincia": ""
//  };
//
//var url = Uri.http( Utilitarios().urlWebapi + 'Provincia/ObtenerProvincias');
//
// final datos = json.encode( autData );
//
//
//   final resp = await http.post(
//      url,
//      body: datos
//      ,headers: Utilitarios().header
//   );
//
//  return ubicacionesResponseFromJson(resp.body);
//
//  }


}