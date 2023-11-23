import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/models/empresa_model.dart';
import 'package:reservaapp/utils/utils.dart';


class EmpresaProvider with ChangeNotifier{
  
  int _idUsuario = 0;
  int get idUsuario => _idUsuario;
  set idUsuario(int value){
    _idUsuario = value;
    notifyListeners();
  }

  
  String _telefono = '';
  String get telefono => _telefono;
  set telefono(String value){
    _telefono = value;
    notifyListeners();
  }

  String _correo = '';
  String get correo => _correo;
  set correo(String value){
    _correo = value;
    notifyListeners();
  }
  
  String _nombre = '';
  String get nombre => _nombre;
  set nombre(String value){
    _nombre = value;
    notifyListeners();
  }

  Future<EmpresaResponse> InsertarEmpresa() async {
    final autData = {
     'IdUsuario': this.idUsuario,
     'Empresa': {
        'Nombre': this.nombre,
        'Telefono': this.telefono,
        'Correo': this.correo
     }
    };
    
    var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Empresa/InsertarEmpresa');
    final datos = json.encode( autData );
    
    final resp = await http.post(
     url,
     body: datos
     ,headers: Utilitarios().header
    );

   if(resp.statusCode == 200) {
    EmpresaResponse empresa = empresaResponseFromJson(resp.body);
      return empresa;
   }
   else{
    throw Exception('Ocurrió un error al autenticar.');
   }
  }

}