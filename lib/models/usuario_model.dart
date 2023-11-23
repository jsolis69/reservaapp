import 'dart:convert';
import 'package:reservaapp/models/estado_model.dart';

UsuarioResponse usuarioResponseFromJson(String str) => UsuarioResponse.fromJson(json.decode(str));

String usuarioResponseToJson(UsuarioResponse data) => json.encode(data.toJson());

class UsuarioResponse {
    UsuarioResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
        required this.infoAdicional,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<Usuario> listaGenerica;
    Usuario objeto;
    String infoAdicional;

    factory UsuarioResponse.fromJson(Map<String, dynamic> json) => UsuarioResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"]??'',
        listaGenerica: List<Usuario>.from(json["ListaGenerica"].map((x) => x)),
        objeto: Usuario.fromJson(json["Objeto"]),
        infoAdicional: json["InfoAdicional"]??'',
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<Usuario>.from(listaGenerica.map((x) => x)),
        "Objeto": objeto.toJson(),
        "InfoAdicional": infoAdicional,
    };
}

class Usuario {
    Usuario({
        required this.idUsuario,
        required this.nombre,
        required this.primerApellido,
        required this.segundoApelldo,
        required this.email,
        required this.telefono,
        required this.direccion,
        required this.estado,
        required this.codUsuario,
        required this.contrasenia,
        required this.empresa,
        required this.permiteNotificar,
        required this.indEsAdministrador,
    });

    int idUsuario;
    String nombre;
    String primerApellido;
    String segundoApelldo;
    String email;
    String telefono;
    String direccion;
    Estado estado;
    String codUsuario;
    String contrasenia;
    Empresa empresa;
    bool permiteNotificar;
    bool indEsAdministrador;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["IdUsuario"],
        nombre: json["Nombre"]??'',
        primerApellido: json["PrimerApellido"]??'',
        segundoApelldo: json["SegundoApelldo"]??'',
        email: json["Email"]??'',
        telefono: json["Telefono"]??'',
        direccion: json["Direccion"]??'',
        estado: Estado.fromJson(json["Estado"]),
        codUsuario: json["CodUsuario"]??'',
        contrasenia: json["Contrasenia"]??'',
        empresa: Empresa.fromJson(json["Empresa"]),
        permiteNotificar: json["PermiteNotificar"],
        indEsAdministrador: json["indEsAdministrador"],
    );

    Map<String, dynamic> toJson() => {
        "IdUsuario": idUsuario,
        "Nombre": nombre,
        "PrimerApellido": primerApellido,
        "SegundoApelldo": segundoApelldo,
        "Email": email,
        "Telefono": telefono,
        "Direccion": direccion,
        "Estado": estado.toJson(),
        "CodUsuario": codUsuario,
        "Contrasenia": contrasenia,
        "Empresa": empresa.toJson(),
        "PermiteNotificar": permiteNotificar,
        "indEsAdministrador": indEsAdministrador,
    };
}

class Empresa {
    Empresa({
        required this.idEmpresa,
        required this.nombre,
        required this.telefono,
        required this.correo,
        required this.estado,
        //required this.logo,
        required this.sucursales,
    });

    int idEmpresa;
    String nombre;
    String telefono;
    String correo;
    Estado estado;
    //int logo;
    List<dynamic> sucursales;

    factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        idEmpresa: json["IdEmpresa"],
        nombre: json["Nombre"]??'',
        telefono: json["Telefono"]??'',
        correo: json["Correo"]??'',
        estado: Estado.fromJson(json["Estado"]),
        //logo: json["Logo"]??'',
        sucursales: List<dynamic>.from(json["Sucursales"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "IdEmpresa": idEmpresa,
        "Nombre": nombre,
        "Telefono": telefono,
        "Correo": correo,
        "Estado": estado.toJson(),
        //"Logo": logo,
        "Sucursales": List<dynamic>.from(sucursales.map((x) => x)),
    };
}


