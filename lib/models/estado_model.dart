class Estado {
    Estado({
        required this.codigo,
        this.descripcion,
    });

    int codigo;
    dynamic descripcion;

    factory Estado.fromJson(Map<String, dynamic> json) => Estado(
        codigo: json["Codigo"],
        descripcion: json["Descripcion"]??'',
    );

    Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Descripcion": descripcion,
    };
}