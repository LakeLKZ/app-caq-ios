import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../config/config.dart';

class ApiService {
  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._internal();
  
  ApiService._internal();
  
  factory ApiService() => instance;
  
  final String baseUrl = AppConfig.apiBaseUrl;
  late final http.Client _httpClient;
  
  // Cache mejorado con timestamps
  final Map<String, dynamic> _cache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  
  static const Duration _cacheExpiration = Duration(minutes: 30);
  static const Duration _requestTimeout = Duration(seconds: 10);
  
  bool _isInitialized = false;
  
  void _initialize() {
    if (_isInitialized) return;
    _httpClient = AppConfig.createHttpClient();
    _isInitialized = true;
  }
  
  bool _isCacheValid(String key) {
    final timestamp = _cacheTimestamps[key];
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < _cacheExpiration;
  }
  
  void _setCacheData(String key, dynamic data) {
    _cache[key] = data;
    _cacheTimestamps[key] = DateTime.now();
  }
  
  T? _getCacheData<T>(String key) {
    if (_isCacheValid(key)) {
      return _cache[key] as T?;
    }
    return null;
  }

  // Optimización: Request con manejo mejorado de errores
  Future<http.Response> _makeRequest(String endpoint) async {
    _initialize();
    
    final url = '$baseUrl$endpoint';
    
    try {
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(_requestTimeout);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw ApiException('HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw ApiException('Error de conexión: $e');
    }
  }

  // Optimización: Parsing en compute para listas grandes
  Future<List<T>> _parseListInBackground<T>(
    String jsonString,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    if (jsonString.length < 10000) {
      // Para datos pequeños, parsear en el hilo principal
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => fromJson(item)).toList();
    } else {
      // Para datos grandes, usar compute
      return await compute(_parseListHelper<T>, {
        'jsonString': jsonString,
        'fromJson': fromJson,
      });
    }
  }

  Future<List<Novedad>> getNovedades({bool forceRefresh = false}) async {
    const String cacheKey = 'novedades';
    
    if (!forceRefresh) {
      final cached = _getCacheData<List<Novedad>>(cacheKey);
      if (cached != null) return cached;
    }
    
    try {
      final response = await _makeRequest('/Novedades/ObtenerNovedades');
      final List<dynamic> jsonResponse = json.decode(response.body);
      
      final novedades = jsonResponse.map((item) => Novedad.fromJson(item)).toList();
      _setCacheData(cacheKey, novedades);
      
      return novedades;
    } catch (e) {
      // Fallback al cache si existe
      final cached = _getCacheData<List<Novedad>>(cacheKey);
      if (cached != null) return cached;
      throw e;
    }
  }

  Future<List<ValorImportante>> getValoresImportantes({bool forceRefresh = false}) async {
    const String cacheKey = 'valores';
    
    if (!forceRefresh) {
      final cached = _getCacheData<List<ValorImportante>>(cacheKey);
      if (cached != null) return cached;
    }
    
    try {
      final response = await _makeRequest('/ValoresImportantes/ObtenerValoresImportantes');
      final List<dynamic> jsonResponse = json.decode(response.body);
      
      final valores = jsonResponse.map((item) => ValorImportante.fromJson(item)).toList();
      _setCacheData(cacheKey, valores);
      
      return valores;
    } catch (e) {
      final cached = _getCacheData<List<ValorImportante>>(cacheKey);
      if (cached != null) return cached;
      throw e;
    }
  }

  Future<List<Curso>> getCursos({bool forceRefresh = false}) async {
    const String cacheKey = 'cursos';
    
    if (!forceRefresh) {
      final cached = _getCacheData<List<Curso>>(cacheKey);
      if (cached != null) return cached;
    }
    
    try {
      final response = await _makeRequest('/Cursos/ObtenerCursos');
      final List<dynamic> jsonResponse = json.decode(response.body);
      
      final cursos = jsonResponse.map((item) => Curso.fromJson(item)).toList();
      _setCacheData(cacheKey, cursos);
      
      return cursos;
    } catch (e) {
      final cached = _getCacheData<List<Curso>>(cacheKey);
      if (cached != null) return cached;
      throw e;
    }
  }

  // Método de matrícula eliminado - no existe en el servidor

  Future<List<ContactoItem>> getContactos({bool forceRefresh = false}) async {
    const String cacheKey = 'contactos';
    
    if (!forceRefresh) {
      final cached = _getCacheData<List<ContactoItem>>(cacheKey);
      if (cached != null) return cached;
    }
    
    try {
      final response = await _makeRequest('/Contactos/ObtenerContactos');
      final List<dynamic> jsonResponse = json.decode(response.body);
      
      final contactos = jsonResponse.map((item) => ContactoItem(
        type: item['type'],
        title: item['title'],
        number: item['number'],
      )).toList();
      
      _setCacheData(cacheKey, contactos);
      return contactos;
    } catch (e) {
      final cached = _getCacheData<List<ContactoItem>>(cacheKey);
      if (cached != null) return cached;
      throw e;
    }
  }

  // Optimización: Refrescar solo datos específicos (sin matrícula)
  Future<void> refreshSpecificData(List<String> dataTypes) async {
    final futures = <Future>[];
    
    for (final type in dataTypes) {
      switch (type) {
        case 'novedades':
          futures.add(getNovedades(forceRefresh: true));
          break;
        case 'valores':
          futures.add(getValoresImportantes(forceRefresh: true));
          break;
        case 'cursos':
          futures.add(getCursos(forceRefresh: true));
          break;
        case 'contactos':
          futures.add(getContactos(forceRefresh: true));
          break;
        // Matrícula eliminada
      }
    }
    
    if (futures.isNotEmpty) {
      await Future.wait(futures);
    }
  }

  Future<void> refreshAllData() async {
    await refreshSpecificData(['novedades', 'valores', 'cursos', 'contactos']);
  }
  
  void clearCache() {
    _cache.clear();
    _cacheTimestamps.clear();
  }
  
  void dispose() {
    if (_isInitialized) {
      _httpClient.close();
      _isInitialized = false;
    }
    clearCache();
  }
}

// Función helper para compute
List<T> _parseListHelper<T>(Map<String, dynamic> params) {
  final String jsonString = params['jsonString'];
  final T Function(Map<String, dynamic>) fromJson = params['fromJson'];
  
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((item) => fromJson(item)).toList();
}

// Excepción personalizada para la API
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  
  @override
  String toString() => 'ApiException: $message';
}