import 'package:flutter/material.dart';


class TemaServicio with ChangeNotifier {

  
  ThemeData temaActual;

  TemaServicio({
    required bool esModoOscuro
  }) : 
  temaActual = esModoOscuro 
                    ? ThemeData.dark().copyWith(
                      colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: Colors.blueAccent, primary: Colors.black), 
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