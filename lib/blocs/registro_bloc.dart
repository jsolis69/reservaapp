

import 'package:reservaapp/blocs/validator.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc with Validadores{

  
  //final _idUsuarioController              = BehaviorSubject<String>();
  final _nombreController                 = BehaviorSubject<String>();
  final _primerApellidoController         = BehaviorSubject<String>();
  final _segundoApellidoController        = BehaviorSubject<String>();
  final _correoController                 = BehaviorSubject<String>();
  final _telefonoController               = BehaviorSubject<String>();
  final _direccionController              = BehaviorSubject<String>();
  //final _idEstadoController               = BehaviorSubject<String>();
  final _usuarioController                = BehaviorSubject<String>();
  final _contraseniaController            = BehaviorSubject<String>();
  final _confirmarContraseniaController   = BehaviorSubject<String>();

    // recuperar daros del stream
 //Stream<String> get idUsuarioStream => _idUsuarioController.stream;
 Stream<String> get nombreStream => _nombreController.stream.transform(validarNombre);
 Stream<String> get primerApellidoStream => _primerApellidoController.stream.transform(validarPrimerApellido);
 Stream<String> get segundoApellidoStream => _segundoApellidoController.stream.transform(validarSegundoApellido);
 Stream<String> get correoStream => _correoController.stream.transform(validarEmail);
 Stream<String> get telefonoStream => _telefonoController.stream.transform(validarTelefono);
 Stream<String> get direccionStream => _direccionController.stream.transform(validarDireccion);
 //Stream<String> get idEstadoStream => _idEstadoController.stream;//.transform();
 Stream<String> get usuarioStream => _usuarioController.stream.transform(validarUsuario);
 Stream<String> get contraseniaStream => _contraseniaController.stream.transform(validarContrasenia)  .doOnData((String c){
      print(c);
      // If the password is accepted (after validation of the rules)
      // we need to ensure both password and retyped password match
      if (0 != _confirmarContraseniaController.value.compareTo(c)){
      // If they do not match, add an error
      _contraseniaController.addError("Las contraseñas deben ser iguales");
      //_confirmarContraseniaController.addError("Las contraseñas deben ser iguales");
    }
    //else
    //{
    //  _contraseniaController.add(c);
    //  _confirmarContraseniaController.add(_confirmarContraseniaController.value);
    //  
    //}
  });
 Stream<String> get confirmarContraseniaStream => _confirmarContraseniaController.stream.transform(validarConfirmarContrasenia)
  .doOnData((String c){
      print(c);
      // If the password is accepted (after validation of the rules)
      // we need to ensure both password and retyped password match
      if (0 != _contraseniaController.value.compareTo(c)){
      // If they do not match, add an error
      _confirmarContraseniaController.addError("Las contraseñas deben ser iguales");
      //_contraseniaController.addError("Las contraseñas deben ser iguales");
    }
    //else
    //{
    //  _confirmarContraseniaController.add(c);
     //_contraseniaController.add(_contraseniaController.value);
    //  
    //}
    //else{
    //  _confirmarContraseniaController.addError('ok');
    //}
  });

 Stream<bool> get formValidStram => Rx.combineLatest9(
   correoStream, 
   telefonoStream, 
   segundoApellidoStream, 
   correoStream, 
   telefonoStream, 
   direccionStream, 
   usuarioStream, 
   contraseniaStream, 
   confirmarContraseniaStream, 
   (a, b, c, d, e, f, g, h, i) => true);


  //InsertarValores al stream
  Function(String) get cambiarNombre => _nombreController.sink.add;
  Function(String) get cambiarPrimerApellido => _primerApellidoController.sink.add;
  Function(String) get cambiarSegundoApellido => _segundoApellidoController.sink.add;
  Function(String) get cambiarCorreo => _correoController.sink.add;
  Function(String) get cambiarTelefono => _telefonoController.sink.add;
  Function(String) get cambiarDireccion => _direccionController.sink.add;
  Function(String) get cambiarUsuario => _usuarioController.sink.add;
  Function(String) get cambiarContrasenia => _contraseniaController.sink.add;
  Function(String) get cambiarConfirmarContrasenia => _confirmarContraseniaController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  String get nombre => _nombreController.value;
  String get primerApellido => _primerApellidoController.value;
  String get segundoApellido => _segundoApellidoController.value;
  String get correo => _correoController.value;
  String get telefono => _telefonoController.value;
  String get direccion => _direccionController.value;
  String get usuario => _usuarioController.value;
  String get contrasenia => _contraseniaController.value;
  String get confirmarContrasenia => _confirmarContraseniaController.value;

  dispose(){
    //_idUsuarioController.close();       
    _nombreController.close();           
    _primerApellidoController.close(); 
    _segundoApellidoController.close();  
    _correoController.close();            
    _contraseniaController.close(); 
    _confirmarContraseniaController.close(); 
    _telefonoController.close();         
    _direccionController.close();        
    //_idEstadoController.close();         
    _usuarioController.close(); 
  }
}