
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservaapp/widgets/botonesNavegacion_widget.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:location/location.dart';


class SucursalesPage extends StatefulWidget {

  @override
  State<SucursalesPage> createState() => _SucursalesPageState();
}

Location location = new Location();
bool _serviceEnabled = false;
PermissionStatus _permissionGranted = PermissionStatus.denied;
LocationData? _locationData;

Future<dynamic> obtenerLocalozacion() async {
_serviceEnabled= await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

_locationData = await location.getLocation();


}

class _SucursalesPageState extends State<SucursalesPage> {

  @override
  void initState() {
    obtenerLocalozacion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //timeDilation = 3.0; // Changing the value to normal animation speed.
    String titulo = 'Reservar';
    Color colorPrimario = Color(0xff08088A);
    Color colorSecundario = Color(0xff5858FA);

  
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            
            _contenido(),
            HeaderWidget(
              icono: FontAwesomeIcons.calendarDay, 
              titulo: titulo,
              color1: colorPrimario,
              color2: colorSecundario
            )
          ],
        ),
      ),
      bottomNavigationBar: BotonesNavegacion(seleccionado: 1,)
    );
  }
}

class _contenido extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final sucursalesServices = Provider.of<SucursalesProvider>(context);
    return FutureBuilder(
      future: sucursalesServices.obtenerSucursalesPorUbicacion(_locationData?.latitude, _locationData?.longitude),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
       else if (snapshot.hasData) {
        
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              margin: EdgeInsets.only(top: 120),
              child: 
              ListView.builder(
              itemCount: snapshot.data.listaGenerica.length,
              itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Color(0xff5858FA), width: 1)) ,
              contentPadding: EdgeInsets.all(15),
              //tileColor: Colors.red,
              //splashColor: Colors.green,
              leading: Image(image: AssetImage('assets/img/stadiumIcon.png')),// Icon(Icons.list),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              title: Center(
                child: Text(snapshot.data.listaGenerica[index].nombre),
              ),
              subtitle:  Center(child: Text(snapshot.data.listaGenerica[index].NombreEmpresa)),
              //isThreeLine: true,
              onTap: (){
                sucursalesServices.sucursalSeleccionada = snapshot.data.listaGenerica[index].idSucursal;
                Navigator.pushNamed(context, 'Canchas');
                
              },
              ),
          );
              },
            )
              //Stack(
              //  children: [
              //    _crearFormularioReservar(context),
              //    SizedBox(height: 100),
              //  ],
              //),
            ),
        );



      }
        
    }
    return const Center(child: CircularProgressIndicator());



      },
    );
  }
}
