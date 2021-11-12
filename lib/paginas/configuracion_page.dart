import 'package:flutter/material.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:reservaapp/widgets/menu_widget.dart';

class ConfiguracionPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: crearTitulo('Configuración', 24.0)),
      drawer: MenuWidget(),
      body: Center(
        child: Text('configuracion'),
      ),
    );
  }
}