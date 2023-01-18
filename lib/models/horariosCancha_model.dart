// To parse this JSON data, do
//
//     final horariosCanchaResponse = horariosCanchaResponseFromJson(jsonString);

import 'dart:convert';

HorariosCanchaResponse horariosCanchaResponseFromJson(String str) => HorariosCanchaResponse.fromJson(json.decode(str));

String horariosCanchaResponseToJson(HorariosCanchaResponse data) => json.encode(data.toJson());

class HorariosCanchaResponse {
    HorariosCanchaResponse({
        this.codigoRespuesta,
        this.descripcionRespuesta,
        this.listaGenerica,
        this.objeto,
        this.infoAdicional,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    dynamic listaGenerica;
    Objeto objeto;
    dynamic infoAdicional;

    factory HorariosCanchaResponse.fromJson(Map<String, dynamic> json) => HorariosCanchaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"],
        listaGenerica: json["ListaGenerica"],
        objeto: Objeto.fromJson(json["Objeto"]),
        infoAdicional: json["InfoAdicional"],
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": listaGenerica,
        "Objeto": objeto.toJson(),
        "InfoAdicional": infoAdicional,
    };
}

class Objeto {
    Objeto({
        this.idSucursal,
        this.idEmpresa,
        this.nombreEmpresa,
        this.nombre,
        this.direccionExacta,
        this.latitud,
        this.longitud,
        this.telefono,
        this.correo,
        this.estado,
        this.ubicacion,
        this.imagen,
        this.canchas,
        this.atributos,
    });

    int idSucursal;
    int idEmpresa;
    dynamic nombreEmpresa;
    dynamic nombre;
    dynamic direccionExacta;
    int latitud;
    int longitud;
    dynamic telefono;
    dynamic correo;
    dynamic estado;
    dynamic ubicacion;
    dynamic imagen;
    List<Cancha> canchas;
    dynamic atributos;

    factory Objeto.fromJson(Map<String, dynamic> json) => Objeto(
        idSucursal: json["IdSucursal"],
        idEmpresa: json["IdEmpresa"],
        nombreEmpresa: json["NombreEmpresa"],
        nombre: json["Nombre"],
        direccionExacta: json["DireccionExacta"],
        latitud: json["Latitud"],
        longitud: json["Longitud"],
        telefono: json["Telefono"],
        correo: json["Correo"],
        estado: json["Estado"],
        ubicacion: json["Ubicacion"],
        imagen: json["Imagen"],
        canchas: List<Cancha>.from(json["Canchas"].map((x) => Cancha.fromJson(x))),
        atributos: json["Atributos"],
    );

    Map<String, dynamic> toJson() => {
        "IdSucursal": idSucursal,
        "IdEmpresa": idEmpresa,
        "NombreEmpresa": nombreEmpresa,
        "Nombre": nombre,
        "DireccionExacta": direccionExacta,
        "Latitud": latitud,
        "Longitud": longitud,
        "Telefono": telefono,
        "Correo": correo,
        "Estado": estado,
        "Ubicacion": ubicacion,
        "Imagen": imagen,
        "Canchas": List<dynamic>.from(canchas.map((x) => x.toJson())),
        "Atributos": atributos,
    };
}

class Cancha {
    Cancha({
        this.idCancha,
        this.nombre,
        this.estado,
        this.horarios,
    });

    int idCancha;
    String nombre;
    dynamic estado;
    List<Horario> horarios;

    factory Cancha.fromJson(Map<String, dynamic> json) => Cancha(
        idCancha: json["IdCancha"],
        nombre: json["Nombre"],
        estado: json["Estado"],
        horarios: List<Horario>.from(json["Horarios"].map((x) => Horario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "IdCancha": idCancha,
        "Nombre": nombre,
        "Estado": estado,
        "Horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
    };
}

class Horario {
    Horario({
        this.idHorario,
        this.horaInicio,
        this.horaFin,
        this.diaSemana,
        this.estado,
        this.reserva,
    });

    int idHorario;
    String horaInicio;
    String horaFin;
    dynamic diaSemana;
    dynamic estado;
    Reserva reserva;

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        idHorario: json["IdHorario"],
        horaInicio: json["HoraInicio"],
        horaFin: json["HoraFin"],
        diaSemana: json["DiaSemana"],
        estado: json["Estado"],
        reserva: Reserva.fromJson(json["Reserva"]),
    );

    Map<String, dynamic> toJson() => {
        "IdHorario": idHorario,
        "HoraInicio": horaInicio,
        "HoraFin": horaFin,
        "DiaSemana": diaSemana,
        "Estado": estado,
        "Reserva": reserva.toJson(),
    };
}

class Reserva {
    Reserva({
        idReserva,
        equipo1,
        this.equipo2,
        this.indLlevaDosEquipos,
        this.estado,
        this.fecha,
    });

    int idReserva;
    Equipo equipo1;
    Equipo equipo2;
    bool indLlevaDosEquipos;
    dynamic estado;
    DateTime fecha;

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        idReserva: json["IdReserva"],
        equipo1: Equipo.fromJson(json["Equipo1"]),
        equipo2: Equipo.fromJson(json["Equipo2"]),
        indLlevaDosEquipos: json["IndLlevaDosEquipos"],
        estado: json["Estado"],
        fecha: DateTime.parse(json["Fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "IdReserva": idReserva,
        "Equipo1": equipo1.toJson(),
        "Equipo2": equipo2.toJson(),
        "IndLlevaDosEquipos": indLlevaDosEquipos,
        "Estado": estado,
        "Fecha": fecha.toIso8601String(),
    };
}

class Equipo {
    Equipo({
        this.idUsuario,
        this.nombre,
        this.primerApellido,
        this.segundoApelldo,
        this.email,
        this.telefono,
        this.direccion,
        this.estado,
        this.codUsuario,
        this.contrasenia,
        this.usuarioEmpresa,
        this.empresaLogueada,
        this.permiteNotificar,
    });

    int idUsuario;
    String nombre;
    dynamic primerApellido;
    dynamic segundoApelldo;
    dynamic email;
    dynamic telefono;
    dynamic direccion;
    dynamic estado;
    dynamic codUsuario;
    dynamic contrasenia;
    dynamic usuarioEmpresa;
    dynamic empresaLogueada;
    bool permiteNotificar;

    factory Equipo.fromJson(Map<String, dynamic> json) => Equipo(
        idUsuario: json["IdUsuario"],
        nombre: json["Nombre"],
        primerApellido: json["PrimerApellido"],
        segundoApelldo: json["SegundoApelldo"],
        email: json["Email"],
        telefono: json["Telefono"],
        direccion: json["Direccion"],
        estado: json["Estado"],
        codUsuario: json["CodUsuario"],
        contrasenia: json["Contrasenia"],
        usuarioEmpresa: json["UsuarioEmpresa"],
        empresaLogueada: json["EmpresaLogueada"],
        permiteNotificar: json["PermiteNotificar"],
    );

    Map<String, dynamic> toJson() => {
        "IdUsuario": idUsuario,
        "Nombre": nombre,
        "PrimerApellido": primerApellido,
        "SegundoApelldo": segundoApelldo,
        "Email": email,
        "Telefono": telefono,
        "Direccion": direccion,
        "Estado": estado,
        "CodUsuario": codUsuario,
        "Contrasenia": contrasenia,
        "UsuarioEmpresa": usuarioEmpresa,
        "EmpresaLogueada": empresaLogueada,
        "PermiteNotificar": permiteNotificar,
    };
}
