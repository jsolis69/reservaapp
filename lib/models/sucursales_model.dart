// To parse this JSON data, do
//
//     final sucursalesXUbicacionResponse = sucursalesXUbicacionResponseFromJson(jsonString);

import 'dart:convert';

SucursalesXUbicacionResponse sucursalesXUbicacionResponseFromJson(String str) => SucursalesXUbicacionResponse.fromJson(json.decode(str));

String sucursalesXUbicacionResponseToJson(SucursalesXUbicacionResponse data) => json.encode(data.toJson());

class SucursalesXUbicacionResponse {
    SucursalesXUbicacionResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        this.objeto,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<Sucursal> listaGenerica;
    dynamic objeto;

    factory SucursalesXUbicacionResponse.fromJson(Map<String, dynamic> json) => SucursalesXUbicacionResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"],
        listaGenerica: List<Sucursal>.from(json["ListaGenerica"].map((x) => Sucursal.fromJson(x))),
        objeto: json["Objeto"],
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x.toJson())),
        "Objeto": objeto,
    };
}

class Sucursal {
    Sucursal({
        required this.idSucursal,
        required this.idEmpresa,
        required this.NombreEmpresa,
        required this.nombre,
        this.direccionExacta,
        required this.latitud,
        required this.longitud,
        this.telefono,
        this.correo,
        this.estado,
        this.ubicacion,
        //required this.imagen,
        this.canchas,
    });

    int idSucursal;
    int idEmpresa;
    String NombreEmpresa;
    String nombre;
    dynamic direccionExacta;
    double latitud;
    double longitud;
    dynamic telefono;
    dynamic correo;
    dynamic estado;
    dynamic ubicacion;
    //int imagen;
    dynamic canchas;

    factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        idSucursal: json["IdSucursal"],
        idEmpresa: json["IdEmpresa"],
        NombreEmpresa: json["NombreEmpresa"]??'',
        nombre: json["Nombre"]??'',
        direccionExacta: json["DireccionExacta"],
        latitud: json["Latitud"],
        longitud: json["Longitud"],
        telefono: json["Telefono"],
        correo: json["Correo"],
        estado: json["Estado"],
        ubicacion: json["Ubicacion"],
        //imagen: json["Imagen"]??'',
        canchas: json["Canchas"],
    );

    Map<String, dynamic> toJson() => {
        "IdSucursal": idSucursal,
        "IdEmpresa": idEmpresa,
        "NombreEmpresa": NombreEmpresa,
        "Nombre": nombre,
        "DireccionExacta": direccionExacta,
        "Latitud": latitud,
        "Longitud": longitud,
        "Telefono": telefono,
        "Correo": correo,
        "Estado": estado,
        "Ubicacion": ubicacion,
        //"Imagen": imagen,
        "Canchas": canchas,
    };
}
