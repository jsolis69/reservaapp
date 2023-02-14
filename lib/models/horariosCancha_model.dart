// To parse this JSON data, do
//
//     final horariosResponse = horariosResponseFromJson(jsonString);

import 'dart:convert';

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
        descripcionRespuesta: json["DescripcionRespuesta"],
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
    });

    int idHorario;
    String? horaInicio;
    String? horaFin;
    DiaSemana diaSemana;
    DiaSemana estado;
    Reserva reserva;

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        idHorario: json["IdHorario"],
        horaInicio: json["HoraInicio"],
        horaFin: json["HoraFin"],
        diaSemana: DiaSemana.fromJson(json["DiaSemana"]),
        estado: DiaSemana.fromJson(json["Estado"]),
        reserva: Reserva.fromJson(json["Reserva"]),
    );

    Map<String, dynamic> toJson() => {
        "IdHorario": idHorario,
        "HoraInicio": horaInicio,
        "HoraFin": horaFin,
        "DiaSemana": diaSemana.toJson(),
        "Estado": estado.toJson(),
        "Reserva": reserva.toJson(),
    };
}

class DiaSemana {
    DiaSemana({
        required this.codigo,
        this.descripcion,
    });

    int codigo;
    dynamic descripcion;

    factory DiaSemana.fromJson(Map<String, dynamic> json) => DiaSemana(
        codigo: json["Codigo"],
        descripcion: json["Descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Descripcion": descripcion,
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
    DiaSemana estado;
    DateTime fecha;

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        idReserva: json["IdReserva"],
        equipo1: Equipo.fromJson(json["Equipo1"]),
        equipo2: Equipo.fromJson(json["Equipo2"]),
        indLlevaDosEquipos: json["IndLlevaDosEquipos"],
        estado: DiaSemana.fromJson(json["Estado"]),
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

class Equipo {
    Equipo({
        required this.idUsuario,
        this.nombre,
        this.email,
        this.telefono,
        required this.estado,
        this.codUsuario,
        this.contrasenia,
        required this.empresa,
        required this.permiteNotificar,
        required this.indEsAdministrador,
    });

    int idUsuario;
    String? nombre;
    dynamic email;
    dynamic telefono;
    DiaSemana estado;
    dynamic codUsuario;
    dynamic contrasenia;
    Empresa empresa;
    bool permiteNotificar;
    bool indEsAdministrador;

    factory Equipo.fromJson(Map<String, dynamic> json) => Equipo(
        idUsuario: json["IdUsuario"],
        nombre: json["Nombre"],
        email: json["Email"],
        telefono: json["Telefono"],
        estado: DiaSemana.fromJson(json["Estado"]),
        codUsuario: json["CodUsuario"],
        contrasenia: json["Contrasenia"],
        empresa: Empresa.fromJson(json["Empresa"]),
        permiteNotificar: json["PermiteNotificar"],
        indEsAdministrador: json["indEsAdministrador"],
    );

    Map<String, dynamic> toJson() => {
        "IdUsuario": idUsuario,
        "Nombre": nombre,
        "Email": email,
        "Telefono": telefono,
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
        this.nombre,
        this.telefono,
        this.correo,
        required this.estado,
        required this.logo,
        required this.sucursales,
    });

    int idEmpresa;
    dynamic nombre;
    dynamic telefono;
    dynamic correo;
    DiaSemana estado;
    int logo;
    List<dynamic> sucursales;

    factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        idEmpresa: json["IdEmpresa"],
        nombre: json["Nombre"],
        telefono: json["Telefono"],
        correo: json["Correo"],
        estado: DiaSemana.fromJson(json["Estado"]),
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
