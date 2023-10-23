import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:reservaapp/models/usuario_model.dart';

class UsuarioProvider with ChangeNotifier{

  String _usuario = '';
  String _contrasenia = '';
  String _validarcontrasenia = '';
  String _nombre = '';
  //ValidacioItem _primerApellido = ValidacioItem(null, null);
  //ValidacioItem _segundoApellido = ValidacioItem(null, null);
  String _correo = '';
  String _telefono = '';
  bool _permiteNotificar = false;
  //String _latutud ='';
  //String _longitud='';
  //ValidacioItem _direccion = ValidacioItem(null, null);

  //getters
  String get usuario => _usuario;
  String get contrasenia => _contrasenia;
  String get validarcontrasenia => _validarcontrasenia;
  String get nombre => _nombre;
  //String get primerApellido => _primerApellido;
  //String get segundoApellido => _segundoApellido;
  String get correo => _correo;
  String get telefono => _telefono;
  bool get permiteNotificar => _permiteNotificar;
  //String get latitud => _latutud;
  //String get longitud => _longitud;




  bool get loginValido {
    if (_usuario.isNotEmpty || _contrasenia.isNotEmpty){
      return true;
    } else {
      return false;
    }
  }

  //  bool get registroValido {
  //  if (_usuario.value != null 
  //  && _contrasenia.value != null
  //  && _validarcontrasenia.value != null
  //  && _nombre.value != null
  //  && _primerApellido.value != null
  //  && _segundoApellido.value != null
  //  && _correo.value != null
  //  && _telefono.value != null
  //  && _direccion.value != null
  //  ){
  //    return true;
  //  } else {
  //    return false;
  //  }
  //}


  //setters
  set usuario(String value){
    _usuario = value;
  //if (value.length >= 3){
  //  _usuario=ValidacioItem(value,null);
  //} else {
  //  _usuario=ValidacioItem(null, "El usuario debe ser al menos 3 dígitos");
  //}
  notifyListeners();
  }

  set contrasenia(String value){
  _contrasenia = value;
  notifyListeners();
  }

  set validarcontrasenia(String value){
  _validarcontrasenia = value;
  notifyListeners();
  }

  set nombre(String value){
  _nombre = value;
  notifyListeners();
  }

  set correo(String value){
  _correo = value;
  notifyListeners();
  }

  set telefono(String value){
  _telefono = value;
  notifyListeners();
  }

  set permiteNotificar(bool value){
  _permiteNotificar = value;
  notifyListeners();
  }



  Future<UsuarioResponse> login( ) async {
    

   final autData = {
     'CodUsuario' : this.usuario,
     'Contrasenia': this.contrasenia,
     //'returnSecureToken' : true
   };

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Autenticar/AutenticarUsuario');

 
 final datos = json.encode( autData );


   final resp = await http.post(
      url,
      body: datos
      ,headers: Utilitarios().header
   );

   if(resp.statusCode == 200)
   {
      UsuarioResponse autenticar = usuarioResponseFromJson(resp.body);

      PreferenciasUsuario.esPropietario = autenticar.objeto.indEsAdministrador;
      PreferenciasUsuario.usuarioLogueado = autenticar.objeto.idUsuario;


      return autenticar;
   }
   else{
    throw Exception('Ocurrió un error al autenticar.');
   }

   //Map<String, dynamic> decodeResp = json.decode(resp.body);

   
  }


Future<UsuarioResponse> registrarUsuario( ) async {


 final autData = {
     'CodUsuario': this.usuario,
     'Contrasenia': this.contrasenia,
     'Nombre': this.nombre,
     'Telefono': this.telefono,
     'Email': this.correo,
     'PermiteNotificar': this.permiteNotificar
 };


 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Usuario/InsertarUsuario');
 final datos = json.encode( autData );


  final resp = await http.post(
     url,
     body: datos
     ,headers: Utilitarios().header
  );

   if(resp.statusCode == 200)
   {
      UsuarioResponse autenticar = usuarioResponseFromJson(resp.body);
      //PreferenciasUsuario.esPropietario = autenticar.objeto.indEsAdministrador;
      //PreferenciasUsuario.usuarioLogueado = autenticar.objeto.idUsuario;
      return autenticar;
   }
   else{
    throw Exception('Ocurrió un error al autenticar.');
   }
}

}