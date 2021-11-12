import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservaapp/widgets/botones_grandes.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:reservaapp/utils/utilsCalendar.dart';


import 'dart:collection';

class ReservaPage extends StatefulWidget {
  //const ReservaPage({Key? key}) : super(key: key);

  @override
  _ReservaPageState createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {

  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

    List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    // Implementation example
    // Note that days are in selection order (same applies to events)
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _selectedDay = selectedDay;
      //_selectedDays.removeAll(_selectedDays.where((selectedDay) => false));
      // Update values in a Set
      //if (_selectedDays.contains(selectedDay)) {
        //_selectedDays.remove(selectedDay);
      //} else {
        _selectedDays.removeWhere((element) => element != selectedDay);
        _selectedDays.add(selectedDay);
      //}
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container( 
            margin: EdgeInsets.only(top: 170),
            child: Stack(
                children: [
                _crearCalendario(),
                SizedBox(height: 100),
                _formulario(context),
                ],
              ),
            ),
          Hero(
            tag: 'hero1',
            child: HeaderWidget(
            icono: FontAwesomeIcons.building, 
            titulo: 'Nombre Empresa',
            color1: Color(0xff08088A),
            color2: Color(0xff5858FA)
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () => Navigator.pushNamed(context, 'Sucursales'), icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 40,) ),
          )
        ],
      ),
      //bottomNavigationBar: BotonesNavegacion(seleccionado: 1,)
    );
  }

  Widget _crearCalendario (){

return Container(
  child:   TableCalendar(
        //headerStyle: HeaderStyle(decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20))),
        //calendarStyle: CalendarStyle(todayDecoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(50.0))),
        locale: 'es-CR',
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected
          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: _onDaySelected,
        onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
        onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
        },
      //), 
      //color: Colors.white,
      ),
);
}

Widget _formulario(BuildContext context){
return Container(
  //color: Colors.red,
  margin: EdgeInsets.only(top: 400),
  //height: 100,
  child:   ListView(
      physics: BouncingScrollPhysics(),
          children: [
            BotonesGrantes(
              titulo: 'Partido 1',
              color1:Color(0xff08088A),
              color2: Color(0xff5858FA),
              icono: FontAwesomeIcons.calendarDay,
              ),
           BotonesGrantes(titulo: 'Partido 2',
              color1:Color(0xff08088A),
              color2: Color(0xff5858FA),
              icono: FontAwesomeIcons.calendarDay,
              ),
  
           ],
  
   shrinkWrap: true),
);





             //lueListenableBuilder<List<Event>>(
             //    valueListenable: _selectedEvents,
             //    builder: (context, value, _) {
             //      return ListView.builder(
             //        shrinkWrap: true,
             //        itemCount: value.length,
             //        itemBuilder: (context, index) {
             //          return 
             //          Container(
             //            margin: const EdgeInsets.symmetric(
             //              horizontal: 12.0,
             //              vertical: 4.0,
             //            ),
             //            decoration: BoxDecoration(
             //              border: Border.all(),
             //              borderRadius: BorderRadius.circular(12.0),
             //            ),
             //            child: ListTile(
             //              //onTap: () => print('${value[index]}'),
             //              title: Text('${value[index]}'),
             //              subtitle: Text('8:00 - 9:00'),
             //              //usar esto cuando se reservó y ocupa reto
             //              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.emoji_events_outlined)),
             //              //usar este cuando el horario esté disponible
             //              //trailing: IconButton(onPressed: (){}, icon: Icon(Icons.sports_soccer_rounded)),
             //              //No usar nada cuando esté reservada completa.
             //            ),
             //          );
             //          },
             //      );
             //    },
             //  ),
        
       
}
}