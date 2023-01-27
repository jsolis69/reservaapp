import 'package:flutter/material.dart';



class NotificacionModel with ChangeNotifier{
  bool _mostrarAlerta = false;
  int _codigo = 0; 
  String _descripcion = '';


  bool get mostrarAlerta => _mostrarAlerta;
  int get codigo => _codigo;
  String get descripcion => _descripcion;

  set mostrarAlerta(bool valor){
    _mostrarAlerta = valor;
    notifyListeners();
  }

  set codigo(int valor){
    _codigo = valor;
    notifyListeners();
  }

  set descripcion(String valor){
    _descripcion = valor;
    notifyListeners();
  }
}