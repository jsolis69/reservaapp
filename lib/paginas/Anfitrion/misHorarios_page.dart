import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/horarios_provider.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:grouped_list/grouped_list.dart';


class MisHorariosPage extends StatelessWidget {
  const MisHorariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(child: 
      Stack(
        children: [
          _listaHorarios(),
          HeaderWidget(
            icono: FontAwesomeIcons.calendarDay, 
            titulo: 'Horarios',
            color1: Colors.pinkAccent,
            color2: Colors.grey,
            paginaReturn: 'MisCanchas',
          )
        ],
      )
    ));
  }
}

class _listaHorarios extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final HorariosServices = Provider.of<HorarioProvider>(context);
    final canchasServices = Provider.of<CanchasProvider>(context);
    HorariosServices.ObtenerMisHorarios(canchasServices.canchaSeleccionada);

    return HorariosServices.horariosXCancha.length == 0
    ? const Center(child: CircularProgressIndicator())
    : ListaItems();
  }
}

class ListaItems extends StatelessWidget {
  const ListaItems({super.key});
  @override
  Widget build(BuildContext context) {
    final HorariosServices = Provider.of<HorarioProvider>(context, listen: true);
    final canchasServices = Provider.of<CanchasProvider>(context);
    return Padding(
          padding: const EdgeInsets.only(top: 110),
          child: GroupedListView<dynamic, String>(
            //useStickyGroupSeparators: true,
            //stickyHeaderBackgroundColor: Colors.red,
            //padding: EdgeInsets.only(top: 110),
            elements: HorariosServices.horariosXCancha,
            groupBy: (element) => element.diaSemana.codigo.toString(),
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1.idHorario.compareTo(item2.idHorario),
            order: GroupedListOrder.DESC,
            //floatingHeader: true,
            //sort: true,
            //useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ObtenerNombreDia(value),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (c, element) {
              return Card(
                //elevation: 19.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: SizedBox(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                      leading: const Icon(FontAwesomeIcons.solidClock),
                      title: Text(element.horaInicio),
                      trailing: Checkbox(
                        value: element.seleccionado, 
                        onChanged: (_value){ 
                          HorariosServices.InsertarHorarioCancha(canchasServices.canchaSeleccionada, element.idHorario, _value);
                        },
                      ),/// const Icon(Icons.arrow_forward),
                  ),
                ),
              );
            }),
        );
  }
}

String ObtenerNombreDia(String value) {

  var diaSemana;
  switch (value) {
    case '1':
      diaSemana = 'Lunes';
      break;
    case '2':
      diaSemana = 'Martes';
      break;
    case '3':
      diaSemana = 'Miércoles';
      break;
    case '4':
      diaSemana = 'Jueves';
      break;
    case '5':
      diaSemana = 'Viernes';
      break;
    case '6':
      diaSemana = 'Sábado';
      break;
    default:
      diaSemana = 'Domingo';
      break;
  }

  return diaSemana;
}

