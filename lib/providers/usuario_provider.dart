
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
//import 'package:reservaapp/blocs/registro_bloc.dart';
//import 'package:reservaapp/models/usuario_model.dart';
import 'package:reservaapp/utils/utils.dart';
//import 'package:recetaap/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider with ChangeNotifier{



  ValidacioItem _usuario = ValidacioItem(null, null);
  ValidacioItem _contrasenia = ValidacioItem(null, null);
  ValidacioItem _validarcontrasenia = ValidacioItem(null, null);
  ValidacioItem _nombre = ValidacioItem(null, null);
  ValidacioItem _primerApellido = ValidacioItem(null, null);
  ValidacioItem _segundoApellido = ValidacioItem(null, null);
  ValidacioItem _correo = ValidacioItem(null, null);
  ValidacioItem _telefono = ValidacioItem(null, null);
  ValidacioItem _direccion = ValidacioItem(null, null);





  //getters
  ValidacioItem get usuario => _usuario;
  ValidacioItem get contrasenia => _contrasenia;
  ValidacioItem get validarcontrasenia => _validarcontrasenia;
  ValidacioItem get nombre => _nombre;
  ValidacioItem get primerApellido => _primerApellido;
  ValidacioItem get segundoApellido => _segundoApellido;
  ValidacioItem get correo => _correo;
  ValidacioItem get telefono => _telefono;
  ValidacioItem get direccion => _direccion;




  bool get loginValido {
    if (_usuario.value != null && _contrasenia.value != null){
      return true;
    } else {
      return false;
    }
  }

    bool get registroValido {
    if (_usuario.value != null 
    && _contrasenia.value != null
    && _validarcontrasenia.value != null
    && _nombre.value != null
    && _primerApellido.value != null
    && _segundoApellido.value != null
    && _correo.value != null
    && _telefono.value != null
    && _direccion.value != null
    ){
      return true;
    } else {
      return false;
    }
  }


  //setters
  void cambiarUsuario(String value){
  if (value.length >= 3){
    _usuario=ValidacioItem(value,null);
  } else {
    _usuario=ValidacioItem(null, "El usuario debe ser al menos 3 dígitos");
  }
  notifyListeners();
  }

  void cambiarContrasenia(String value){
  if (value.length >= 6){
    _contrasenia=ValidacioItem(value,null);
  } else {
    _contrasenia=ValidacioItem(null, "La contraseña debe ser al menos 6 dígitos");
  }
  notifyListeners();
  }

  void cambiarConfirmarcontrasenia(String value){
  if (value.length >= 6){
    if(_contrasenia.value != value){
        _validarcontrasenia = ValidacioItem(null, 'Las contraseñas no coinciden');
    }
    else   
        {
        _validarcontrasenia = ValidacioItem(value, null);
    }
  } else {
    _validarcontrasenia=ValidacioItem(null, "La contraseña debe ser al menos 6 dígitos");
  }
  notifyListeners();
  }

  void cambiarNombre(String value){
  if (value.length >= 3){
    _nombre=ValidacioItem(value,null);
  } else {
    _nombre=ValidacioItem(null, "El nombre debe ser al menos 3 dígitos");
  }
  notifyListeners();
  }

  void cambiarPrimerApellido(String value){
  if (value.length >= 3){
    _primerApellido=ValidacioItem(value,null);
  } else {
    _primerApellido=ValidacioItem(null, "EL Primer Apellido debe ser al menos 3 dígitos");
  }
  notifyListeners();
  }

  void cambiarSegundoApellido(String value){
  if (value.length >= 3){
    _segundoApellido=ValidacioItem(value,null);
  } else {
    _segundoApellido=ValidacioItem(null, "El Segundo Apellido debe ser al menos 3 dígitos");
  }
  notifyListeners();
  }


  void cambiarCorreo(String value){
  if (value.length >= 3){
    _correo=ValidacioItem(value,null);
  } else {
    _correo=ValidacioItem(null, "El correo debe ser al menos 3 dígitos");
  }
  notifyListeners();
  }

  void cambiarTelefono(String value){
  if (value.length >= 8){
    _telefono=ValidacioItem(value,null);
  } else {
    _telefono=ValidacioItem(null, "El teléfono debe ser al menos 8 dígitos");
  }
  notifyListeners();
  }

    void cambiarDireccion(String value){
  if (value.length >= 10){
    _direccion=ValidacioItem(value,null);
  } else {
    _direccion=ValidacioItem(null, "La dirección debe ser al menos 10 dígitos");
  }
  notifyListeners();
  }
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




  Future<Map<String, dynamic>> login( ) async {
    

   final autData = {
     'CodUsuario' : this.usuario.value,
     'Contrasenia': this.contrasenia.value,
     //'returnSecureToken' : true
   };

 final url = Utilitarios().urlWebapi + 'Autenticar/AutenticarUsuario';
 final datos = json.encode( autData );


   final resp = await http.post(
      url,
      body: datos
      ,headers: Utilitarios().header
   );

   Map<String, dynamic> decodeResp = json.decode(resp.body);

   return decodeResp;
  }


 Future<Map<String, dynamic>> registrarUsuario( ) async {


  final autData = {
      'CodUsuario': this.usuario.value,
      'Contrasenia': this.contrasenia.value,
      'Nombre': this.nombre.value,
      'PrimerApellido': this.primerApellido.value,
      'SegundoApelldo': this.segundoApellido.value,
      'Telefono': this.telefono.value,
      'Direccion': this.direccion.value,
      'Email': this.correo.value
  };


  final url = Utilitarios().urlWebapi + 'Usuario/InsertarUsuario';
  final datos = json.encode( autData );


   final resp = await http.post(
      url,
      body: datos
      ,headers: Utilitarios().header
   );

   Map<String, dynamic> decodeResp = json.decode(resp.body);

  return decodeResp;
 }

}