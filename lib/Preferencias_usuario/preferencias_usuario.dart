import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

 static late SharedPreferences _prefs;

  static bool _esModoOscuro = true;
  static bool _esPropietario = false;

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

 static set esModoOscuro( bool value ) {
  _esModoOscuro = value;
   _prefs.setBool('EsModoOscuro', value);
 }

   static set esPropietario(bool value){
    _esPropietario = value;
    _prefs.setBool('EsPropietario', value);
  }
}
