import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:reservaapp/blocs/provider.dart';
//import 'package:reservaapp/blocs/validator.dart';
//import 'package:reservaapp/providers/usuario_provider.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/usuario_provider.dart';

class RegistroPage extends StatefulWidget {
 // const RegistroPage({Key? key}) : super(key: key);



  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

    // final usuarioprovider = new UsuarioProvider();

   int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          fondo(),
          obtenerPantalla(context, _selectedIndex)
          //_widgetOptions.elementAt(_selectedIndex),
          //_formulario(context)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.personBooth),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.facebook),
            label: 'Facebook',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.instagram),
            label: 'Instagram',
          ),
          //BottomNavigationBarItem(
          //  icon: FaIcon(FontAwesomeIcons.google),
          //  label: 'Google',
          //),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget obtenerPantalla(BuildContext context, int index){
    if(index == 0)
    {
     return  _formulario(context);
    }
    else if(index == 1){
      return Text(
      'Login Google',
      style: optionStyle,
    );
    }
    else{
      return Text(
      'Login facebook',
      style: optionStyle,
    );
    }

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  Widget _formulario(BuildContext context) {
    //final bloc = Provider.registroBloc(context);
    final size = MediaQuery.of(context).size;

    //final estiloTextos = TextStyle(color:  Color(0xff008000), fontSize: 20.0);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 10.0,
            ),
          ),
          Container(
            width: size.width * 0.90,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric( vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff008000),
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.0),
                  spreadRadius: 3.0 
                )
              ]
            ),
            child: Column(
              children: [
                crearTitulo('Registro', 20.0),
                SizedBox(height: 30.0),
               _crearUsuario('Usuario','Digíte su usuario', Icons.account_box, false),
               SizedBox(height: 20.0),
               _crearContrasenia('Contraseña', 'Digíte la contraseña', Icons.lock_open, true),
               SizedBox(height: 20.0),
              _crearConfirmarContrasenia('Validar contraseña', 'Vuelva a digitar la contraseña'),
               SizedBox(height: 20.0),
               _crearNombre('Nombre', 'Digíte el nombre', Icons.lock_open, false),
               SizedBox(height: 20.0),
               _crearPrimerApellido('Primer apellido', 'Digíte el primer apellido', Icons.lock_open, false),
               SizedBox(height: 20.0),
               _crearSegundoApellido('Segundo apellido', 'Digíte el segundo apellido', Icons.lock_open, false),
               SizedBox(height: 20.0),
               _crearCorreo('Correo electrónico', 'Digíte el correo', Icons.lock_open, false),
               SizedBox(height: 20.0),
               _crearTelefono('Teléfono', 'Digíte el segundo teléfono', Icons.lock_open, false),
               SizedBox(height: 20.0),
               _crearDireccion('Dirección exacta', 'Digíte la dirección exacta', Icons.lock_open),
               SizedBox(height: 20.0),
               _crearBoton(),
              ],
            ),
          ),
          TextButton(
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'Login'), 
            child: Text('Ya tienes cuenta? Login')//, style: estiloTextos)
          ),
        ],
      )
    );
  }

  Widget _crearContrasenia(String label, String textoAyuda, IconData icono, bool esContrasena) {
      final usuarioprovider = Provider.of<UsuarioProvider>(context);
    return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
         hintText: textoAyuda,
         labelText: label,
          //suffixIcon: Validadores().asignarIcono(snapshot.error),
          errorText: usuarioprovider.contrasenia.error,
        ),
        onChanged: (value){
        usuarioprovider.cambiarContrasenia(value);
      }//bloc.cambiarUsuario,
      )
    );  
  }

  Widget _crearConfirmarContrasenia(String label, String textoAyuda) {
     
     final usuarioprovider = Provider.of<UsuarioProvider>(context);
    return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
         hintText: textoAyuda,
         labelText: label,
          //suffixIcon: Validadores().asignarIcono(snapshot.error),
         errorText: usuarioprovider.validarcontrasenia.error,
        ),
        onChanged: (value){
        usuarioprovider.cambiarConfirmarcontrasenia(value);
      }//bloc.cambiarUsuario,
      )
    ); 
  }

  Widget _crearUsuario(String label, String textoAyuda, IconData icono, bool esContrasena) {
 
    final usuarioprovider = Provider.of<UsuarioProvider>(context);

     return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: textoAyuda,
            labelText: label,
            //helperText: 'Sólo es el nombre',
            //suffixIcon: Validadores().asignarIcono(snapshot.error),
            errorText: usuarioprovider.usuario.error
          ),
         onChanged: (value){
        usuarioprovider.cambiarUsuario(value);
      }//bloc.cambiarUsuario,
    )
    );
  }

  Widget _crearNombre(String label, String textoAyuda, IconData icono, bool esContrasena) {
 
  final usuarioprovider = Provider.of<UsuarioProvider>(context);

     return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: textoAyuda,
            labelText: label,
            //helperText: 'Sólo es el nombre',
            //suffixIcon: Validadores().asignarIcono(snapshot.error),
            errorText: usuarioprovider.nombre.error,
          ),
      onChanged: (value){
        usuarioprovider.cambiarNombre(value);
      }
    )
    );
  }

  Widget _crearPrimerApellido(String label, String textoAyuda, IconData icono, bool esContrasena) {
 

    final usuarioprovider = Provider.of<UsuarioProvider>(context);
     return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: textoAyuda,
            labelText: label,
            //helperText: 'Sólo es el nombre',
           // suffixIcon: Validadores().asignarIcono(snapshot.error),
           errorText: usuarioprovider.primerApellido.error,
          ),
      onChanged: (value){
        usuarioprovider.cambiarPrimerApellido(value);
      }
    )
    );
  }

  Widget _crearSegundoApellido(String label, String textoAyuda, IconData icono, bool esContrasena) {
 
     final usuarioprovider = Provider.of<UsuarioProvider>(context);
     return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: textoAyuda,
            labelText: label,
            //helperText: 'Sólo es el nombre',
            //suffixIcon: Validadores().asignarIcono(snapshot.error),
            errorText: usuarioprovider.segundoApellido.error,
          ),
      onChanged: (value){
        usuarioprovider.cambiarSegundoApellido(value);
      }
    )
    );
  }

  Widget _crearTelefono(String label, String textoAyuda, IconData icono, bool esContrasena) {
 
     final usuarioprovider = Provider.of<UsuarioProvider>(context);
     return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: textoAyuda,
            labelText: label,
            //helperText: 'Sólo es el nombre',
            //suffixIcon: Validadores().asignarIcono(snapshot.error),
            errorText: usuarioprovider.telefono.error,
          ),
      onChanged: (value){
        usuarioprovider.cambiarTelefono(value);
      }
    )
    );
  }

  Widget _crearCorreo(String label, String textoAyuda, IconData icono, bool esContrasena) {
 
     final usuarioprovider = Provider.of<UsuarioProvider>(context);
     return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: textoAyuda,
            labelText: label,
            //helperText: 'Sólo es el nombre',
            //suffixIcon: Validadores().asignarIcono(snapshot.error),
            errorText: usuarioprovider.correo.error,
          ),
      onChanged: (value){
        usuarioprovider.cambiarCorreo(value);
      }
    )
    );
  }

  Widget _crearDireccion(String label, String textoAyuda, IconData icono) {
    
    final usuarioprovider = Provider.of<UsuarioProvider>(context);
     return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0),
      child: TextField(
        maxLines: 3,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: textoAyuda,
        labelText: label,
        //helperText: 'Sólo es el nombre',
        //suffixIcon: Validadores().asignarIcono(snapshot.error),
        errorText: usuarioprovider.direccion.error,
        //icon: Icon( Icons.account_box )
      ),
      onChanged: (value){
        usuarioprovider.cambiarDireccion(value);
      }
    )
    );
  }

  Widget _crearBoton( ) {
    
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
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(234, 101, 57, 1.0))),
      onPressed: (!usuarioprovider.registroValido ? null : usuarioprovider.registrarUsuario),
    );
     
  }

   //_registro(RegistroBloc bloc, BuildContext context) async {
//
   // final respuesta = await usuarioprovider.registrarUsuario(bloc);
   // if(respuesta['ok']){
   //  Navigator.pushReplacementNamed(context, 'Inicio');
   // }
   // else{
   //  mostrarAlerta(context, respuesta['mensaje']);
   // }
//
   // }
}
