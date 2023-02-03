
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
//import 'package:reservaapp/blocs/registro_bloc.dart';
//import 'package:reservaapp/models/usuario_model.dart';
import 'package:reservaapp/utils/utils.dart';
//import 'package:recetaap/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/autenticar_model.dart';

class UsuarioProvider with ChangeNotifier{



  String _usuario = '';
  String _contrasenia = '';
  String _validarcontrasenia = '';
  String _nombre = '';
  //ValidacioItem _primerApellido = ValidacioItem(null, null);
  //ValidacioItem _segundoApellido = ValidacioItem(null, null);
  String _correo = '';
  String _telefono = '';
  String _latutud ='';
  String _longitud='';
  //ValidacioItem _direccion = ValidacioItem(null, null);

  //getters
  String get usuario => _usuario;
  String get contrasenia => _contrasenia;
  String get validarcontrasenia => _validarcontrasenia;
  String get nombre => _nombre;
  //String get primerApellido => _primerApellido;
  //String get segundoApellido => _segundoApellido;
  String get correo => _correo;
  String get latitud => _latutud;
  String get longitud => _longitud;




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

//void cambiarConfirmarcontrasenia(String value){
//if (value.length >= 6){
//  if(_contrasenia.value != value){
//      _validarcontrasenia = ValidacioItem(null, 'Las contraseñas no coinciden');
//  }
//  else   
//      {
//      _validarcontrasenia = ValidacioItem(value, null);
//  }
//} else {
//  _validarcontrasenia=ValidacioItem(null, "La contraseña debe ser al menos 6 dígitos");
//}
//notifyListeners();
//}
//
//void cambiarNombre(String value){
//if (value.length >= 3){
//  _nombre=ValidacioItem(value,null);
//} else {
//  _nombre=ValidacioItem(null, "El nombre debe ser al menos 3 dígitos");
//}
//notifyListeners();
//}
//
//void cambiarPrimerApellido(String value){
//if (value.length >= 3){
//  _primerApellido=ValidacioItem(value,null);
//} else {
//  _primerApellido=ValidacioItem(null, "EL Primer Apellido debe ser al menos 3 dígitos");
//}
//notifyListeners();
//}
//
//void cambiarSegundoApellido(String value){
//if (value.length >= 3){
//  _segundoApellido=ValidacioItem(value,null);
//} else {
//  _segundoApellido=ValidacioItem(null, "El Segundo Apellido debe ser al menos 3 dígitos");
//}
//notifyListeners();
//}
//
//
//void cambiarCorreo(String value){
//if (value.length >= 3){
//  _correo=ValidacioItem(value,null);
//} else {
//  _correo=ValidacioItem(null, "El correo debe ser al menos 3 dígitos");
//}
//notifyListeners();
//}
//
//void cambiarTelefono(String value){
//if (value.length >= 8){
//  _telefono=ValidacioItem(value,null);
//} else {
//  _telefono=ValidacioItem(null, "El teléfono debe ser al menos 8 dígitos");
//}
//notifyListeners();
//}
//
//  void cambiarDireccion(String value){
//if (value.length >= 10){
//  _direccion=ValidacioItem(value,null);
//} else {
//  _direccion=ValidacioItem(null, "La dirección debe ser al menos 10 dígitos");
//}
//notifyListeners();
//}
  //final String _firebaseToken = 'AIzaSyCuKVxvgt-4S_VFSddsl7Sw7Da9QFij0mY';
  //final _prefs = new PreferenciasUsuario();

//  Usuario _usuario;
//  Usuario get usuario => this._usuario;
//
//
//  set usuario(Usuario usr){
//
//    this._usuario = usr;
//    notifyListeners();
//
//  }
//
//  void cambiarUsuario(String usuario){
//
//    this._usuario.nombre = usuario;
//    notifyListeners();
//  }
//
//  void cambiarContrasenia(String con){
//
//    this._usuario.contrasenia = con;
//    notifyListeners();
//  }




  Future<AutenticarResponse> login( ) async {
    

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
      AutenticarResponse autenticar = autenticarResponseFromJson(resp.body);

      PreferenciasUsuario.esPropietario = autenticar.objeto.indEsAdministrador;
      PreferenciasUsuario.usuarioLogueado = autenticar.objeto.idUsuario;


      return autenticar;
   }
   else{
    throw Exception('Ocurrió un error al autenticar.');
   }

   //Map<String, dynamic> decodeResp = json.decode(resp.body);

   
  }


//Future<Map<String, dynamic>> registrarUsuario( ) async {
//
//
// final autData = {
//     'CodUsuario': this.usuario.value,
//     'Contrasenia': this.contrasenia.value,
//     'Nombre': this.nombre.value,
//     'PrimerApellido': this.primerApellido.value,
//     'SegundoApelldo': this.segundoApellido.value,
//     'Telefono': this.telefono.value,
//     'Direccion': this.direccion.value,
//     'Email': this.correo.value
// };
//
//
// final url = Uri.http( Utilitarios().urlWebapi + 'Usuario/InsertarUsuario');
// final datos = json.encode( autData );
//
//
//  final resp = await http.post(
//     url,
//     body: datos
//     ,headers: Utilitarios().header
//  );
//
//  Map<String, dynamic> decodeResp = json.decode(resp.body);
//
// return decodeResp;
//}

}