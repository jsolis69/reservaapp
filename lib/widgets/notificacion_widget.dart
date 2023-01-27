import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaapp/models/notificacion_model.dart';

class NotificacionWidget extends StatelessWidget {
  const NotificacionWidget({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {


    final notificacionModel = Provider.of<NotificacionModel>(context);

    return BounceInDown(
     animate: notificacionModel.mostrarAlerta,
      child: Container(
       height: 40,
       width: double.infinity,
       color: notificacionModel.codigo == 0 ? Colors.lightGreen : notificacionModel.codigo == 3 ? Colors.orange : Colors.red,
       child: Center(child: Text(notificacionModel.descripcion, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 18),)),
                ),
    );
  }
}