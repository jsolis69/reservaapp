import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/horario_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class CanchasPage extends StatefulWidget {

  @override
  State<CanchasPage> createState() => _CanchasPageState();
}

class _CanchasPageState extends State<CanchasPage> {
  @override
  Widget build(BuildContext context) {


    final horariosServices = Provider.of<HorariosProvider>(context);
  
    final f = new DateFormat('dd-MM-yyyy');
    var fecha= f.format(DateTime.now()) ;

   
    return Scaffold(
       appBar: AppBar(
      title: Center(child: Text(fecha)),
      actions: [
        IconButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              locale: const Locale("es", "ES"),
              context: context, 
              initialDate: DateTime.now(), 
              firstDate: DateTime.now(), 
              lastDate: DateTime.now().add(const Duration(days: 30 ))
              );

              fecha= f.format(pickedDate!) ;
              setState(() {
                print(fecha);
              });
          },
          icon: Icon(Icons.calendar_month),
          )
      ],
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
          flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 165, 93, 4),
                      Color.fromARGB(255, 192, 118, 6),
                    ],
                  ),
                ),
              ),
          leading: Icon(Icons.sports_soccer_sharp),
           title: Text(canchas[contador].nombre),
           pinned: true,
         ))
        ..add(SliverFixedExtentList(
          itemExtent: 50.0,
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {

                final horario = canchas[contador].horarios[index];


                return Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                        Text(horario.horaInicio +' - ' + horario.horaFin),
                        !horario.reserva.equipo1.nombre?.isEmpty ? 
                        Text((horario.reserva.equipo1.nombre?? '') + '-' + (horario.reserva.equipo2.nombre?.isEmpty ? 'Esperando reto' : horario.reserva.equipo2.nombre))
                        :Text('Disponible'),
                        
                        
                        Row(children: [
                          Icon(Icons.calendar_month),
                          Icon(Icons.send),
                          Icon(Icons.person)
                        
                                        ])
                    ]
                              
                  ),
                );
              }, childCount: canchas[contador].horarios.length),
        ));

   return widgetList;
}