//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
//import 'package:reservaapp/blocs/provider.dart';
//import 'package:provider/provider.dart';
//import 'package:reservaapp/blocs/provider.dart';
import 'package:reservaapp/paginas/Anfitrion/menuAnfitron_page.dart';
import 'package:reservaapp/paginas/Anfitrion/misSucursales_page.dart';
import 'package:reservaapp/paginas/ayuda_page.dart';
import 'package:reservaapp/paginas/comentarios_page.dart';
import 'package:reservaapp/paginas/configuracion_page.dart';
//import 'package:reservaapp/blocs/theme.dart';
import 'package:reservaapp/paginas/login_page.dart';
import 'package:reservaapp/paginas/menu_page.dart';
import 'package:reservaapp/paginas/miPerfil_page.dart';
import 'package:reservaapp/paginas/registro_page.dart';
import 'package:reservaapp/paginas/reserva_page.dart';
import 'package:reservaapp/paginas/sucursales_page.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/providers/ubicaciones_provider.dart';
import 'package:reservaapp/providers/usuario_provider.dart';

import 'blocs/theme.dart';


final prefs = new PreferenciasUsuario();

void main() async{

    WidgetsFlutterBinding.ensureInitialized();
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();

    runApp(

      MultiProvider(
        providers:[
          ChangeNotifierProvider( create: (_)=>new ThemeChanger(prefs.modoAplicacion)),
          ChangeNotifierProvider( create: (_)=>new UsuarioProvider()),
          ChangeNotifierProvider( create: (_)=>new SucursalesProvider()),
          ChangeNotifierProvider( create: (_)=>new UbicacionesProvider()),
        ],
        child: MyApp(), 
      )
    );

} 




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final temaActual = Provider.of<ThemeChanger>(context).temaActual;

    return MaterialApp(
        theme: temaActual,
        debugShowCheckedModeBanner: false,
        title: 'Fut5 Reservas',
        initialRoute: 'Login',
        routes: {
          'Login': (BuildContext context) => LoginPage(),
          'Registro': (BuildContext context) => RegistroPage(),
          'MiPerfil': (BuildContext context) => MiPerfilPage(),
          'Configuracion': (BuildContext context) => ConfiguracionPage(),
          'Menu': (BuildContext context) => MenuPage(),
          'Sucursales': (BuildContext context) => SucursalesPage(),
          'Reservar': (BuildContext context) => ReservaPage(),
    
          //acá todas las relacionadas al anfitron
          'MisSucursales': (BuildContext context) => MisSucursalesPage(),
          'MenuAnfitrion': (BuildContext context) => MenuAnfitrionPage(),
    
          //acá genericas
          'Ayuda': (BuildContext context) => AyudaPage(),
          'Comentarios': (BuildContext context) => ComentariosPage(),
    
        },
    );
}
}