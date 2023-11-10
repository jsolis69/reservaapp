import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservaapp/widgets/header.dart';

class ComentariosPage extends StatelessWidget {
  //const ComentariosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final args = ModalRoute.of(context)!.settings.arguments as String;
  String menu = "Menu";
  if(args == "Anfitrion")
  {
    menu = "MenuAnfitrion";
  }

    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children:[ 
              HeaderWidget(
              icono: FontAwesomeIcons.comment, 
              titulo: 'Comentarios',
              color1: Color(0xffFA5858),
              color2: Color(0xffDF0101)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: () => Navigator.pushNamed(context, menu), icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 40,) ),
            )
          ]
        ),
      ),
    );
  }
}