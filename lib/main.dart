//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/models/notificacion_model.dart';
import 'package:reservaapp/paginas/Anfitrion/menuAnfitron_page.dart';
import 'package:reservaapp/paginas/Anfitrion/misCanchas_page.dart';
import 'package:reservaapp/paginas/Anfitrion/misSucursales_page.dart';
import 'package:reservaapp/paginas/ayuda_page.dart';
import 'package:reservaapp/paginas/canchas_page.dart';
import 'package:reservaapp/paginas/comentarios_page.dart';
import 'package:reservaapp/paginas/configuracion_page.dart';
import 'package:reservaapp/paginas/horarios_page.dart';
import 'package:reservaapp/paginas/login_page.dart';
import 'package:reservaapp/paginas/menu_page.dart';
import 'package:reservaapp/paginas/miPerfil_page.dart';
import 'package:reservaapp/paginas/procesarReserva_page.dart';
import 'package:reservaapp/paginas/registro_page.dart';
import 'package:reservaapp/paginas/sucursales_page.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/providers/tema_provider.dart';
import 'package:reservaapp/providers/ubicaciones_provider.dart';
import 'package:reservaapp/providers/usuario_provider.dart';

void main() async{

    WidgetsFlutterBinding.ensureInitialized();
    //final prefs = new PreferenciasUsuario();
    await PreferenciasUsuario.init();

    runApp(

      MultiProvider(
        providers:[
          ChangeNotifierProvider( create: (_)=>new TemaServicio(esModoOscuro: PreferenciasUsuario.esModoOscuro)),
          ChangeNotifierProvider( create: (_)=>new UsuarioProvider()),
          ChangeNotifierProvider( create: (_)=>new SucursalesProvider()),
          ChangeNotifierProvider( create: (_)=>new UbicacionesProvider()),
          ChangeNotifierProvider( create: (_)=>new ReservaProvider()),
          ChangeNotifierProvider( create: (_)=>new NotificacionModel()),
          ChangeNotifierProvider( create: (_)=>new CanchasProvider()),
        ],
        child: MyApp(), 
      )
    );

} 




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final temaActual = Provider.of<TemaServicio>(context).temaActual;

    return MaterialApp(
      //para cambiar el idioma del datepicker
      localizationsDelegates: [      
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
         const Locale('es'),
         const Locale('en')
      ],
        theme: temaActual,
        debugShowCheckedModeBanner: false,
        title: 'Fut5 Reservas',
        initialRoute: PreferenciasUsuario.usuarioLogueado > 0 ? 'Sucursales' : 'Login',
        routes: {
          'Login': (BuildContext context) => LoginPage(),
          'Registro': (BuildContext context) => RegistroPage(),
          'MiPerfil': (BuildContext context) => MiPerfilPage(),
          'Configuracion': (BuildContext context) => ConfiguracionPage(),
          'Menu': (BuildContext context) => MenuPage(),
          'Sucursales': (BuildContext context) => SucursalesPage(),
          'Horarios': (BuildContext context) => HorariosPage(),
          'Canchas': (BuildContext context) => CanchasPage(),
          'ProcesarReserva':(BuildContext context) => ProcesarReservaPage(),
    
          //acá todas las relacionadas al anfitron
          'MisSucursales': (BuildContext context) => MisSucursalesPage(),
          'MisCanchas': (BuildContext context) => MisCanchasPage(),
          'MenuAnfitrion': (BuildContext context) => MenuAnfitrionPage(),
    
          //acá genericas
          'Ayuda': (BuildContext context) => AyudaPage(),
          'Comentarios': (BuildContext context) => ComentariosPage(),
    
        },
    );
}
}