// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../config/config.dart';
class AuthService {
  // Usar la URL de tu AppConfig
  static String get baseUrl => '${AppConfig.apiBaseUrl}/Usuarios';
  
  // Usar el cliente HTTP personalizado de tu configuración
  final http.Client _httpClient = AppConfig.createHttpClient();
  
  // Headers comunes
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Obtener colegios para el dropdown
  Future<List<Colegio>> getColegios() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/ObtenerColegios'),
        headers: {'Accept': 'application/json'},
      ).timeout(Duration(seconds: AppConfig.requestTimeout));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Colegio.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener colegios: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Registrar usuario
  Future<AuthResponse> registrar({
    required String nombre,
    required String apellido,
    required String numero,
    required String mail,
    required int colegio,
    required String tomo,
    required String folio,
    required String password,
    required String dni,
  }) async {
    try {
      final body = {
        'nombre': nombre,
        'apellido': apellido,
        'numero': numero,
        'mail': mail,
        'colegio': colegio,
        'tomo': tomo,
        'folio': folio,
        'contraseña': password,
        'dni': dni,
      };

      final response = await _httpClient.post(
        Uri.parse('$baseUrl/Registrar'),
        headers: _headers,
        body: json.encode(body),
      ).timeout(Duration(seconds: AppConfig.requestTimeout));

      if (response.statusCode == 200 || response.statusCode == 400) {
        return AuthResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Login usuario
  Future<AuthResponse> login({
    required String dni,
    required String password,
  }) async {
    try {
      final body = {
        'dni': dni,
        'contraseña': password,
      };

      final response = await _httpClient.post(
        Uri.parse('$baseUrl/Login'),
        headers: _headers,
        body: json.encode(body),
      ).timeout(Duration(seconds: AppConfig.requestTimeout));

      if (response.statusCode == 200 || response.statusCode == 401) {
        final authResponse = AuthResponse.fromJson(json.decode(response.body));
        
        // Si el login es exitoso, guardar el usuario
        if (authResponse.isSuccess && authResponse.usuario != null) {
          await _saveUser(authResponse.usuario!);
        }
        
        return authResponse;
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Guardar usuario en SharedPreferences
  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', json.encode(user.toJson()));
    await prefs.setBool('is_logged_in', true);
  }

  // Obtener usuario guardado
  Future<User?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    }
    return null;
  }

  // Verificar si el usuario está logueado
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    await prefs.setBool('is_logged_in', false);
  }

  // Cerrar el cliente HTTP al finalizar
  void dispose() {
    _httpClient.close();
  }
}