import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/horario_provider.dart';


class CanchasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    final horariosServices = Provider.of<HorariosProvider>(context);

   
    return Scaffold(
       appBar: AppBar(
      title: Text("Slivers"),
    ),
    body: FutureBuilder(
      future: horariosServices.ObtenerHorarioPorSucursal(2),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

         if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
       else if (snapshot.hasData) {
        return CustomScrollView(
          slivers: _sliverList(snapshot.data.objeto.canchas),
          );
       }
      }


    return const Center(child: CircularProgressIndicator());

      }
    ),
    );
  }
}

List<Widget> _sliverList( dynamic canchas) {
    var widgetList = <Widget>[];
    for (int contador = 0; contador < canchas.length; contador++)
      widgetList
        ..add(SliverAppBar(
           title: Text(canchas[contador].nombre),
           pinned: true,
         ))
        ..add(SliverFixedExtentList(
          itemExtent: 50.0,
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                   return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text(canchas[contador].horarios[index].horaInicio +' - ' + canchas[contador].horarios[index].horaFin),
                   );
              }, childCount: canchas[contador].horarios.length),
        ));

   return widgetList;
}