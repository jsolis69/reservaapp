import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reservaapp/models/empresa_model.dart';
import 'package:reservaapp/models/equipo_model.dart';
import 'package:reservaapp/models/estado_model.dart';
import 'package:reservaapp/models/horariosCancha_model.dart';
import 'package:reservaapp/utils/utils.dart';
import 'package:http/http.dart' as http;


class HorarioProvider with ChangeNotifier
{
  List<Horario> _horariosXCancha = [];
  List<Horario> _horariosXReserva = [];
   
  int _respuestaServicio = 97; //procesando
  int get respuestaServicio => _respuestaServicio;
  set respuestaServicio(int resp){
    _respuestaServicio = resp;
    notifyListeners();
   }

  Horario _horarioSeleccionado = new Horario(
    idHorario: 0, 
    seleccionado: false,
    diaSemana: 
    new Estado(
      codigo: 0
    ), 
    estado: new Estado(
      codigo: 0
    ), 
    reserva: new Reserva(
      idReserva: 0, 
      estado: Estado(codigo: 0),
      indLlevaDosEquipos: false,
      fecha: DateTime.now(),
      equipo1: new Equipo(
        idUsuario: 0, 
        estado: new Estado(codigo: 0), 
        empresa: new Empresa(
          nombre: '',
          telefono: '',
          correo: '',
          idEmpresa: 0, 
          estado: new Estado(codigo: 0), 
          logo: 0,
          sucursales: []
        ),
        permiteNotificar: false, 
        indEsAdministrador: false
      ), 
      equipo2: new Equipo(
        idUsuario: 0, 
        estado: new Estado(codigo: 0), 
        empresa: new Empresa(
          nombre: '',
          telefono: '',
          correo: '',
          idEmpresa: 0, 
          estado: new Estado(codigo: 0), 
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
      headers: Utilitarios().header,
      body: jsonEncode({
        'IdCancha': pIdCancha.toString(),
      })
    );
    
    horariosXCancha = [];
    var HorariosResponse = horariosResponseFromJson(response.body);

    horariosXCancha = HorariosResponse.listaGenerica;
  }

  InsertarHorarioCancha(int pIdCancha, int pIdHoraio, bool? estado) async {
    
    var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/InsertarHorarioCancha');
    final response = await http.post(url,
      headers: Utilitarios().header,
      body: jsonEncode({
        'IdCancha': pIdCancha.toString(),
        'Horarios': [{
          'IdHorario': pIdHoraio.toString(),
          'Estado': {
            'Codigo': estado == true ? 1 : 2
          }
        }]
      })
    );
    
    horariosXCancha = [];
    var HorariosResponse = horariosResponseFromJson(response.body);
    horariosXCancha = HorariosResponse.listaGenerica;
  }
  //TODO: Este método se está llamando muchisimas veces
  //Hay que revisar
  ObtenerHorarioPorCancha(int idSucursal, String fecha) async {
    
    var url = Uri.http( Utilitarios().urlWebapi, '/Reserva.API/api/Horario/ObtenerHorarioPorCancha');
    final response = await http.post(
      url,
      headers: Utilitarios().header,
      body: jsonEncode({
        'IdCancha': idSucursal.toString(),
        'Horarios':[{ 
          'Reserva': { 
            'Fecha': fecha
          }
        }]
      })
    );
    
    horariosXReserva = [];
    var HorariosResponse = horariosResponseFromJson(response.body);

    if(HorariosResponse.codigoRespuesta == 0)
    {
      respuestaServicio = HorariosResponse.codigoRespuesta;
      horariosXReserva = HorariosResponse.listaGenerica;
    }
  }
}