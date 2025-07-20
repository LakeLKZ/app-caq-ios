// models.dart - Archivo de modelos de datos

// Modelo para Novedades (carrusel en Home)
class Novedad {
  final int id;
  final String imageUrl;
  final String title;
  final String description;

  Novedad({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  factory Novedad.fromJson(Map<String, dynamic> json) {
    return Novedad(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
    );
  }
}

// Modelo para Valores Importantes (grid 2x2 en Home)
class ValorImportante {
  final int id;
  final double value;  // Cambiado de int a double
  final String label;

  ValorImportante({
    required this.id,
    required this.value,
    required this.label,
  });

  factory ValorImportante.fromJson(Map<String, dynamic> json) {
    // Convertir value a double si viene como int
    final dynamic rawValue = json['value'];
    final double doubleValue = rawValue is int 
        ? rawValue.toDouble() 
        : rawValue;
    
    return ValorImportante(
      id: json['id'],
      value: doubleValue,
      label: json['label'],
    );
  }
}


// Modelo para Cursos (listado vertical en pantalla Cursos)
class Curso {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final String  date;

  Curso({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }

  String get formattedDate {
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
    } catch (e) {
      return date; // Si hay error en el parsing, devolver la fecha original
    }
  }

}

// Modelo para Matrículas (objeto único en Home)
class Matricula {
  final double price;  // Cambiado de int a double
  final String date;

  Matricula({
    required this.price,
    required this.date,
  });

  factory Matricula.fromJson(Map<String, dynamic> json) {
    // Convertir price a double si viene como int
    final dynamic rawPrice = json['price'];
    final double doublePrice = rawPrice is int 
        ? rawPrice.toDouble() 
        : rawPrice;
    
    return Matricula(
      price: doublePrice,
      date: json['date'],
    );
  }

  // Getter para formatear el precio como string con formato de moneda
  String get formattedPrice {
    return "\$${price.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.'
    )}";
  }

  // Getter para formatear la fecha
  String get formattedDate {
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
    } catch (e) {
      return date; // Si hay error en el parsing, devolver la fecha original
    }
  }
}

// Modelo para Contacto (pantalla Contacto)
class ContactoItem {
  final String type;
  final String title;
  final String number;

  ContactoItem({
    required this.type,
    required this.title,
    required this.number,
  });
}

// models/tasa_justicia.dart
class TasaJusticia {
  final String articulo;
  final String inciso;
  final String descripcion;
  final String valor;
  final TipoTasa tipo;

  TasaJusticia({
    required this.articulo,
    required this.inciso,
    required this.descripcion,
    required this.valor,
    required this.tipo,
  });

  // Getter para obtener el texto completo para búsqueda
  String get textoCompleto {
    return '${articulo} ${inciso} ${descripcion} ${valor}'.toLowerCase();
  }

  // Getter para mostrar el título formateado
  String get tituloFormateado {
    if (inciso.isNotEmpty) {
      return '${articulo} ${inciso}';
    }
    return articulo;
  }
}

enum TipoTasa {
  porcentual,
  fijo,
  porMil,
}

class TasasJusticiaData {
  static List<TasaJusticia> obtenerTodasLasTasas() {
    return [
      // ART. 77
      TasaJusticia(
        articulo: 'ART. 77',
        inciso: 'a)',
        descripcion: 'Tasa Justicia valores determinados o determinables',
        valor: '22 por mil',
        tipo: TipoTasa.porMil,
      ),
      TasaJusticia(
        articulo: 'ART. 77',
        inciso: 'b)',
        descripcion: 'Tasa Justicia valor mínimo',
        valor: '\$743,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 77',
        inciso: 'c)',
        descripcion: 'Tasa Justicia valores indeterminados',
        valor: '\$743,00',
        tipo: TipoTasa.fijo,
      ),
      
      // ART. 78
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'a)',
        descripcion: 'Árbitros y amigables componedores',
        valor: '50 por cien',
        tipo: TipoTasa.porcentual,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'b)',
        descripcion: 'Autorización a incapaces',
        valor: '\$1.290,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'c)',
        descripcion: 'Divorcio inciso 1)',
        valor: '\$7.349,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'c)',
        descripcion: 'Divorcio inciso 2)',
        valor: '10 por mil',
        tipo: TipoTasa.porMil,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'd)',
        descripcion: 'Oficios y exhortos',
        valor: '\$1.686,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'e)',
        descripcion: 'Insania',
        valor: '10 por mil',
        tipo: TipoTasa.porMil,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'f) 1)',
        descripcion: 'Registro público de comercio - Inscripción de matrícula',
        valor: '\$3.688,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'f) 2)',
        descripcion: 'Registro público de comercio - Gestión o certificación',
        valor: '\$743,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'f) 3)',
        descripcion: 'Registro público de comercio - Libro de comercio rubricado',
        valor: '\$743,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'f) 4)',
        descripcion: 'Registro público de comercio - Certificación de firma',
        valor: '\$1.557,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'g)',
        descripcion: 'Protocolizaciones',
        valor: '\$1.290,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'h)',
        descripcion: 'Rehabilitación de concursados',
        valor: '3 por mil',
        tipo: TipoTasa.porMil,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'i)',
        descripcion: 'Sucesorios',
        valor: '22 por mil',
        tipo: TipoTasa.porMil,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'j)',
        descripcion: 'Testimonio',
        valor: '\$78,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 78',
        inciso: 'k)',
        descripcion: 'Justicia de paz letrada',
        valor: 'Tasas del presente título',
        tipo: TipoTasa.fijo,
      ),
      
      // ART. 79
      TasaJusticia(
        articulo: 'ART. 79',
        inciso: '',
        descripcion: 'Justicia Penal - Causas correccionales',
        valor: '\$6.735,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 79',
        inciso: '',
        descripcion: 'Justicia Penal - Causas criminales',
        valor: '\$13.928,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 79',
        inciso: '',
        descripcion: 'Justicia Penal - Presentación particular damnificado',
        valor: '\$3.668,00',
        tipo: TipoTasa.fijo,
      ),
      
      // ART. 80
      TasaJusticia(
        articulo: 'ART. 80',
        inciso: '',
        descripcion: 'Tasa general por actuación de expediente',
        valor: '\$1.050,00',
        tipo: TipoTasa.fijo,
      ),
      TasaJusticia(
        articulo: 'ART. 80',
        inciso: '',
        descripcion: 'Prestaciones de servicios sujetas a retrib. proporc.',
        valor: '\$1.050,00',
        tipo: TipoTasa.fijo,
      ),
    ];
  }
  
}


// Agregar estos modelos a tu archivo models/models.dart existente

// Modelos de Usuario y Autenticación
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