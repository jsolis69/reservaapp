

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Validadores{

final validarContrasenia = StreamTransformer<String, String>.fromHandlers(
  handleData: (password, sink) {
    if(password.length <= 0)
    {
      sink.addError('La contraseña es requerida');
    }
    else
    {
      if(password.length >=6){
        //sink.addError('ok');
        sink.add(password);
      }
      else{
        sink.addError('La contraseña debe ser más grande');
      }
    }
    
  }
);

final validarConfirmarContrasenia = StreamTransformer<String, String>.fromHandlers(
  handleData: (password, sink) {
    if(password.length <= 0)
    {
      sink.addError('La contraseña es requerida');
    }
    else
    {
      if(password.length >=6){
        //sink.addError('ok');
        sink.add(password);
      }
      else{
        sink.addError('La contraseña debe ser más grande');
      }
    }
    
  }
);

final validarEmail = StreamTransformer<String, String>.fromHandlers(
  handleData: (email, sink) {

    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern);

    if(regExp.hasMatch(email)){
      //sink.addError('ok');
      sink.add(email);
    }
    else
    {
      sink.addError('El usuario no es correcto');
    }
    
  }
);

final validarNombre = StreamTransformer<String, String>.fromHandlers(
handleData: (nombre, sink){
  if(nombre.length <= 0)
    {
      sink.addError('La contraseña es requerida');
    }
    else
    {
      if(nombre.length >=2){
        //sink.addError('ok');
        sink.add(nombre);
      }
      else{
        sink.addError('La contraseña debe ser más grande');
      }
    } 
  
}

);

final validarPrimerApellido = StreamTransformer<String, String>.fromHandlers(
handleData: (nombre, sink){
  if(nombre.length <= 0)
    {
      sink.addError('La contraseña es requerida');
    }
    else
    {
      if(nombre.length >=2){
        //sink.addError('ok');
        sink.add(nombre);
      }
      else{
        sink.addError('La contraseña debe ser más grande');
      }
    } 
  
}

);

final validarSegundoApellido = StreamTransformer<String, String>.fromHandlers(
handleData: (nombre, sink){
  if(nombre.length <= 0)
    {
      sink.addError('La contraseña es requerida');
    }
    else
    {
      if(nombre.length >=2){
        //sink.addError('ok');
        sink.add(nombre);
      }
      else{
        sink.addError('La contraseña debe ser más grande');
      }
    } 
  
}

);

final validarDireccion = StreamTransformer<String, String>.fromHandlers(
handleData: (nombre, sink){
  if(nombre.length <= 0)
    {
      sink.addError('La contraseña es requerida');
    }
    else
    {
      if(nombre.length >=2){
        //sink.addError('ok');
        sink.add(nombre);
      }
      else{
        sink.addError('La contraseña debe ser más grande');
      }
    } 
  
}

);

final validarUsuario = StreamTransformer<String, String>.fromHandlers(
handleData: (nombre, sink){
  if(nombre.length <= 0)
    {
      sink.addError('La contraseña es requerida');
    }
    else
    {
      if(nombre.length >=2){
        //sink.addError('ok');
        sink.add(nombre);
      }
      else{
        sink.addError('La contraseña debe ser más grande');
      }
    } 
  
}

);

final validarTelefono = StreamTransformer<String, String>.fromHandlers(
  handleData: (telefono, sink) {

    Pattern pattern = r'[0-9]{8}';

    RegExp regExp = new RegExp(pattern);

    if(regExp.hasMatch(telefono)){
      //sink.addError('ok');
      sink.add(telefono);
    }
    else
    {
      sink.addError('El teléfono no es correcto');
    }
    
  }
);


 Widget asignarIcono(Object validar){

return validar == null? null : validar == 'ok'? Icon( Icons.done_rounded, color: Colors.green ) : Icon( Icons.close_rounded, color: Colors.red, );
}

 Object asignarError(Object validar){

return validar == 'ok'? null : validar;
}


//final validarTelefono = StreamTransformer<Dynamic, Dynamic>


}

