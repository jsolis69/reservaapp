import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/Preferencias_usuario/preferencias_usuario.dart';
import 'package:reservaapp/providers/sucursales_provider.dart';
import 'package:reservaapp/widgets/botonesNavegacionAnfitrion.dart';
import 'package:reservaapp/widgets/header.dart';
import 'package:reservaapp/widgets/tarjeta_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MisSucursalesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'AgregarSucursal');
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _listaScurusales(),
            HeaderWidget(
            icono: FontAwesomeIcons.building, 
            titulo: 'Sucursales',
            color1: Colors.green,
            color2: Colors.grey
          ),
            
            
            
          ],
        ),
      ),
      bottomNavigationBar: BotonesNavegacionAnfitron(seleccionado: 0,)
    );
  }

  
}

class _listaScurusales extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final sucursalesServices = Provider.of<SucursalesProvider>(context);
    return FutureBuilder(
      future: sucursalesServices.ObtenerSucursalesPorPropietario(PreferenciasUsuario.usuarioLogueado),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(child: Text('Ocurrió un error consultado los datos', style: TextStyle(fontSize: 18)));
        }
       else if (snapshot.hasData) {
        
        return ListView.builder(
          padding: EdgeInsets.only(top: 110),
          //itemExtent: 50,
          itemCount: snapshot.data.listaGenerica.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(), 
                children: [
                  SlidableAction(
                    onPressed: (value){print(value);},
                    label: 'Borrar',
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,)
                ]),
              child: TarjetaWidget(
               ancho: double.infinity,
                alto: 120.0,
                color1: PreferenciasUsuario.esModoOscuro ? Colors.grey.shade800 : Colors.white,
                color2: Colors.green,
                titulo: snapshot.data.listaGenerica[index].nombre,
                ontap: (){ 
                  sucursalesServices.sucursalSeleccionada = snapshot.data.listaGenerica[index].idSucursal;
                  Navigator.pushNamed(context, 'MisCanchas');
                  },
                  icono: FontAwesomeIcons.building,
                      ),
            );
          },
        
        );

      }
        
    }
    return const Center(child: CircularProgressIndicator());



      },
    );

  }
  }