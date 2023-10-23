// To parse this JSON data, do
//
//     final empresaResponse = empresaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:reservaapp/models/estado_model.dart';

EmpresaResponse empresaResponseFromJson(String str) => EmpresaResponse.fromJson(json.decode(str));

String empresaResponseToJson(EmpresaResponse data) => json.encode(data.toJson());

class EmpresaResponse {
    int codigoRespuesta;
    String descripcionRespuesta;
    List<Objeto> listaGenerica;
    Objeto objeto;

    EmpresaResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
    });

    factory EmpresaResponse.fromJson(Map<String, dynamic> json) => EmpresaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"],
        listaGenerica: List<Objeto>.from(json["ListaGenerica"].map((x) => Objeto.fromJson(x))),
        objeto: Objeto.fromJson(json["Objeto"]),
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x.toJson())),
        "Objeto": objeto.toJson(),
    };
}

class Objeto {
    int idEmpresa;
    String? nombre;
    String? telefono;
    String? correo;
    Estado estado;
    dynamic logo;
    List<dynamic> sucursales;

    Objeto({
        required this.idEmpresa,
        required this.nombre,
        required this.telefono,
        required this.correo,
        required this.estado,
        required this.logo,
        required this.sucursales,
    });

    factory Objeto.fromJson(Map<String, dynamic> json) => Objeto(
        idEmpresa: json["IdEmpresa"],
        nombre: json["Nombre"],
        telefono: json["Telefono"],
        correo: json["Correo"],
        estado: Estado.fromJson(json["Estado"]),
        logo: json["Logo"],
        sucursales: List<dynamic>.from(json["Sucursales"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "IdEmpresa": idEmpresa,
        "Nombre": nombre,
        "Telefono": telefono,
        "Correo": correo,
        "Estado": estado.toJson(),
        "Logo": logo,
        "Sucursales": List<dynamic>.from(sucursales.map((x) => x)),
    };
}
