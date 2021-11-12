import 'package:flutter/material.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';


class ThemeChanger with ChangeNotifier {

  
  final prefs = PreferenciasUsuario();

  ThemeChanger(int modo)
  {
    prefs.modoAplicacion = modo;
    if(modo == 1){
      _modoOscuro = false;
      _temaActual = ThemeData.light();
    }
      
    else if( modo == 2)
    {
      _modoOscuro = true;
      _temaActual = ThemeData.dark();
    }
    else{
      _modoOscuro = false;
      _temaActual = ThemeData.light();
    }
      

  }

  bool _modoOscuro = false;

  ThemeData _temaActual; 

  bool get modoOscuro => this._modoOscuro;

  set modoOscuro(bool value){
    _modoOscuro = value;

    prefs.modoAplicacion = value ? 2 : 1;

    if(value){
      _temaActual = ThemeData.dark();
    }
    else{
      _temaActual = ThemeData.light();
    }

    notifyListeners();
  }

  ThemeData get temaActual => this._temaActual;



  //ThemeData _themeData;
//
  //ThemeChanger( this._themeData );
//
  //getTheme() => _themeData;
//
  //setTheme(ThemeData theme){
//
  //  this._themeData = theme;
  //  notifyListeners();
//
  //}

}