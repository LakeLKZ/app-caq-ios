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