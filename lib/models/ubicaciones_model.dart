// To parse this JSON data, do
//
//     final ubicacionesResponse = ubicacionesResponseFromJson(jsonString);

import 'dart:convert';

UbicacionesResponse ubicacionesResponseFromJson(String str) => UbicacionesResponse.fromJson(json.decode(str));

String ubicacionesResponseToJson(UbicacionesResponse data) => json.encode(data.toJson());

class UbicacionesResponse {
    UbicacionesResponse({
        this.codigoRespuesta,
        this.descripcionRespuesta,
        this.listaGenerica,
        this.objeto,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<ListaUbicaciones> listaGenerica;
    dynamic objeto;

    factory UbicacionesResponse.fromJson(Map<String, dynamic> json) => UbicacionesResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"],
        listaGenerica: List<ListaUbicaciones>.from(json["ListaGenerica"].map((x) => ListaUbicaciones.fromJson(x))),
        objeto: json["Objeto"],
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x.toJson())),
        "Objeto": objeto,
    };
}

class ListaUbicaciones {
    ListaUbicaciones({
        this.codigoProvincia,
        this.descripcionProvincia,
        this.cantones,
    });

    int codigoProvincia;
    String descripcionProvincia;
    List<Cantone> cantones;

    factory ListaUbicaciones.fromJson(Map<String, dynamic> json) => ListaUbicaciones(
        codigoProvincia: json["CodigoProvincia"],
        descripcionProvincia: json["DescripcionProvincia"],
        cantones: List<Cantone>.from(json["Cantones"].map((x) => Cantone.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "CodigoProvincia": codigoProvincia,
        "DescripcionProvincia": descripcionProvincia,
        "Cantones": List<dynamic>.from(cantones.map((x) => x.toJson())),
    };
}

class Cantone {
    Cantone({
        this.codigoCanton,
        this.descripcionCanton,
        this.codigoProvincia,
        this.distritos,
    });

    int codigoCanton;
    String descripcionCanton;
    int codigoProvincia;
    List<Distrito> distritos;

    factory Cantone.fromJson(Map<String, dynamic> json) => Cantone(
        codigoCanton: json["CodigoCanton"],
        descripcionCanton: json["DescripcionCanton"],
        codigoProvincia: json["CodigoProvincia"],
        distritos: List<Distrito>.from(json["Distritos"].map((x) => Distrito.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "CodigoCanton": codigoCanton,
        "DescripcionCanton": descripcionCanton,
        "CodigoProvincia": codigoProvincia,
        "Distritos": List<dynamic>.from(distritos.map((x) => x.toJson())),
    };
}

class Distrito {
    Distrito({
        this.codigoDistrito,
        this.descripcionDistrito,
        this.codigoCanton,
    });

    int codigoDistrito;
    String descripcionDistrito;
    int codigoCanton;

    factory Distrito.fromJson(Map<String, dynamic> json) => Distrito(
        codigoDistrito: json["CodigoDistrito"],
        descripcionDistrito: json["DescripcionDistrito"],
        codigoCanton: json["CodigoCanton"],
    );

    Map<String, dynamic> toJson() => {
        "CodigoDistrito": codigoDistrito,
        "DescripcionDistrito": descripcionDistrito,
        "CodigoCanton": codigoCanton,
    };
}
