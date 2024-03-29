import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:reservaapp/models/usuario_model.dart';

class UsuarioProvider with ChangeNotifier{

  String _usuario = '';
  int   _idUsuario = 0;
  String _contrasenia = '';
  String _validarcontrasenia = '';
  String _nombre = '';
  String _correo = '';
  String _telefono = '';
  bool _permiteNotificar = false;
  //ValidacioItem _direccion = ValidacioItem(null, null);

  //getters
  int    get idUsuario => _idUsuario;
  String get usuario => _usuario;
  String get contrasenia => _contrasenia;
  String get validarcontrasenia => _validarcontrasenia;
  String get nombre => _nombre;
  String get correo => _correo;
  String get telefono => _telefono;
  bool get permiteNotificar => _permiteNotificar;
  bool get loginValido {
    if (_usuario.isNotEmpty || _contrasenia.isNotEmpty){
      return true;
    } else {
      return false;
    }
  }

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
  set idUsuario(int value){
    _idUsuario = value;
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
      'Contrasenia': this.contrasenia
    };

    var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Autenticar/AutenticarUsuario');
    final datos = json.encode( autData );
    final resp = await http.post(
      url,
      body: datos,
      headers: Utilitarios().header
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
      body: datos,
      headers: Utilitarios().header
    );

    if(resp.statusCode == 200)
    {
      UsuarioResponse autenticar = usuarioResponseFromJson(resp.body);
      return autenticar;
    }
    else{
      throw Exception('Ocurrió un error al autenticar.');
    }
  }
  Future<UsuarioResponse> actualizarUsuario( ) async {
    final autData = {
      'IdUsuario': this.idUsuario,
      'Contrasenia': this.contrasenia,
      'Nombre': this.nombre,
      'Telefono': this.telefono,
      'Email': this.correo,
      'PermiteNotificar': this.permiteNotificar
    };
    var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Usuario/ActualizarUsuario');
    final datos = json.encode( autData );
    final resp = await http.post(
      url,
      body: datos,
      headers: Utilitarios().header
    );

    if(resp.statusCode == 200)
    {
      UsuarioResponse autenticar = usuarioResponseFromJson(resp.body);
      return autenticar;
   }
   else{
    throw Exception('Ocurrió un error al autenticar.');
   }
  } 
  Future<UsuarioResponse> obtenerUsuario( ) async {
    final autData = {
      'IdUsuario': this.idUsuario,
      'Contrasenia': this.contrasenia,
      'Nombre': this.nombre,
      'Telefono': this.telefono,
      'Email': this.correo,
      'PermiteNotificar': this.permiteNotificar
    };
    var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Usuario/ObtenerUsuario');
    final datos = json.encode( autData );
    final resp = await http.post(
      url,
      body: datos,
      headers: Utilitarios().header
    );

    if(resp.statusCode == 200)
    {
      UsuarioResponse autenticar = usuarioResponseFromJson(resp.body);
      return autenticar;
    }
    else{
      throw Exception('Ocurrió un error al autenticar.');
    }
  }
}