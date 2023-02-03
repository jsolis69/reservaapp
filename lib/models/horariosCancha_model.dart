// To parse this JSON data, do
//
//     final horariosCanchaResponse = horariosCanchaResponseFromJson(jsonString);

import 'dart:convert';

HorariosCanchaResponse horariosCanchaResponseFromJson(String str) => HorariosCanchaResponse.fromJson(json.decode(str));

String horariosCanchaResponseToJson(HorariosCanchaResponse data) => json.encode(data.toJson());

class HorariosCanchaResponse {
    HorariosCanchaResponse({
        required this.codigoRespuesta,
        required this.descripcionRespuesta,
        required this.listaGenerica,
        required this.objeto,
    });

    int codigoRespuesta;
    String descripcionRespuesta;
    List<dynamic> listaGenerica;
    Objeto objeto;

    factory HorariosCanchaResponse.fromJson(Map<String, dynamic> json) => HorariosCanchaResponse(
        codigoRespuesta: json["CodigoRespuesta"],
        descripcionRespuesta: json["DescripcionRespuesta"],
        listaGenerica: List<dynamic>.from(json["ListaGenerica"].map((x) => x)),
        objeto: Objeto.fromJson(json["Objeto"]),
    );

    Map<String, dynamic> toJson() => {
        "CodigoRespuesta": codigoRespuesta,
        "DescripcionRespuesta": descripcionRespuesta,
        "ListaGenerica": List<dynamic>.from(listaGenerica.map((x) => x)),
        "Objeto": objeto.toJson(),
    };
}

class Objeto {
    Objeto({
        required this.idSucursal,
        required this.idEmpresa,
        required this.nombreEmpresa,
        required this.nombre,
        required this.direccionExacta,
        required this.latitud,
        required this.longitud,
        required this.telefono,
        required this.correo,
        required this.estado,
        required this.imagen,
        required this.canchas,
        required this.atributos,
    });

    int idSucursal;
    int idEmpresa;
    String nombreEmpresa;
    String  nombre;
    String  direccionExacta;
    double latitud;
    double longitud;
    String  telefono;
    String  correo;
    Estado estado;
    String  imagen;
    List<Cancha> canchas;
    List<dynamic> atributos;

    factory Objeto.fromJson(Map<String, dynamic> json) => Objeto(
        idSucursal: json["IdSucursal"],
        idEmpresa: json["IdEmpresa"],
        nombreEmpresa: json["NombreEmpresa"]??'',
        nombre: json["Nombre"]??'',
        direccionExacta: json["DireccionExacta"]??'',
        latitud: json["Latitud"],
        longitud: json["Longitud"],
        telefono: json["Telefono"]??'',
        correo: json["Correo"]??'',
        estado: Estado.fromJson(json["Estado"]),
        imagen: json["Imagen"]??'',
        canchas: List<Cancha>.from(json["Canchas"].map((x) => Cancha.fromJson(x))),
        atributos: List<dynamic>.from(json["Atributos"].map((x) => x)),
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
        "Estado": estado.toJson(),
        "Imagen": imagen,
        "Canchas": List<dynamic>.from(canchas.map((x) => x.toJson())),
        "Atributos": List<dynamic>.from(atributos.map((x) => x)),
    };
}

class Cancha {
    Cancha({
        required this.idCancha,
        required this.nombre,
        required this.estado,
        required this.horarios,
    });

    int idCancha;
    String nombre;
    Estado estado;
    List<Horario> horarios;

    factory Cancha.fromJson(Map<String, dynamic> json) => Cancha(
        idCancha: json["IdCancha"],
        nombre: json["Nombre"],
        estado: Estado.fromJson(json["Estado"]),
        horarios: List<Horario>.from(json["Horarios"].map((x) => Horario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "IdCancha": idCancha,
        "Nombre": nombre,
        "Estado": estado.toJson(),
        "Horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
    };
}

class Estado {
    Estado({
        required this.codigo,
        this.descripcion,
    });

    int codigo;
    dynamic descripcion;

    factory Estado.fromJson(Map<String, dynamic> json) => Estado(
        codigo: json["Codigo"],
        descripcion: json["Descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Descripcion": descripcion,
    };
}

class Horario {
    Horario({
        required this.idHorario,
        required this.horaInicio,
        required this.horaFin,
        required this.diaSemana,
        required this.estado,
        required this.reserva,
    });

    int idHorario;
    String horaInicio;
    String horaFin;
    Estado diaSemana;
    Estado estado;
    Reserva reserva;

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        idHorario: json["IdHorario"],
        horaInicio: json["HoraInicio"],
        horaFin: json["HoraFin"],
        diaSemana: Estado.fromJson(json["DiaSemana"]),
        estado: Estado.fromJson(json["Estado"]),
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
    Estado estado;
    DateTime fecha;

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        idReserva: json["IdReserva"],
        equipo1: Equipo.fromJson(json["Equipo1"]),
        equipo2: Equipo.fromJson(json["Equipo2"]),
        indLlevaDosEquipos: json["IndLlevaDosEquipos"],
        estado: Estado.fromJson(json["Estado"]),
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
        required this.nombre,
        this.primerApellido,
        this.segundoApelldo,
        this.email,
        this.telefono,
        this.direccion,
        required this.estado,
        this.codUsuario,
        this.contrasenia,
        required this.empresa,
        required this.permiteNotificar,
        required this.indEsAdministrador,
    });

    int idUsuario;
    String nombre;
    dynamic primerApellido;
    dynamic segundoApelldo;
    dynamic email;
    dynamic telefono;
    dynamic direccion;
    Estado estado;
    dynamic codUsuario;
    dynamic contrasenia;
    Empresa empresa;
    bool permiteNotificar;
    bool indEsAdministrador;

    factory Equipo.fromJson(Map<String, dynamic> json) => Equipo(
        idUsuario: json["IdUsuario"],
        nombre: json["Nombre"],
        primerApellido: json["PrimerApellido"],
        segundoApelldo: json["SegundoApelldo"],
        email: json["Email"],
        telefono: json["Telefono"],
        direccion: json["Direccion"],
        estado: Estado.fromJson(json["Estado"]),
        codUsuario: json["CodUsuario"],
        contrasenia: json["Contrasenia"],
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
    Estado estado;
    int logo;
    List<dynamic> sucursales;

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
