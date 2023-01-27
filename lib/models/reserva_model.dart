// To parse this JSON data, do
//
//     final insertarReservaResponse = insertarReservaResponseFromJson(jsonString);

import 'dart:convert';

InsertarReservaResponse insertarReservaResponseFromJson(String str) => InsertarReservaResponse.fromJson(json.decode(str));

String insertarReservaResponseToJson(InsertarReservaResponse data) => json.encode(data.toJson());

class InsertarReservaResponse {
    InsertarReservaResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<dynamic> listaGenerica;
    String objeto;

    factory InsertarReservaResponse.fromJson(Map<String, dynamic> json) => InsertarReservaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"]??'',
        listaGenerica: List<dynamic>.from(json["ListaGenerica"].map((x) => x)),
        objeto: json["Objeto"]??'',
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x)),
        "Objeto": objeto,
    };
}
