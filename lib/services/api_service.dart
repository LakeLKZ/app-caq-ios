// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../config/config.dart';

// Servicio para manejar las llamadas a la API
class ApiService {
  // URL base de la API desde la configuración
  final String baseUrl = AppConfig.apiBaseUrl;
  
  // Cliente HTTP seguro que acepta certificados autofirmados
  final http.Client _httpClient;
  
  // Cache de datos para evitar cargas repetidas
  List<Novedad>? _novedadesCache;
  List<ValorImportante>? _valoresCache;
  List<Curso>? _cursosCache;
  Matricula? _matriculaCache;
  List<ContactoItem>? _contactosCache;
  DateTime? _lastUpdateTime;
  
  // Tiempo de expiración del cache (1 hora)
  final Duration _cacheExpiration = Duration(hours: AppConfig.cacheExpirationHours);
  
  // Constructor: inicializa el tiempo de última actualización y el cliente HTTP
  ApiService() : _httpClient = AppConfig.createHttpClient() {
    _lastUpdateTime = DateTime.now();
    print('ApiService inicializado con URL base: $baseUrl');
  }
  
  // Verificar si el cache necesita actualizarse
  bool _needsRefresh() {
    if (_lastUpdateTime == null) return true;
    return DateTime.now().difference(_lastUpdateTime!) > _cacheExpiration;
  }

  // Actualizar la hora de última actualización
  void _updateRefreshTime() {
    _lastUpdateTime = DateTime.now();
  }

  // Obtener novedades para el carrusel
  Future<List<Novedad>> getNovedades({bool forceRefresh = false}) async {
    // Si tenemos datos en cache y no necesitamos actualizarlos, devolverlos inmediatamente
    if (_novedadesCache != null && !_needsRefresh() && !forceRefresh) {
      return _novedadesCache!;
    }
    
    try {
      final url = '$baseUrl/Novedades/ObtenerNovedades';
      print('Realizando petición a: $url');
      
      // Realizar petición HTTP al endpoint
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: AppConfig.requestTimeout));
      
      if (response.statusCode == 200) {
        // Decodificar respuesta JSON
        final List<dynamic> jsonResponse = json.decode(response.body);
        
        // Convertir a objetos del modelo
        _novedadesCache = jsonResponse.map((item) => Novedad.fromJson(item)).toList();
        _updateRefreshTime();
        
        return _novedadesCache!;
      } else {
        print('Error HTTP ${response.statusCode}: ${response.body}');
        throw Exception('Error al cargar novedades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en getNovedades: $e');
      
      // En caso de error, intenta usar el caché si existe
      if (_novedadesCache != null) {
        return _novedadesCache!;
      }
      
      // Si no hay caché, propaga el error
      throw Exception('No se pudieron cargar las novedades: $e');
    }
  }

  // Obtener valores importantes
Future<List<ValorImportante>> getValoresImportantes({bool forceRefresh = false}) async {
  // Si tenemos datos en cache y no necesitamos actualizarlos, devolverlos inmediatamente
  if (_valoresCache != null && !_needsRefresh() && !forceRefresh) {
    return _valoresCache!;
  }
  
  try {
    final url = '$baseUrl/ValoresImportantes/ObtenerValoresImportantes';
    print('Realizando petición a: $url');
    
    // Realizar petición HTTP al endpoint
    final response = await _httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    ).timeout(Duration(seconds: AppConfig.requestTimeout));
    
    if (response.statusCode == 200) {
      // Decodificar respuesta JSON
      final List<dynamic> jsonResponse = json.decode(response.body);
      
      // Usar el constructor fromJson para manejar correctamente los tipos
      _valoresCache = jsonResponse.map((item) => ValorImportante.fromJson(item)).toList();
      
      _updateRefreshTime();
      return _valoresCache!;
    } else {
      print('Error HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Error al cargar valores importantes: ${response.statusCode}');
    }
  } catch (e) {
    print('Error en getValoresImportantes: $e');
    
    // En caso de error, intenta usar el caché si existe
    if (_valoresCache != null) {
      return _valoresCache!;
    }
    
    // Si no hay caché, propaga el error
    throw Exception('No se pudieron cargar los valores importantes: $e');
  }
}

  // Obtener cursos
  Future<List<Curso>> getCursos({bool forceRefresh = false}) async {
    // Si tenemos datos en cache y no necesitamos actualizarlos, devolverlos inmediatamente
    if (_cursosCache != null && !_needsRefresh() && !forceRefresh) {
      return _cursosCache!;
    }
    
    try {
      final url = '$baseUrl/Cursos/ObtenerCursos';
      print('Realizando petición a: $url');
      
      // Realizar petición HTTP al endpoint
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: AppConfig.requestTimeout));
      
      if (response.statusCode == 200) {
        // Decodificar respuesta JSON
        final List<dynamic> jsonResponse = json.decode(response.body);
        
        // Convertir a objetos del modelo
        _cursosCache = jsonResponse.map((item) => Curso.fromJson(item)).toList();
        _updateRefreshTime();
        
        return _cursosCache!;
      } else {
        print('Error HTTP ${response.statusCode}: ${response.body}');
        throw Exception('Error al cargar cursos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en getCursos: $e');
      
      // En caso de error, intenta usar el caché si existe
      if (_cursosCache != null) {
        return _cursosCache!;
      }
      
      // Si no hay caché, propaga el error
      throw Exception('No se pudieron cargar los cursos: $e');
    }
  }

  // Obtener todos los cursos (sin limite)
  Future<List<Curso>> getAllCursos({bool forceRefresh = false}) async {
    return getCursos(forceRefresh: forceRefresh);
  }

  // Obtener datos de matrícula
Future<Matricula> getMatricula({bool forceRefresh = false}) async {
  // Si tenemos datos en cache y no necesitamos actualizarlos, devolverlos inmediatamente
  if (_matriculaCache != null && !_needsRefresh() && !forceRefresh) {
    return _matriculaCache!;
  }
  
  try {
    final url = '$baseUrl/Matricula/ObtenerMatricula';
    print('Realizando petición a: $url');
    
    // Realizar petición HTTP al endpoint
    final response = await _httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    ).timeout(Duration(seconds: AppConfig.requestTimeout));
    
    if (response.statusCode == 200) {
      // Decodificar respuesta JSON
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      
      // Usar el constructor fromJson para manejar correctamente los tipos
      _matriculaCache = Matricula.fromJson(jsonResponse);
      
      _updateRefreshTime();
      return _matriculaCache!;
    } else {
      print('Error HTTP ${response.statusCode}: ${response.body}');
      throw Exception('Error al cargar matrícula: ${response.statusCode}');
    }
  } catch (e) {
    print('Error en getMatricula: $e');
    
    // En caso de error, intenta usar el caché si existe
    if (_matriculaCache != null) {
      return _matriculaCache!;
    }
    
    // Si no hay caché, propaga el error
    throw Exception('No se pudo cargar la información de matrícula: $e');
  }
}
  // Obtener contactos
  Future<List<ContactoItem>> getContactos({bool forceRefresh = false}) async {
    // Si tenemos datos en cache y no necesitamos actualizarlos, devolverlos inmediatamente
    if (_contactosCache != null && !_needsRefresh() && !forceRefresh) {
      return _contactosCache!;
    }
    
    try {
      final url = '$baseUrl/Contactos/ObtenerContactos';
      print('Realizando petición a: $url');
      
      // Realizar petición HTTP al endpoint
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: AppConfig.requestTimeout));
      
      if (response.statusCode == 200) {
        // Decodificar respuesta JSON
        final List<dynamic> jsonResponse = json.decode(response.body);
        
        // Convertir a objetos del modelo
        _contactosCache = jsonResponse.map((item) => ContactoItem(
          type: item['type'],
          title: item['title'],
          number: item['number'],
        )).toList();
        
        _updateRefreshTime();
        return _contactosCache!;
      } else {
        print('Error HTTP ${response.statusCode}: ${response.body}');
        throw Exception('Error al cargar contactos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en getContactos: $e');
      
      // En caso de error, intenta usar el caché si existe
      if (_contactosCache != null) {
        return _contactosCache!;
      }
      
      // Si no hay caché, propaga el error
      throw Exception('No se pudieron cargar los contactos: $e');
    }
  }

  // Método para forzar la actualización de todos los datos
  Future<void> refreshAllData() async {
    try {
      await Future.wait([
        getNovedades(forceRefresh: true),
        getValoresImportantes(forceRefresh: true),
        getCursos(forceRefresh: true),
        getMatricula(forceRefresh: true),
        getContactos(forceRefresh: true),
      ]);
    } catch (e) {
      print('Error en refreshAllData: $e');
      throw Exception('Error al actualizar los datos: $e');
    }
  }
  
  // Importante: liberar recursos cuando el servicio ya no se necesite
  void dispose() {
    _httpClient.close();
  }
}