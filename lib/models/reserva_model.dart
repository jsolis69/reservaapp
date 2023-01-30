// To parse this JSON data, do
//
//     final reservaResponse = reservaResponseFromJson(jsonString);

import 'dart:convert';

ReservaResponse reservaResponseFromJson(String str) => ReservaResponse.fromJson(json.decode(str));

String reservaResponseToJson(ReservaResponse data) => json.encode(data.toJson());

class ReservaResponse {
    ReservaResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<dynamic> listaGenerica;
    String objeto;

    factory ReservaResponse.fromJson(Map<String, dynamic> json) => ReservaResponse(
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
