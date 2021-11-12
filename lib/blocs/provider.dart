
import 'package:flutter/material.dart';
import 'package:reservaapp/blocs/registro_bloc.dart';

import 'login_bloc.dart';
export 'package:reservaapp/blocs/login_bloc.dart';
export 'package:reservaapp/blocs/registro_bloc.dart';
export 'package:reservaapp/blocs/theme.dart';

class Provider extends InheritedWidget{


  final _loginBloc = new LoginBloc();
  final _registroBloc = new RegistroBloc();
  //final _themeBloc = ThemeChanger(ThemeData.dark());

  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);

    }
    return _instancia;
  }
  Provider._internal({Key key, Widget child})
  : super(key: key, child: child);

  //Provider({Key key, Widget child})
  //: super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static RegistroBloc registroBloc (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._registroBloc;
  }

}


//class ChangeNotifierProvider extends  InheritedWidget{
//
//    static ChangeNotifierProvider _instancia;
//  factory ChangeNotifierProvider({Key key, Widget child}){
//    
//    if(_instancia == null){
//      _instancia = new ChangeNotifierProvider._internal(key: key, child: child);
//
//    }
//    return _instancia;
//  }
//  ChangeNotifierProvider._internal({Key key, Widget child})
//  : super(key: key, child: child);
//
//  @override
//  bool updateShouldNotify(InheritedWidget oldWidget) => true;
//
//}
