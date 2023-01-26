import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/providers/horario_provider.dart';


class CanchasPage extends StatefulWidget {

  @override
  State<CanchasPage> createState() => _CanchasPageState();
}

class _CanchasPageState extends State<CanchasPage> {

    DateTime selectedDate = DateTime.now();
      Future<void> _seleccionarFecha(BuildContext context)async {
            DateTime? pickedDate = await showDatePicker(
              locale: const Locale("es", "ES"),
              context: context, 
              initialDate: selectedDate, 
              firstDate: DateTime.now().add(const Duration(days: -30)), 
              lastDate: DateTime.now().add(const Duration(days: 30 ))
              );
              setState(() {
                selectedDate = pickedDate!;
              });
          }

  @override
  Widget build(BuildContext context) {


    final horariosServices = Provider.of<HorariosProvider>(context);
  final f = new DateFormat('dd-MM-yyyy');
  final fSer = new DateFormat('yyyy-MM-dd');

   
    return Scaffold(
       appBar: AppBar(
      title: Center(child: Text(f.format(selectedDate))),
      actions: [
        IconButton(
          onPressed: () {

            _seleccionarFecha(context);
          },
          icon: Icon(Icons.calendar_month),
          )
      ],
    ),
    body: FutureBuilder(
      future: horariosServices.ObtenerHorarioPorSucursal(2, fSer.format(selectedDate)),
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

                          if(horario.reserva.equipo1.nombre?.isEmpty)
                            Icon(Icons.calendar_month),

                          if(PreferenciasUsuario.esPropietario)
                            Icon(Icons.send),
                          if(horario.reserva.equipo2.nombre?.isEmpty)
                            Icon(Icons.person),
                          if((horario.reserva.equipo2.idUsuario == PreferenciasUsuario.usuarioLogueado)
                          || (horario.reserva.equipo1.idUsuario == PreferenciasUsuario.usuarioLogueado))
                            Icon(Icons.dangerous)
                        ])
                    ]
                              
                  ),
                );
              }, childCount: canchas[contador].horarios.length),
        ));

   return widgetList;
}