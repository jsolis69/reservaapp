import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:http/http.dart' as http;


class HorarioProvider with ChangeNotifier
{

  //List<Horario> misHorarios = [];
   List<Horario> _horariosXCancha = [];
   List<Horario> _horariosXReserva = [];



  Horario _horarioSeleccionado = new Horario(
    idHorario: 0, 
    seleccionado: false,
    diaSemana: 
    new CatalogoGenerico(
      codigo: 0
    ), 
    estado: new CatalogoGenerico(
      codigo: 0
    ), 
    reserva: new Reserva(
      idReserva: 0, 
      estado: CatalogoGenerico(codigo: 0),
      indLlevaDosEquipos: false,
      fecha: DateTime.now(),
      equipo1: new Equipo(
        idUsuario: 0, 
        estado: new CatalogoGenerico(codigo: 0), 
        empresa: new Empresa(
          idEmpresa: 0, 
          estado: new CatalogoGenerico(codigo: 0), 
          logo: 0,
          sucursales: []
        ),
        permiteNotificar: false, 
        indEsAdministrador: false
      ), 
      equipo2: new Equipo(
        idUsuario: 0, 
        estado: new CatalogoGenerico(codigo: 0), 
        empresa: new Empresa(
          idEmpresa: 0, 
          estado: new CatalogoGenerico(codigo: 0), 
          logo: 0,
          sucursales: []
        ),
        permiteNotificar: false, 
        indEsAdministrador: false
        )));

  Horario get horarioSeleccionado => _horarioSeleccionado;
  set horarioSeleccionado(Horario horario){
    _horarioSeleccionado = horario;
    notifyListeners();
    }



  List<Horario> get horariosXCancha => _horariosXCancha;
  set horariosXCancha(List<Horario> valor){
    _horariosXCancha = valor;
    notifyListeners();
  }
  
  List<Horario> get horariosXReserva => _horariosXReserva;
  set horariosXReserva(List<Horario> valor){
    _horariosXReserva = valor;
    notifyListeners();
  }

  
  ObtenerMisHorarios(int pIdCancha) async {
   
    
 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/ObtenerHorario');

 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdCancha': pIdCancha.toString(),
    }));


  //misHorarios = [];
  horariosXCancha = [];
  var HorariosResponse = horariosResponseFromJson(response.body);

  horariosXCancha = HorariosResponse.listaGenerica;
  //misHorarios = [...misHorarios, ...HorariosResponse.listaGenerica];
  
  //return listaCanchas;
  //notifyListeners();
  }


  //api/Horario/InsertarHorarioCancha

  InsertarHorarioCancha(int pIdCancha, int pIdHoraio, bool? estado) async {
var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/InsertarHorarioCancha');

 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdCancha': pIdCancha.toString(),
  'Horarios': [{
    'IdHorario': pIdHoraio.toString(),
    'Estado': {
      'Codigo': estado == true ? 1 : 2
    }
  }]
    }));


  //misHorarios = [];
  horariosXCancha = [];
  var HorariosResponse = horariosResponseFromJson(response.body);

  horariosXCancha = HorariosResponse.listaGenerica;
  //misHorarios = [...misHorarios, ...HorariosResponse.listaGenerica];
  
  //return listaCanchas;
  notifyListeners();
  }


ObtenerHorarioPorCancha(int idSucursal, String fecha) async {
   

 var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/ObtenerHorarioPorCancha');

 final response = await http.post(url,
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 body: jsonEncode({
  'IdCancha': idSucursal.toString(),
  'Horarios':[
        { 
          'Reserva': { 
            'Fecha': fecha
          }
        }
      ]
    }));


  horariosXReserva = [];
  var HorariosResponse = horariosResponseFromJson(response.body);
  horariosXReserva = HorariosResponse.listaGenerica;
  notifyListeners();
  //return HorariosResponse;
  
  }


}