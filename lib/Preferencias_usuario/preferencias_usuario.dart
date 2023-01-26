import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

 static late SharedPreferences _prefs;

  static bool _esModoOscuro = true;
  static bool _esPropietario = false;
  static int _usuarioLogueado = -1;

 static Future init() async {
   _prefs = await SharedPreferences.getInstance();
 }

 // GET y SET del token
 static bool get esModoOscuro {
   return _prefs.getBool('EsModoOscuro') ?? _esModoOscuro;
 }
  static bool get esPropietario{
    return _prefs.getBool('EsPropietario') ?? _esPropietario;
  }
   static int get usuarioLogueado{
    return _prefs.getInt('UsuarioLogueado') ?? _usuarioLogueado;
  }

 static set esModoOscuro( bool value ) {
  _esModoOscuro = value;
   _prefs.setBool('EsModoOscuro', value);
 }

   static set esPropietario(bool value){
    _esPropietario = value;
    _prefs.setBool('EsPropietario', value);
  }

  static set usuarioLogueado(int value){
    _usuarioLogueado = value;
    _prefs.setInt('UsuarioLogueado', value);
  }
}
