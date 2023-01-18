import 'dart:async';

import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validadores{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // recuperar daros del stream
 Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
 Stream<String> get passwordStream => _passwordController.stream.transform(validarContrasenia);

 Stream<bool> get formValidStram => Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  //InsertarValores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController.close();
    _passwordController.close();
  }


}