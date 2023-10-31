import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/horarios_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class HorariosPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
      final horariosServices = Provider.of<HorarioProvider>(context, listen: true);
  final fSer = new DateFormat('yyyy-MM-dd');
  final reservaServices = Provider.of<ReservaProvider>(context);
  final canchasServices = Provider.of<CanchasProvider>(context);
  horariosServices.ObtenerHorarioPorCancha(canchasServices.canchaSeleccionada, fSer.format(reservaServices.fechaSeleccionada));
    


    return Scaffold(
      backgroundColor: const Color(0xFF333A47),
      appBar: AppBar( title: Text('Horarios'), ),
      body: 
      SafeArea(
        child: horariosServices.horariosXReserva.length == 0
    ? const Center(child: Text('No se encontraron horarios disponibles'))
    : HorariosxDia(),
      ),
    );
  }
}

class HorariosxDia extends StatelessWidget {
  const HorariosxDia({super.key});

@override
  Widget build(BuildContext context) {

  

    //final canchaServices = Provider.of<CanchasProvider>(context);
    //final horarioServices = Provider.of<HorarioProvider>(context, listen: false);
    final reservaServices = Provider.of<ReservaProvider>(context);

    //final fSer = new DateFormat('yyyy-MM-dd');

return SingleChildScrollView(
  child:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CalendarTimeline(
                initialDate: reservaServices.fechaSeleccionada,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 10)),
                onDateSelected: (date)  
                {
                  reservaServices.fechaSeleccionada = date;
                  //horarioServices.ObtenerHorarioPorCancha(canchaServices.canchaSeleccionada, fSer.format(date));
                },
                leftMargin: 20,
                monthColor: Colors.white70,
                dayColor: Colors.teal[200],
                dayNameColor: const Color(0xFF333A47),
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.redAccent[100],
                dotsColor: const Color(0xFF333A47),
                //selectableDayPredicate: (date) => date.day != 23,
                locale: 'es',
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: _listaHorarios(context)
              ),
            ],
  
          ),
);
  }
}


  Widget _listaHorarios(BuildContext context) {
      
       final horariosServices = Provider.of<HorarioProvider>(context);


      if(horariosServices.horariosXReserva.length <= 0)
    return Container();
    else
  ////Container();
  return CustomScrollView(
    shrinkWrap: true,
    slivers: <Widget>[
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing:20,
          childAspectRatio: 2.0
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final horario = horariosServices.horariosXReserva[index];
          return _horas(horario: horario);
        },
        childCount: horariosServices.horariosXReserva.length
        ),
      )
    ],
  );
  
  }


  



class _horas extends StatelessWidget {
  const _horas({
    required this.horario,
  });

  
  final horario;
  @override
  Widget build(BuildContext context) {
    final reservaServices = Provider.of<HorarioProvider>(context);


    Color colorHorario = Colors.green;
    var texto = 'Libre';
    if(horario.reserva.equipo1.idUsuario > 0)
     { colorHorario = Colors.orange;
      texto = 'Reto';}
    if(horario.reserva.equipo2.idUsuario > 0 || horario.reserva.indLlevaDosEquipos)
      {colorHorario = Colors.red;
      texto = 'Reservada';}

    return GestureDetector(
      onTap: (){
          //print(horario.idHorario);
          reservaServices.horarioSeleccionado = horario;
          Navigator.pushNamed(context, 'ProcesarReserva');
        },
      child: Container( 
      decoration: BoxDecoration(
        color: colorHorario,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(horario.horaInicio.substring(0, 5) +' - ' + horario.horaFin.substring(0, 5)),
          
            Text(texto),
            
          ],
        ),
      ),
      ),
    );

  }

}