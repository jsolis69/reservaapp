//import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/providers/canchas_provider.dart';
import 'package:reservaapp/providers/horarios_provider.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:grouped_list/grouped_list.dart';


class MisHorariosPage extends StatelessWidget {
  const MisHorariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
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
    )
    );
  }
}


class _listaHorarios extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final HorariosServices = Provider.of<HorarioProvider>(context, listen: false);
  final canchasServices = Provider.of<CanchasProvider>(context);

  //return Container();
    return FutureBuilder(
      future: HorariosServices.ObtenerMisHorarios(canchasServices.canchaSeleccionada),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
       else if (snapshot.hasData) {


  //var newMap = groupBy(snapshot.data.listaGenerica, (Horario obj){
   // return obj.diaSemana.codigo;
      //print(obj.diaSemana.codigo);
  //});


        return Padding(
          padding: const EdgeInsets.only(top: 110),
          child: GroupedListView<dynamic, String>(
            useStickyGroupSeparators: true,
            stickyHeaderBackgroundColor: Colors.red,
            //padding: EdgeInsets.only(top: 110),
            elements: snapshot.data.listaGenerica,
            groupBy: (element) => element.diaSemana.descripcion.toString(),
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1.idHorario.compareTo(item2.idHorario),
            order: GroupedListOrder.ASC,
            //floatingHeader: true,
            //sort: true,
            //useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (c, element) {
              return Card(
                //elevation: 19.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: SizedBox(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    leading: const Icon(Icons.account_circle),
                    title: Text(element.horaFin),
                    trailing: Checkbox(value: element.seleccionado, onChanged: (_value){ }),/// const Icon(Icons.arrow_forward),
                  ),
                ),
              );
            }),
        );
        
        //return ListView.builder(
        //  padding: EdgeInsets.only(top: 110),
        //  //itemExtent: 50,
        //  itemCount: snapshot.data.listaGenerica.length,
        //  itemBuilder: (BuildContext context, int index) {
        //    return ListTile(
        //      title: Text(snapshot.data.listaGenerica[index].horaFin),
        //      trailing: Icon(Icons.tram_sharp),
        //      );
        //  },
        //
        //);
//
      }
        
    }
    return const Center(child: CircularProgressIndicator());



      },
    );

  }
  }