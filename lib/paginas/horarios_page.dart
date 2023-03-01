import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';


class HorariosPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: _appBar(context),
      body: Column(children:[
          Expanded(child: ListaHorarios())
          //const NotificacionWidget(),
        ]),
    );
  }

  AppBar _appBar(BuildContext context) {
    
    final reservaServices = Provider.of<ReservaProvider>(context, listen: true);
    final f = new DateFormat('dd-MM-yyyy');
    return AppBar(
    title: Center(child: Text(f.format(reservaServices.fechaSeleccionada))),
    actions: [
      IconButton(
        onPressed: () async {

            DateTime? pickedDate = await showDatePicker(
              locale: const Locale("es", "ES"),
              context: context, 
              initialDate: reservaServices.fechaSeleccionada, 
              firstDate: DateTime.now().add(const Duration(days: -30)), 
              lastDate: DateTime.now().add(const Duration(days: 30 ))
              );
             
             reservaServices.fechaSeleccionada = pickedDate!;



          //_seleccionarFecha(context);
        },
        icon: Icon(Icons.calendar_month),
        )
    ],
  );
  }
}

class ListaHorarios extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final horariosServices = Provider.of<ReservaProvider>(context);

    return 
    //Container();
    CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing:20,
            childAspectRatio: 3.0
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final horario = horariosServices.listaCanchas[index];

            return _horarios2(horario: horario);


          },
          childCount: horariosServices.listaCanchas.length
          ),
        )
      ],
    );
  }
}


class _horarios2 extends StatelessWidget {
  const _horarios2({
    required this.horario,
  });

  
  final horario;
  @override
  Widget build(BuildContext context) {

    Color colorHorario = Colors.green;
    var texto = 'Libre';
    if(horario.reserva.equipo1.idUsuario != -1)
     { colorHorario = Colors.orange;
      texto = 'Reto';}
    if(horario.reserva.equipo2.idUsuario != -1)
      {colorHorario = Colors.red;
      texto = 'Reservada';}

    return GestureDetector(
      onTap: (){
          Navigator.pushNamed(context, 'ProcesarReserva');
        },
      child: Container( 
      decoration: BoxDecoration(
        color: colorHorario,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(horario.horaInicio.substring(0, 5) +' - ' + horario.horaFin.substring(0, 5)),
    
          Text(texto),
            //Text((horario.reserva.equipo1.nombre?? '') + '-' + (horario.reserva.equipo2.nombre?.isEmpty ? 'Esperando reto' : horario.reserva.equipo2.nombre))
            //:Text('Disponible'),
    
         
          
        ],
      ),
      ),
    );

  }

}