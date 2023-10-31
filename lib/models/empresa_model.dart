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
    List<Empresa> listaGenerica;
    Empresa objeto;

    EmpresaResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
    });

    factory EmpresaResponse.fromJson(Map<String, dynamic> json) => EmpresaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"],
        listaGenerica: List<Empresa>.from(json["ListaGenerica"].map((x) => Empresa.fromJson(x))),
        objeto: Empresa.fromJson(json["Objeto"]),
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x.toJson())),
        "Objeto": objeto.toJson(),
    };
}

class Empresa {
    int idEmpresa;
    String? nombre;
    String? telefono;
    String? correo;
    Estado estado;
    dynamic logo;
    List<dynamic> sucursales;

    Empresa({
        required this.idEmpresa,
        required this.nombre,
        required this.telefono,
        required this.correo,
        required this.estado,
        required this.logo,
        required this.sucursales,
    });

    factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
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
