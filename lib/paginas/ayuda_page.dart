import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/blocs/theme.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/slideshow.dart';

class AyudaPage extends StatelessWidget {
  static const routeName = 'cliente';
  //const AyudaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final args = ModalRoute.of(context).settings.arguments as String;
  String menu = "Menu";
  if(args == "Anfitrion")
  
  {
    menu = "MenuAnfitrion";
  }

    return Scaffold(
        //appBar: AppBar(),
        body: Stack(
          children:[ 
            Container(
              margin: EdgeInsets.only(top: 170),
              child: Stack(
                children: [
                  _crearFormulario(context),
                  SizedBox(height: 100),
                ],
              ),
            ),
              HeaderWidget(
              icono: FontAwesomeIcons.question, 
              titulo: 'Ayuda',
              color1: Color(0xffFA5858) ,
              color2: Color(0xffDF0101)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: () => Navigator.pushNamed(context, menu), icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 40,) ),
            )
          ]
        ),
      );
  }
}

Widget _crearFormulario(BuildContext context) {

  final temaAplicacion = Provider.of<ThemeChanger>(context);

  return Slidesshow(
    colorPrimario: temaAplicacion.modoOscuro ? temaAplicacion.temaActual.accentColor : Colors.red,
    //colorSecundario: Colors.purple,
    slides: <Widget>[
        SvgPicture.asset('assets/svgs/svg1.svg'),
        SvgPicture.asset('assets/svgs/svg2.svg')
    ], 
    //puntosArriba: true,
    tamPunto: 12,
    tamPuntoSeleccionado: 18,
  );
}