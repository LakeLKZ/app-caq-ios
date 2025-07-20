// providers/user_provider.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  
  // Información del usuario para mostrar en la UI
  String get userName => _currentUser?.nombreCompleto ?? '';
  String get userEmail => _currentUser?.email ?? '';
  String get userDni => _currentUser?.dni ?? '';
  String get userWhatsapp => _currentUser?.whatsapp ?? '';
  String get userTomo => _currentUser?.tomo ?? '';
  String get userFolio => _currentUser?.folio ?? '';
  int get userColegioId => _currentUser?.colegioId ?? 0;

  // Inicializar - verificar si hay usuario guardado
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      final savedUser = await _authService.getSavedUser();
      final isLoggedIn = await _authService.isLoggedIn();
      
      if (savedUser != null && isLoggedIn) {
        _currentUser = savedUser;
        _isLoggedIn = true;
      } else {
        _currentUser = null;
        _isLoggedIn = false;
      }
    } catch (e) {
      _currentUser = null;
      _isLoggedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Login
  Future<AuthResponse> login(String dni, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(
        dni: dni,
        password: password,
      );

      if (response.isSuccess && response.usuario != null) {
        _currentUser = response.usuario;
        _isLoggedIn = true;
        notifyListeners();
      }

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Register
  Future<AuthResponse> register({
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
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.registrar(
        nombre: nombre,
        apellido: apellido,
        numero: numero,
        mail: mail,
        colegio: colegio,
        tomo: tomo,
        folio: folio,
        password: password,
        dni: dni,
      );

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  // Actualizar datos del usuario (si tienes un endpoint para eso)
  void updateUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}