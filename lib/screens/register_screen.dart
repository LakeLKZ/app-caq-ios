// screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  
  // Controllers
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _tomoController = TextEditingController();
  final _folioController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // Estado
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  List<Colegio> _colegios = [];
  Colegio? _selectedColegio;
  bool _loadingColegios = true;

  @override
  void initState() {
    super.initState();
    _loadColegios();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _tomoController.dispose();
    _folioController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadColegios() async {
    try {
      final colegios = await _authService.getColegios();
      setState(() {
        _colegios = colegios;
        _loadingColegios = false;
      });
    } catch (e) {
      setState(() {
        _loadingColegios = false;
      });
      _showErrorDialog('Error al cargar los colegios. Verifica tu conexión.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Color(0xFF009639),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              SizedBox(height: 30),
              _buildRegistrationForm(),
              SizedBox(height: 30),
              _buildRegisterButton(),
              SizedBox(height: 20),
              _buildLoginLink(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Crear Cuenta',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF003366),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Completa todos los campos para registrarte',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Nombre y Apellido en fila
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _nombreController,
                  decoration: _buildInputDecoration('Nombre', Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  controller: _apellidoController,
                  decoration: _buildInputDecoration('Apellido', Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20),
          
          // DNI
          TextFormField(
            controller: _dniController,
            keyboardType: TextInputType.number,
            decoration: _buildInputDecoration('DNI', Icons.badge),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu DNI';
              }
              if (value.length < 7 || value.length > 8) {
                return 'El DNI debe tener 7 u 8 dígitos';
              }
              return null;
            },
          ),
          
          SizedBox(height: 20),
          
          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _buildInputDecoration('Email', Icons.email),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu email';
              }
              if (!value.contains('@')) {
                return 'Ingresa un email válido';
              }
              return null;
            },
          ),
          
          SizedBox(height: 20),
          
          // WhatsApp
          TextFormField(
            controller: _whatsappController,
            keyboardType: TextInputType.phone,
            decoration: _buildInputDecoration('WhatsApp', Icons.phone),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu número de WhatsApp';
              }
              return null;
            },
          ),
          
          SizedBox(height: 20),
          
          // Dropdown Colegios
          _buildColegiosDropdown(),
          
          SizedBox(height: 20),
          
          // Tomo y Folio en fila
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _tomoController,
                  decoration: _buildInputDecoration('Tomo', Icons.book),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  controller: _folioController,
                  decoration: _buildInputDecoration('Folio', Icons.description),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20),
          
          // Contraseña
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _buildPasswordDecoration('Contraseña', _obscurePassword, () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa una contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          
          SizedBox(height: 20),
          
          // Confirmar Contraseña
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: _buildPasswordDecoration('Confirmar Contraseña', _obscureConfirmPassword, () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor confirma tu contraseña';
              }
              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColegiosDropdown() {
    return Container(
      width: double.infinity,
      child: DropdownButtonFormField<Colegio>(
        value: _selectedColegio,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Colegio de Abogados',
          prefixIcon: Icon(Icons.account_balance, color: Color(0xFF009639)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF009639), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        items: _loadingColegios 
            ? null 
            : _colegios.map((colegio) {
                return DropdownMenuItem<Colegio>(
                  value: colegio,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      colegio.nombre,
                      style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                );
              }).toList(),
        onChanged: _loadingColegios 
            ? null 
            : (Colegio? value) {
                setState(() {
                  _selectedColegio = value;
                });
              },
        validator: (value) {
          if (value == null) {
            return 'Por favor selecciona un colegio';
          }
          return null;
        },
        hint: _loadingColegios 
            ? Text('Cargando colegios...') 
            : Text('Selecciona tu colegio'),
        dropdownColor: Colors.white,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Color(0xFF009639)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF009639), width: 2),
      ),
    );
  }

  InputDecoration _buildPasswordDecoration(String label, bool obscure, VoidCallback toggle) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(Icons.lock, color: Color(0xFF009639)),
      suffixIcon: IconButton(
        icon: Icon(
          obscure ? Icons.visibility : Icons.visibility_off,
          color: Color(0xFF009639),
        ),
        onPressed: toggle,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF009639), width: 2),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: userProvider.isLoading ? null : _handleRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF009639),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: userProvider.isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    'REGISTRARSE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Ya tienes cuenta? ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Inicia sesión',
            style: TextStyle(
              color: Color(0xFF009639),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedColegio == null) {
      _showErrorDialog('Por favor selecciona un colegio');
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final response = await userProvider.register(
        nombre: _nombreController.text.trim(),
        apellido: _apellidoController.text.trim(),
        numero: _whatsappController.text.trim(),
        mail: _emailController.text.trim(),
        colegio: _selectedColegio!.id,
        tomo: _tomoController.text.trim(),
        folio: _folioController.text.trim(),
        password: _passwordController.text,
        dni: _dniController.text.trim(),
      );

      if (response.isSuccess) {
        // Registro exitoso - mostrar mensaje y navegar al login
        _showSuccessDialog();
      } else {
        // Mostrar error específico
        _showErrorDialog(response.mensaje);
      }
    } catch (e) {
      _showErrorDialog('Error de conexión. Verifica tu internet e intenta nuevamente.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Color(0xFF009639)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF009639)),
              SizedBox(width: 8),
              Text('¡Registro Exitoso!'),
            ],
          ),
          content: Text('Tu cuenta ha sido creada correctamente. Ahora puedes iniciar sesión.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'INICIAR SESIÓN',
                style: TextStyle(
                  color: Color(0xFF009639),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}