import 'package:flutter/material.dart';

class InputPersonalizado extends StatelessWidget {
  final IconData icono;
  final String placeholder;
  final ValueChanged onChange;
  //final TextEditingController textController;
  final TextInputType tipoTeclado;
  final bool esPassword;
  final String tipoPassword;
  final bool estaHabilitado;
  final String valorDefecto;

  const InputPersonalizado({super.key, 
    required this.icono, 
    required this.placeholder,
    required this.onChange,
    //required this.textController, 
    this.tipoTeclado = TextInputType.text,
    this.esPassword = false, 
    this.tipoPassword = '*',
    this.estaHabilitado = true,
    this.valorDefecto = ''
  }); 
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
       margin: const EdgeInsets.only(bottom: 20),
       decoration: BoxDecoration(
         color: estaHabilitado ? Colors.white : Colors.grey.shade400,
         borderRadius: BorderRadius.circular(20),
         boxShadow: <BoxShadow>[
           BoxShadow(color: Colors.black.withOpacity(0.05)
           , offset: const Offset(0, 5),
           blurRadius: 5
           )
         ]
       ),
       child: TextFormField(
        initialValue: valorDefecto,
        style: const TextStyle( color: Colors.black45),
        //controller: TextEditingController(text: valorDefecto),
          //readOnly: true,
          enabled: estaHabilitado ? true : false,
         autocorrect: false,
         keyboardType: tipoTeclado,
         obscureText: esPassword,
         obscuringCharacter: tipoPassword,
         decoration: InputDecoration(
           prefixIcon: Icon(icono, color: Colors.black45,),
           focusedBorder: InputBorder.none,
           border:  InputBorder.none,
           hintText: placeholder,
           //errorText: textController.text,
           hintStyle: const TextStyle(
            color: Colors.black45,
           )
         ),
         onChanged: onChange,
       ),
      );
  }
}