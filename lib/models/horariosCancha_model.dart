import 'dart:convert';
import 'package:reservaapp/models/equipo_model.dart';
import 'package:reservaapp/models/estado_model.dart';
import 'package:reservaapp/utils/utils.dart';

HorariosResponse horariosResponseFromJson(String str) => HorariosResponse.fromJson(json.decode(str));

String horariosResponseToJson(HorariosResponse data) => json.encode(data.toJson());

class HorariosResponse {
    HorariosResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<Horario> listaGenerica;
    Horario objeto;

    factory HorariosResponse.fromJson(Map<String, dynamic> json) => HorariosResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["CodigoRespuesta"] == 99 ? Utilitarios().msjErrorGenerico : json["DescripcionRespuesta"],
        listaGenerica: List<Horario>.from(json["ListaGenerica"].map((x) => Horario.fromJson(x))),
        objeto: Horario.fromJson(json["Objeto"]),
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x.toJson())),
        "Objeto": objeto.toJson(),
    };
}

class Horario {
    Horario({
        required this.idHorario,
        this.horaInicio,
        this.horaFin,
        required this.diaSemana,
        required this.estado,
        required this.reserva,
        required this.seleccionado,
    });

    int idHorario;
    String? horaInicio;
    String? horaFin;
    Estado diaSemana;
    Estado estado;
    Reserva reserva;
    bool seleccionado;

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        idHorario: json["IdHorario"],
        horaInicio: json["HoraInicio"],
        horaFin: json["HoraFin"],
        diaSemana: Estado.fromJson(json["DiaSemana"]),
        estado: Estado.fromJson(json["Estado"]),
        reserva: Reserva.fromJson(json["Reserva"]),
        seleccionado: json["Seleccionado"],
    );

    Map<String, dynamic> toJson() => {
        "IdHorario": idHorario,
        "HoraInicio": horaInicio,
        "HoraFin": horaFin,
        "DiaSemana": diaSemana.toJson(),
        "Estado": estado.toJson(),
        "Reserva": reserva.toJson(),
        "Seleccionado": seleccionado,
    };
}

class Reserva {
    Reserva({
        required this.idReserva,
        required this.equipo1,
        required this.equipo2,
        required this.indLlevaDosEquipos,
        required this.estado,
        required this.fecha,
    });

    int idReserva;
    Equipo equipo1;
    Equipo equipo2;
    bool indLlevaDosEquipos;
    Estado estado;
    DateTime fecha;

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        idReserva: json["IdReserva"],
        equipo1: Equipo.fromJson(json["Equipo1"]),
        equipo2: Equipo.fromJson(json["Equipo2"]),
        indLlevaDosEquipos: json["IndLlevaDosEquipos"],
        estado: Estado.fromJson(json["Estado"]),
        fecha: DateTime.parse(json["Fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "IdReserva": idReserva,
        "Equipo1": equipo1.toJson(),
        "Equipo2": equipo2.toJson(),
        "IndLlevaDosEquipos": indLlevaDosEquipos,
        "Estado": estado.toJson(),
        "Fecha": fecha.toIso8601String(),
    };
}


