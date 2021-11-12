
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/usuario_provider.dart';
import 'package:reservaapp/utils/utils.dart';


class LoginPage extends StatelessWidget {

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('hola'),
      //),
      body: SingleChildScrollView(
          child: Column(
            children: [
              _logo(),
              crearTitulo('Ingresar a tu cuenta', 30.0),
              SizedBox(height: 30.0),
              _crearUsuario(context),
              SizedBox(height: 20.0),
              _crearContrasenia(context),
              SizedBox(height: 20.0),
              _crearBoton(context),
              SizedBox(height: 20.0),
              _crearBotonesLogin(),
              SizedBox(height: 20.0),
        
        
              TextButton(
              onPressed: ()=> Navigator.pushReplacementNamed(context, 'Sucursales'), 
              child: Text('Entrar')),//, style: estiloTextos)
        
        
              //Expanded(
                //child: 
                TextButton(
                onPressed: ()=> Navigator.pushReplacementNamed(context, 'Registro'), 
                
                child: crearTitulo('Registrarse', 20.0)
                          ),
              //),
            ],
          ),

      )
      
      //Stack(
      //  children: <Widget>[
      //    _colorFondo(),
      //    _imagenFondo(),
      //    _titulos(context)
      //],
      //),
    );
  }


  Widget _logo() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40.0),
    child: Container(
      width: double.infinity,
      height: 80,
      //color: Colors.red,
      child: Image(
        image: AssetImage('assets/img/Logo.jpg')),
      ),
  );
  }



// Widget _colorFondo() {
// return Container(
//   width: double.infinity,
//   height: double.infinity,
//   color: Colors.white,
//   );
// }
//
// Widget _imagenFondo() {
// return Container(
//   width: double.infinity,
//   height: double.infinity,
//   child: Image(
//     image: AssetImage('assets/img/fondo.jpg'),
//     fit: BoxFit.cover,
//     ),
// );
//
// }
//
// Widget _titulos(BuildContext context) {
//
//   //final estiloTextos = TextStyle(color: Colors.white, fontSize: 50.0);
//
//   return SafeArea(
//     child: SingleChildScrollView(
//         child: Column(
//         children: <Widget>[          
//           SafeArea(
//           child: Container(
//             height: 40.0,
//           ),
//           ),
//           crearTitulo('Reservas', 50.0),
//           crearTitulo('Bienvenidos', 50.0),
//           _ventanasSession(context),
//           
//         ],
//       ),
//     ),
//   );
//
// }
//
// Widget _ventanasSession(BuildContext context) {
//   //final bloc = Provider.of(context);
//   final size = MediaQuery.of(context).size;
//
//   //final estiloTextos = TextStyle(color: Colors.white, fontSize: 20.0);
//
//   return SingleChildScrollView(
//     child: Column(
//       children: <Widget>[
//         Container(
//           width: size.width * 0.85,
//           padding: EdgeInsets.symmetric(vertical: 50.0),
//           margin: EdgeInsets.symmetric( vertical: 30.0),
//           decoration: BoxDecoration(
//             color:  Colors.white,
//             borderRadius: BorderRadius.circular(5.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0xff008000),
//                 blurRadius: 3.0,
//                 offset: Offset(0.0, 0.0),
//                 spreadRadius: 3.0 
//               )
//             ]
//           ),
//           child: Column(
//             children: [
//                crearTitulo('Iniciar Sesión', 20.0),
//               SizedBox(height: 30.0),
//               _crearTexto('Usuario','Digíte su usuario', Icons.account_box, false),
//               SizedBox(height: 20.0),
//               _crearTexto('Contraseña', 'Digíte la contraseña', Icons.lock_open, true),
//               SizedBox(height: 20.0),
//               _crearBoton(),
//               SizedBox(height: 20.0),
//               _crearBotonesLogin(),
//               SizedBox(height: 20.0),
//
//
//
//                    TextButton(
//           onPressed: ()=> Navigator.pushReplacementNamed(context, 'Sucursales'), 
//           child: Text('Entrar')//, style: estiloTextos)
//         ),
//
//
//             ],
//           ),
//         ),
//         TextButton(
//           onPressed: ()=> Navigator.pushReplacementNamed(context, 'Registro'), 
//           
//           child: crearTitulo('Registrarse', 20.0)
//         ),
//       ],
//     )
//   );
// }



  Widget _crearContrasenia(BuildContext context) {
    

    final usuarioprovider = Provider.of<UsuarioProvider>(context);

    return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
         hintText: 'Digíte la contraseña',
         labelText: 'Contraseña',
         errorText: usuarioprovider.contrasenia.error,
         suffixIcon: Icon( Icons.lock_open ),
         //counterText: snapshot.data,
         //errorText: snapshot.error
        ),
        onChanged: (value){
          usuarioprovider.cambiarContrasenia(value);
      }//bloc.changeEmail,
      )
    );   
    


  }
    Widget _crearUsuario(BuildContext context) {

    final usuarioprovider = Provider.of<UsuarioProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0),
      child: TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Digíte su usuario',
        labelText: 'Usuario',
        errorText: usuarioprovider.usuario.error,
         suffixIcon: Icon( Icons.account_box ),
        //errorText: snapshot.error
        //icon: Icon( Icons.account_box )
      ),
      onChanged: (value){
        usuarioprovider.cambiarUsuario(value);
      }//bloc.changeEmail,
        )
    );
    

  }

  Widget _crearBoton(BuildContext context) {


    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: false);
    return ElevatedButton(
       child: Container(
         padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
         child: crearTitulo('Ingresar', 15.0),
         
      ),
      //shape: RoundedRectangleBorder(
      //  borderRadius: BorderRadius.circular(5.0)
      //),
      //elevation: 0.0,
      //color: Color.fromRGBO(234, 101, 57, 1.0),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),
      onPressed: () {

        if(usuarioprovider.loginValido)
        {
            usuarioprovider.login().then((resp){ 
                if(resp['CodigoRespuesta'] == 0){
                  Navigator.pushReplacementNamed(context, 'Sucursales');
                }
                else{
                  mostrarAlerta(context, resp['DescripcionRespuesta']);
                }



            }
            );
            
          }
      }
  
    );}
  
    Widget _crearBotonesLogin( ) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: FaIcon(FontAwesomeIcons.facebook), onPressed: (){}),
          IconButton(icon: FaIcon(FontAwesomeIcons.instagram), onPressed: (){})
          //IconButton(icon: FaIcon(FontAwesomeIcons.facebook), onPressed: (){})
        ],
      );
  }
  _login(BuildContext context) {

    final usuarioprovider = Provider.of<UsuarioProvider>(context, listen: false);

    var prueba = usuarioprovider.login;

    var a = '';
    //if(respuesta['ok']){
    //  Navigator.pushReplacementNamed(context, 'Inicio');
    //}
    //else{
    //  mostrarAlerta(context, respuesta['mensaje']);
    //}
  }
}