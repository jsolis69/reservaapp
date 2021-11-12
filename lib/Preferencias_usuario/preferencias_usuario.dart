import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

 static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

 factory PreferenciasUsuario() {
   return _instancia;
 }

 PreferenciasUsuario._internal();

  SharedPreferences _prefs;

 initPrefs() async {
   this._prefs = await SharedPreferences.getInstance();
 }

 // GET y SET del token
 int get modoAplicacion {
   return _prefs.getInt('modoAplicacion') ?? 1;
 }

 set modoAplicacion( int value ) {
   _prefs.setInt('modoAplicacion', value);
 }


// void cerrarSesion(){
//   this._prefs.clear();
// }

 // GET y SET del token
 //get token {
 //  return _prefs.getString('token') ?? '';
 //}

 //set token( String value ) {
 //  _prefs.setString('token', value);
 //}
   // GET y SET del token
 //get tokenExpira {
 //  return _prefs.getString('tokenExpira') ?? '';
 //}

 //set tokenExpira( String value ) {
 //  _prefs.setString('tokenExpira', value);
 //}
 

 // GET y SET de la última página
 //get ultimaPagina {
 //  return _prefs.getString('ultimaPagina') ?? 'login';
 //}

 //set ultimaPagina( String value ) {
 //  _prefs.setString('ultimaPagina', value);
 //}

}
