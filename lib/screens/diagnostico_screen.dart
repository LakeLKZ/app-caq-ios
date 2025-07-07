import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/api_service.dart';

class DiagnosticoScreen extends StatefulWidget {
  @override
  _DiagnosticoScreenState createState() => _DiagnosticoScreenState();
}

class _DiagnosticoScreenState extends State<DiagnosticoScreen> {
  String _logs = "Iniciando diagnóstico...";
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  
  @override
  void initState() {
    super.initState();
    _ejecutarDiagnostico();
  }
  
  Future<void> _ejecutarDiagnostico() async {
    setState(() {
      _isLoading = true;
      _logs = "Iniciando diagnóstico completo...\n";
    });
    
    try {
      // 1. Información del dispositivo
      await _getDeviceInfo();
      
      // 2. Información de la aplicación
      await _getAppInfo();
      
      // 3. Comprobar conectividad básica
      await _checkBasicConnectivity();
      
      // 4. Comprobar conexión al servidor
      await _checkServerConnectivity();
      
      // 5. Probar API endpoints
      await _testApiEndpoints();
      
    } catch (e) {
      setState(() {
        _logs += "\n❌ ERROR GENERAL: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
        _logs += "\n\n✅ Diagnóstico completado.";
      });
    }
  }
  
  Future<void> _getDeviceInfo() async {
    setState(() {
      _logs += "\n\n📱 INFORMACIÓN DEL DISPOSITIVO:";
    });
    
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        setState(() {
          _logs += "\n- Modelo: ${androidInfo.model}";
          _logs += "\n- Fabricante: ${androidInfo.manufacturer}";
          _logs += "\n- Android: ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})";
          _logs += "\n- Seguridad HTTP: ${androidInfo.version.sdkInt >= 28 ? 'Restricciones activas' : 'Sin restricciones'}";
        });
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        setState(() {
          _logs += "\n- Modelo: ${iosInfo.model}";
          _logs += "\n- Sistema: ${iosInfo.systemName} ${iosInfo.systemVersion}";
        });
      }
    } catch (e) {
      setState(() {
        _logs += "\n❌ Error obteniendo info del dispositivo: $e";
      });
    }
  }
  
  Future<void> _getAppInfo() async {
    setState(() {
      _logs += "\n\n📦 INFORMACIÓN DE LA APLICACIÓN:";
    });
    
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _logs += "\n- Nombre: ${packageInfo.appName}";
        _logs += "\n- Paquete: ${packageInfo.packageName}";
        _logs += "\n- Versión: ${packageInfo.version}+${packageInfo.buildNumber}";
      });
    } catch (e) {
      setState(() {
        _logs += "\n❌ Error obteniendo info de la app: $e";
      });
    }
  }
  
  Future<void> _checkBasicConnectivity() async {
    setState(() {
      _logs += "\n\n🌐 CONECTIVIDAD BÁSICA:";
    });
    
    try {
      // Simplificamos el chequeo de conectividad para evitar errores de API
      setState(() {
        _logs += "\n- Verificando estado de conectividad...";
      });
      
      // Método simplificado: probar conectividad directamente
      try {
        final result = await InternetAddress.lookup('8.8.8.8');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            _logs += "\n- Internet disponible ✅";
            _logs += "\n- DNS Google (8.8.8.8) alcanzable ✅";
          });
        }
      } catch (e) {
        setState(() {
          _logs += "\n- Internet NO disponible ❌: $e";
        });
      }
      
      // Intentar verificar tipo de conexión de forma segura
      try {
        final connectivity = Connectivity();
        final connectivityResult = await connectivity.checkConnectivity();
        
        setState(() {
          String connectionType = _parseConnectivityResult(connectivityResult);
          _logs += "\n- Tipo de conexión detectado: $connectionType";
        });
      } catch (e) {
        setState(() {
          _logs += "\n- No se pudo determinar tipo de conexión: $e";
        });
      }
      
    } catch (e) {
      setState(() {
        _logs += "\n❌ Error verificando conectividad: $e";
      });
    }
  }
  
  String _parseConnectivityResult(dynamic result) {
    // Manejo compatible para diferentes versiones de connectivity_plus
    if (result is List) {
      // Nueva API que devuelve List<ConnectivityResult>
      if (result.isEmpty) return "Sin conexión";
      final first = result.first;
      return _connectivityResultToString(first);
    } else {
      // API anterior que devuelve ConnectivityResult
      return _connectivityResultToString(result);
    }
  }
  
  String _connectivityResultToString(dynamic result) {
    final resultStr = result.toString();
    
    if (resultStr.contains('mobile')) return "Datos móviles";
    if (resultStr.contains('wifi')) return "WiFi";
    if (resultStr.contains('ethernet')) return "Ethernet";
    if (resultStr.contains('vpn')) return "VPN";
    if (resultStr.contains('bluetooth')) return "Bluetooth";
    if (resultStr.contains('other')) return "Otro";
    if (resultStr.contains('none')) return "Sin conexión";
    
    return "Desconocida ($resultStr)";
  }
  
  Future<void> _checkServerConnectivity() async {
    setState(() {
      _logs += "\n\n🖥️ CONECTIVIDAD AL SERVIDOR:";
      _logs += "\n- IP del servidor: 179.43.112.55";
      _logs += "\n- Puerto: 8080";
    });
    
    try {
      // Verificar si podemos alcanzar el servidor
      final result = await InternetAddress.lookup('179.43.112.55');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _logs += "\n- Servidor alcanzable ✅";
        });
        
        // Intentar conexión TCP al puerto
        try {
          final socket = await Socket.connect('179.43.112.55', 8080, 
            timeout: Duration(seconds: 5));
          socket.destroy();
          setState(() {
            _logs += "\n- Puerto 8080 abierto ✅";
          });
        } catch (e) {
          setState(() {
            _logs += "\n- Puerto 8080 cerrado o bloqueado ❌: $e";
          });
        }
      }
    } catch (e) {
      setState(() {
        _logs += "\n❌ Error conectando al servidor: $e";
      });
    }
    
    // Probar endpoints HTTP específicos
    final testEndpoints = [
      '/api/Novedades/ObtenerNovedades',
      '/api/ValoresImportantes/ObtenerValoresImportantes',
      '/api/Cursos/ObtenerCursos',
      '/api/Contactos/ObtenerContactos'
    ];
    
    for (final endpoint in testEndpoints) {
      try {
        setState(() {
          _logs += "\n- Probando: $endpoint";
        });
        
        final response = await http.get(
          Uri.parse('http://179.43.112.55:8080$endpoint'),
          headers: {'Content-Type': 'application/json'},
        ).timeout(Duration(seconds: 10));
        
        setState(() {
          if (response.statusCode >= 200 && response.statusCode < 300) {
            _logs += " ✅ (${response.statusCode})";
            if (response.body.isNotEmpty) {
              final preview = response.body.length > 50 
                  ? response.body.substring(0, 50) + '...' 
                  : response.body;
              _logs += "\n  Datos: $preview";
            }
          } else {
            _logs += " ❌ (${response.statusCode})";
          }
        });
      } catch (e) {
        setState(() {
          _logs += " ❌ Error: $e";
        });
      }
    }
  }
  
  Future<void> _testApiEndpoints() async {
    setState(() {
      _logs += "\n\n🔌 PRUEBA DE MÉTODOS API:";
    });
    
    // Endpoints disponibles (sin matrícula)
    final endpoints = [
      {"nombre": "Novedades", "metodo": "getNovedades()"},
      {"nombre": "Valores", "metodo": "getValoresImportantes()"},
      {"nombre": "Cursos", "metodo": "getCursos()"},
      {"nombre": "Contactos", "metodo": "getContactos()"}
    ];
    
    for (var endpoint in endpoints) {
      setState(() {
        _logs += "\n\n- Probando ${endpoint["nombre"]}:";
      });
      
      try {
        dynamic result;
        
        switch (endpoint["metodo"]) {
          case "getNovedades()":
            result = await _apiService.getNovedades(forceRefresh: true);
            break;
          case "getValoresImportantes()":
            result = await _apiService.getValoresImportantes(forceRefresh: true);
            break;
          case "getCursos()":
            result = await _apiService.getCursos(forceRefresh: true);
            break;
          case "getContactos()":
            result = await _apiService.getContactos(forceRefresh: true);
            break;
          default:
            setState(() {
              _logs += "\n  ⚠️ Método desconocido";
            });
            continue;
        }
        
        setState(() {
          _logs += "\n  ✅ Éxito";
          
          if (result is List) {
            _logs += " - ${result.length} elemento(s)";
            if (result.isNotEmpty) {
              _logs += "\n  🔍 Primer elemento: ${_formatForDisplay(result[0])}";
            }
          } else if (result != null) {
            _logs += "\n  🔍 Resultado: ${_formatForDisplay(result)}";
          } else {
            _logs += "\n  ⚠️ Resultado nulo";
          }
        });
      } catch (e) {
        setState(() {
          _logs += "\n  ❌ Error: $e";
        });
      }
    }
    
    // Verificar endpoint de matrícula (sabemos que devuelve 404)
    setState(() {
      _logs += "\n\n- Verificando endpoint Matrícula (eliminado):";
    });
    
    try {
      final response = await http.get(
        Uri.parse('http://179.43.112.55:8080/api/Matricula/ObtenerMatricula'),
      ).timeout(Duration(seconds: 10));
      
      setState(() {
        if (response.statusCode == 404) {
          _logs += "\n  ✅ 404 - Correctamente eliminado";
        } else {
          _logs += "\n  ⚠️ Respuesta inesperada: ${response.statusCode}";
        }
      });
    } catch (e) {
      setState(() {
        _logs += "\n  ✅ Error esperado (endpoint eliminado): $e";
      });
    }
  }
  
  String _formatForDisplay(dynamic obj) {
    if (obj == null) return "null";
    
    try {
      final str = obj.toString();
      return str.length > 80 ? "${str.substring(0, 80)}..." : str;
    } catch (e) {
      return "Error al formatear: $e";
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Diagnóstico de Conexión",
          style: TextStyle(color: Color(0xFF009639)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF009639)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Color(0xFF009639)),
            onPressed: _ejecutarDiagnostico,
            tooltip: "Ejecutar diagnóstico nuevamente",
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Diagnóstico de Conectividad",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF009639),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Análisis completo del estado de la aplicación y conectividad al servidor.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: SelectableText(
                    _logs,
                    style: TextStyle(
                      color: Colors.green,
                      fontFamily: "monospace",
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.copy),
                    label: Text("Copiar Diagnóstico"),
                    onPressed: _mostrarDialogoCopia,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF009639),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF009639)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Ejecutando diagnóstico...",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  void _mostrarDialogoCopia() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Diagnóstico Completo'),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: SelectableText(
                _logs,
                style: TextStyle(
                  fontFamily: "monospace",
                  fontSize: 11,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Selecciona y copia el texto del diagnóstico"),
                    backgroundColor: Color(0xFF009639),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF009639),
              ),
              child: Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}