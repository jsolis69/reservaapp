import 'dart:convert';

import 'package:reservaapp/models/estado_model.dart';

CanchaResponse canchaResponseFromJson(String str) => CanchaResponse.fromJson(json.decode(str));

String canchaResponseToJson(CanchaResponse data) => json.encode(data.toJson());

class CanchaResponse {
    CanchaResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<Cancha> listaGenerica;
    Cancha objeto;

    factory CanchaResponse.fromJson(Map<String, dynamic> json) => CanchaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"]??'',
        listaGenerica: List<Cancha>.from(json["ListaGenerica"].map((x) => Cancha.fromJson(x))),
        objeto: Cancha.fromJson(json["Objeto"]),
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x.toJson())),
        "Objeto": objeto.toJson(),
    };
}

class Cancha {
    Cancha({
        required this.idCancha,
        this.nombre,
        required this.estado,
        required this.horarios,
    });

    int idCancha;
    String? nombre;
    Estado estado;
    List<dynamic> horarios;

    factory Cancha.fromJson(Map<String, dynamic> json) => Cancha(
        idCancha: json["IdCancha"]??'',
        nombre: json["Nombre"]??'',
        estado: Estado.fromJson(json["Estado"]),
        horarios: List<dynamic>.from(json["Horarios"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "IdCancha": idCancha,
        "Nombre": nombre,
        "Estado": estado.toJson(),
        "Horarios": List<dynamic>.from(horarios.map((x) => x)),
    };
}


