import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/horarios_provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';
import 'package:reservaapp/widgets/header.dart';

class HorariosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final horariosServices = Provider.of<HorarioProvider>(context, listen: true);
    final fSer = new DateFormat('yyyy-MM-dd');
    final reservaServices = Provider.of<ReservaProvider>(context);
    final canchasServices = Provider.of<CanchasProvider>(context);
    horariosServices.ObtenerHorarioPorCancha(canchasServices.canchaSeleccionada, fSer.format(reservaServices.fechaSeleccionada)); 
    String titulo = 'Horarios';
    Color colorPrimario = Color(0xff08088A);
    Color colorSecundario = Color(0xff5858FA);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            horariosServices.respuestaServicio == 97
            ? const Center(child: CircularProgressIndicator())
            : HorariosxDia(),
            HeaderWidget(
              icono: FontAwesomeIcons.calendarDay, 
              titulo: titulo,
              color1: colorPrimario,
              color2: colorSecundario,
              paginaReturn: 'Canchas',
            )
          ],
        ),
      ) 
    );
  }
}

class HorariosxDia extends StatelessWidget {
  const HorariosxDia({super.key});

@override
  Widget build(BuildContext context) {
    final reservaServices = Provider.of<ReservaProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 100,),
          EtiquetaPersonalizada(descripcion: 'Seleccione la fecha del partido'),
          SizedBox(height: 20,),
          CalendarTimeline(
            initialDate: reservaServices.fechaSeleccionada,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 10)),
            onDateSelected: (date)  
            {
              reservaServices.fechaSeleccionada = date;
            },
            monthColor: Colors.white70,
            dayColor: Colors.teal[200],
            dayNameColor: const Color(0xFF333A47),
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: const Color(0xFF333A47),
            //selectableDayPredicate: (date) => date.day != 23,
            locale: 'es',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: _listaHorarios(context)
            ),
          ),
        ]
      ),
    );
  }
}


  Widget _listaHorarios(BuildContext context) {
      
       final horariosServices = Provider.of<HorarioProvider>(context);


      if(horariosServices.horariosXReserva.length <= 0)
    return Center(child: Text('No existen horarios para esta fecha'));
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