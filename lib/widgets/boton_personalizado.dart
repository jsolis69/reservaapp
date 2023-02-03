import 'package:flutter/material.dart';
import 'package:reservaapp/widgets/etiqueta_personalizada.dart';

class BotonPersonalizado extends StatelessWidget {

  final String texto;
  final VoidCallback  onPressed;
  final bool validador; 

  const BotonPersonalizado({super.key, 
  required this.texto, 
  required this.onPressed, 
  required this.validador});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: validador ? onPressed : null,
            
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
                shape: const StadiumBorder(),
              ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: Center(
                child: 
                  EtiquetaPersonalizada(descripcion: texto, tamano: 25)
              )
            )

    );
  }
}