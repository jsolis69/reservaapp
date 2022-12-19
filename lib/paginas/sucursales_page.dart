
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservaapp/models/sucursales_model.dart';
import 'package:reservaapp/models/ubicaciones_model.dart';
import 'package:reservaapp/providers/ubicaciones_provider.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:reservaapp/widgets/botonesNavegacion_widget.dart';
import 'package:reservaapp/widgets/botones_grandes.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';

class SucursalesPage extends StatefulWidget {

  final IconData icono;
  //final VoidCallback onTap;
  final Color color1;
  final Color color2;

  const SucursalesPage({Key key, 
  this.icono = FontAwesomeIcons.calendarDay, 
  //this.onTap, 
  this.color1 = Colors.green, 
  this.color2 = Colors.greenAccent
  }
) : super(key: key);

  @override
  _SucursalesPageState createState() => _SucursalesPageState();
}

class _SucursalesPageState extends State<SucursalesPage> {

  @override
  Widget build(BuildContext context) {
    //timeDilation = 3.0; // Changing the value to normal animation speed.
    String titulo = 'Reservar';
    Color colorPrimario = Color(0xff08088A);
    Color colorSecundario = Color(0xff5858FA);

  
    return Scaffold(
      //appBar: AppBar(),
      //drawer: MenuWidget(),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 170),
            child: Stack(
              children: [
                _crearFormularioReservar(context),
                SizedBox(height: 100),
              ],
            ),
          ),
          HeaderWidget(
            icono: widget.icono, 
            titulo: titulo,
            color1: colorPrimario,
            color2: colorSecundario
          )
        ],
      ),
      bottomNavigationBar: BotonesNavegacion(seleccionado: 1,)
    );
  }



Widget _crearFormularioReservar(BuildContext context) {

  return _obtenerUbicaciones();
  //Column(
  //  children: [
  //    SizedBox(width: double.infinity),
  //    _obtenerUbicaciones(),
//
  //  ],
  //);
}

Widget _obtenerUbicaciones(){

  final ubicacionesprovider = Provider.of<UbicacionesProvider>(context);


  return FutureBuilder(
    future: ubicacionesprovider.obtenerProvincias(),
    builder: (BuildContext context, AsyncSnapshot<UbicacionesResponse> snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
    
            return Center(child: CircularProgressIndicator(),);
    
          }
          else{
            if(snapshot.hasError)
              return MostrarMensajeError();
            else
              return _ListaUbicaciones(snapshot.data.listaGenerica);

    
          }
    },
  );
}
}

class _ListaUbicaciones extends StatefulWidget {

final List<ListaUbicaciones> ubicaciones;


  _ListaUbicaciones(this.ubicaciones);


  @override
  __ListaUbicacionesState createState() => __ListaUbicacionesState();
}

class __ListaUbicacionesState extends State<_ListaUbicaciones> {


  ListaUbicaciones provinciaseleccionada = new ListaUbicaciones();
  Cantone cantonseleccionada = new Cantone();
  Distrito distritoseleccionada = new Distrito();


  List<ListaUbicaciones> listaProvincias;
  List<Cantone> listaCantones;
  List<Distrito> listadistritos = [];
  

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
      _obtenerProvincias(),
      _obtenerCantones(),
      _obtenerDistritos(),
      _obtenerCanchas(context),
      ],
    );
    

    //DropdownButton<ListaUbicaciones>(
    //   items: ubicaciones.map((e) {

    //     return DropdownMenuItem<ListaUbicaciones>(
    //       child: Text(e.descripcionProvincia),
    //       value: e,
    //       );

    //   }).toList(),
    //   hint: (Text(ubicaciones[0].descripcionProvincia)),
    //   onChanged: (_value){
    //       final varia = _value;
    //   },
    //   );




  }

  Widget _obtenerProvincias(){

  listaProvincias = widget.ubicaciones;
  //final ubicacionesprovider = Provider.of<UbicacionesProvider>(context);

  //ubicacionesprovider.provinciaSeleccionada = ubicaciones[0];
  //cantonesxProvincia = provinciaseleccionada == null ? [] : provinciaseleccionada.cantones;
  //distritoxCanton = null;//cantonesxProvincia[0].distritos;

  if(provinciaseleccionada.codigoProvincia == null){
    provinciaseleccionada.descripcionProvincia = 'Seleccione';
    provinciaseleccionada.codigoProvincia = -1;
  }
    



  return DropdownButton<ListaUbicaciones>(
    hint: Text(provinciaseleccionada.descripcionProvincia),
  //value: provinciaseleccionada == null ? widget.ubicaciones[0] : provinciaseleccionada,
   items: listaProvincias.map((e) {
     return DropdownMenuItem<ListaUbicaciones>(
       child: Text(e.descripcionProvincia),
       value: e,
       );
   }).toList(),
   //hint: (Text(provinciaseleccionada.descripcionProvincia)),
   onChanged: (_value){


      setState(() {

        provinciaseleccionada = _value;
        cantonseleccionada.codigoCanton = -1;
        cantonseleccionada.descripcionCanton = "seleccione"; 
        listaCantones = _value.cantones;

        //_obtenerCanchas(context);
      });
       //ubicacionesprovider.provinciaSeleccionada = _value;
       //ubicacionesprovider.cantonesxProvincia = ubicaciones[_value.codigoProvincia].cantones;
   },

   
   );
}


Widget _obtenerCantones(){


  if(provinciaseleccionada.codigoProvincia == -1)
  {
    listaCantones = null;
    cantonseleccionada.descripcionCanton = "seleccione";
    cantonseleccionada.codigoCanton = -1; 

  }
  else
  {
    listaCantones = listaProvincias.where((element) => element.codigoProvincia == provinciaseleccionada.codigoProvincia).last.cantones;
  }

  //listaCantones = provinciaseleccionada.codigoProvincia == -1 ? null : listaProvincias.where((element) => element.codigoProvincia == provinciaseleccionada.codigoProvincia).last.cantones;

  //final cantones = ["Cantón 1", "Cantón 2"];
  //final ubicacionesprovider = Provider.of<UbicacionesProvider>(context);
  //final List<Cantone> cantones = ubicacionesprovider.cantonesxProvincia;

  //final listaCantones = (cantonseleccionada == null ? new List<canton>(ditri)
  //distritoxCanton = cantonseleccionada == null ? [] : cantonseleccionada.distritos;
    return DropdownButton<Cantone>(
      //value: cantonseleccionada == null ? null : cantonseleccionada,
        items: listaCantones == null ? null : listaCantones.map((e){
          return DropdownMenuItem<Cantone>(
            child: Text(e.descripcionCanton),
            value: e,
            );
        }).toList(),
        hint: (Text(cantonseleccionada.descripcionCanton)),
        onChanged: (_value){
          setState(() {
            cantonseleccionada = _value;
            distritoseleccionada.codigoDistrito = -1;
            distritoseleccionada.descripcionDistrito = "seleccione"; 
            listadistritos = _value.distritos;
            //distritoseleccionada = distritoxCanton[0];
          });

          
        
        },
        );
}


Widget _obtenerDistritos(){

  //final distritos = ["Distrito 1", "Distrito 2"];
  //final ubicacionesprovider = Provider.of<UbicacionesProvider>(context);
  //final List<Cantone> cantones = ubicaciones[ubicacionesprovider.provinciaSeleccionada.codigoProvincia].cantones;

  //final List<Distrito> distritos = cantones[0].distritos;


  if(cantonseleccionada.codigoCanton == -1)
  {
    listadistritos = null;
    distritoseleccionada.descripcionDistrito = "seleccione";
    distritoseleccionada.codigoDistrito = -1; 

  }
  else
  {
    listadistritos = listaCantones.where((element) => element.codigoCanton == cantonseleccionada.codigoCanton).last.distritos;
  }

    return DropdownButton<Distrito>(
      //value: distritoseleccionada == null ? null : distritoseleccionada,
      hint: Text(distritoseleccionada.descripcionDistrito),
        items:  listadistritos == null ? null : listadistritos.map((e){
          return DropdownMenuItem<Distrito>(
            child: Text(e.descripcionDistrito),
            value: e,
            );
        }).toList(),
        //hint: (Text(opcionDefecto3)),
        onChanged: (_value){
          setState(() {
            distritoseleccionada = _value;
            //distritoxCanton = _value.distritos;
          });
        },
        );
}

Widget _obtenerCanchas(BuildContext context){

  //final String hero = 'hero';
  //final VoidCallback onTap;
  //final double width;

    final sucursalesprovider = Provider.of<SucursalesProvider>(context);


    return Expanded(
      child: FutureBuilder(
        future: sucursalesprovider.obtenerSucursalesPorUbicacion(
          provinciaseleccionada.codigoProvincia, 
          cantonseleccionada.codigoCanton,
          distritoseleccionada.codigoDistrito
          ),
          builder: (BuildContext context, AsyncSnapshot<SucursalesXUbicacionResponse> snapshop){
          if(snapshop.connectionState == ConnectionState.waiting){
    
            return Center(child: CircularProgressIndicator(),);
    
          }
          else{
            if(snapshop.data.listaGenerica.length > 0){
return _ListaSucursales(snapshop.data.listaGenerica);

            }
            else
            {
              return Center(child: Text('Sin información'),);
            }
    
          }
        }
      ),
    ); 
}

}

class _ListaSucursales extends StatelessWidget {

  final List<ListaSucursales> sucursales;

  _ListaSucursales(this.sucursales);


  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      shrinkWrap: true,
    itemCount: sucursales.length,
    itemBuilder: (BuildContext context, int i)
    {
      final sucursal = sucursales[i];

      return GestureDetector(
        onTap: ()=> Navigator.pushNamed(context, 'Reservar'),
        child: BotonesGrantes(
          titulo: sucursal.nombre,
          subtitulo: 'Nombre Sucursal',
          color1: Color(0xff08088A),
          color2: Color(0xff5858FA),
          icono: FontAwesomeIcons.building
        ));
    }
    
    );
  }
}




