import 'package:flutter/material.dart';


class ThemeChanger with ChangeNotifier {

  
  ThemeData temaActual;

  ThemeChanger({
    required bool esModoOscuro
  }) : 
  temaActual = esModoOscuro 
                    ? ThemeData.dark().copyWith(
                      colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: Colors.blueAccent, primary: Colors.black), 
                      //inputDecorationTheme: const InputDecorationTheme(prefixIconColor: Colors.black26)
                      ) 
                    : ThemeData.light().copyWith(
                      colorScheme: ThemeData.light().colorScheme.copyWith(secondary: Colors.red)) ;


  setModoClaro(){
    temaActual = ThemeData.light().copyWith(colorScheme: ThemeData.light().colorScheme.copyWith(secondary: Colors.red)) ;
    notifyListeners();
  }


  setModoOscuro(){
    temaActual = ThemeData.dark().copyWith(colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: Colors.blueAccent, primary: Colors.black54));
    notifyListeners();
  }

}