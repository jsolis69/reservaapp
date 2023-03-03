import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/reserva_provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class HorariosPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      //appBar: AppBar( ),
      body: 
      Column(children:[
          Expanded(child: ListaHorarios2())
        ]),
    );
  }

 //AppBar _appBar(BuildContext context) {
 //  
 //  final reservaServices = Provider.of<ReservaProvider>(context, listen: true);
 //  final f = new DateFormat('dd-MM-yyyy');
 //  return AppBar(
 //  title: Center(child: Text(f.format(reservaServices.fechaSeleccionada))),
 //  actions: [
 //    IconButton(
 //      onPressed: () async {

 //          DateTime? pickedDate = await showDatePicker(
 //            locale: const Locale("es", "ES"),
 //            context: context, 
 //            initialDate: reservaServices.fechaSeleccionada, 
 //            firstDate: DateTime.now().add(const Duration(days: -30)), 
 //            lastDate: DateTime.now().add(const Duration(days: 30 ))
 //            );
 //           
 //           reservaServices.fechaSeleccionada = pickedDate!;



 //        //_seleccionarFecha(context);
 //      },
 //      icon: Icon(Icons.calendar_month),
 //      )
 //  ],
 //);
 //}
}

class ListaHorarios2 extends StatelessWidget {
  const ListaHorarios2({super.key});

@override
  Widget build(BuildContext context) {

  

    final horariosServices = Provider.of<ReservaProvider>(context);
    final reservaServices = Provider.of<ReservaProvider>(context);
    final fSer = new DateFormat('yyyy-MM-dd');

return Scaffold(
      backgroundColor: const Color(0xFF333A47),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Calendar Timeline',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.tealAccent[100]),
              ),
            ),
            CalendarTimeline(
              //showYears: true,
              initialDate: reservaServices.fechaSeleccionada,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 10)),
              onDateSelected: (date)  
              //setState(() => _selectedDate = date),
              {
                //print(date);
                //_selectedDate = date;
                reservaServices.fechaSeleccionada = date;
                //setState(() { });
               
               horariosServices.ObtenerHorarioPorCancha(reservaServices.canchaSeleccionada, fSer.format(date));
               
               },//setState(() => _selectedDate = date),
              leftMargin: 20,
              monthColor: Colors.white70,
              dayColor: Colors.teal[200],
              dayNameColor: const Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'es',
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _horariosNew(context)
            ),
            
            //Center(
            //  child: Text(
            //    'Selected date is' + fSer.format(_selectedDate),
            //    style: const TextStyle(color: Colors.white),
            //  ),
            //)
          ],
        ),
      ),
    );
  }
}


  Widget _horariosNew(BuildContext context) {
      final horariosServices = Provider.of<ReservaProvider>(context);
    return 
  ////Container();
  CustomScrollView(
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
          final horario = horariosServices.listaHorarios[index];
          return _horarios2(horario: horario);
        },
        childCount: horariosServices.listaHorarios.length
        ),
      )
    ],
  );
  
  }


  



class _horarios2 extends StatelessWidget {
  const _horarios2({
    required this.horario,
  });

  
  final horario;
  @override
  Widget build(BuildContext context) {
    final reservaServices = Provider.of<ReservaProvider>(context);


    Color colorHorario = Colors.green;
    var texto = 'Libre';
    if(horario.reserva.equipo1.idUsuario > 0)
     { colorHorario = Colors.orange;
      texto = 'Reto';}
    if(horario.reserva.equipo2.idUsuario > 0)
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