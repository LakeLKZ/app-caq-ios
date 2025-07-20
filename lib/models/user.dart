// models/user.dart
class User {
  final int id;
  final String nombre;
  final String apellido;
  final String dni;
  final String email;
  final String whatsapp;
  final String tomo;
  final String folio;
  final int colegioId;

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.email,
    required this.whatsapp,
    required this.tomo,
    required this.folio,
    required this.colegioId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      dni: json['dni'] ?? '',
      email: json['email'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      tomo: json['tomo'] ?? '',
      folio: json['folio'] ?? '',
      colegioId: json['colegio_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'dni': dni,
      'email': email,
      'whatsapp': whatsapp,
      'tomo': tomo,
      'folio': folio,
      'colegio_id': colegioId,
    };
  }

  String get nombreCompleto => '$nombre $apellido';
}

class Colegio {
  final int id;
  final String nombre;
  final bool activo;

  Colegio({
    required this.id,
    required this.nombre,
    required this.activo,
  });

  factory Colegio.fromJson(Map<String, dynamic> json) {
    return Colegio(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      activo: json['activo'] ?? false,
    );
  }
}

class AuthResponse {
  final int resultado;
  final String mensaje;
  final User? usuario;
  final int? usuarioId;

  AuthResponse({
    required this.resultado,
    required this.mensaje,
    this.usuario,
    this.usuarioId,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      resultado: json['resultado'] ?? 0,
      mensaje: json['mensaje'] ?? '',
      usuario: json['usuario'] != null ? User.fromJson(json['usuario']) : null,
      usuarioId: json['usuarioId'],
    );
  }

  bool get isSuccess => resultado == 1;
}