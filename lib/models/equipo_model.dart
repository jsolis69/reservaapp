import 'package:reservaapp/models/empresa_model.dart';
import 'package:reservaapp/models/estado_model.dart';

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
    Estado estado;
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