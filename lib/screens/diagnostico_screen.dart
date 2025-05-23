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
      var connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        String connectionType = "Desconocida";
        if (connectivityResult == ConnectivityResult.mobile) {
          connectionType = "Datos móviles";
        } else if (connectivityResult == ConnectivityResult.wifi) {
          connectionType = "WiFi";
        } else if (connectivityResult == ConnectivityResult.none) {
          connectionType = "Sin conexión";
        } else if (connectivityResult == ConnectivityResult.ethernet) {
          connectionType = "Ethernet";
        } else if (connectivityResult == ConnectivityResult.vpn) {
          connectionType = "VPN";
        } else if (connectivityResult == ConnectivityResult.bluetooth) {
          connectionType = "Bluetooth";
        } else if (connectivityResult == ConnectivityResult.other) {
          connectionType = "Otro";
        }
        _logs += "\n- Tipo de conexión: $connectionType";
      });
      
      // Probar conectividad a internet (Google DNS)
      try {
        final result = await InternetAddress.lookup('8.8.8.8');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            _logs += "\n- Internet disponible ✅";
          });
        }
      } catch (e) {
        setState(() {
          _logs += "\n- Internet NO disponible ❌: $e";
        });
      }
    } catch (e) {
      setState(() {
        _logs += "\n❌ Error verificando conectividad: $e";
      });
    }
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
        
        // Intentar ping al servidor (TCP)
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
    
    // Probar una solicitud HTTP simple al servidor
    try {
      setState(() {
        _logs += "\n- Intentando solicitud HTTP al servidor...";
      });
      
      final response = await http.get(
        Uri.parse('http://179.43.112.55:8080/api/Novedades/ObtenerNovedades'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 10));
      
      setState(() {
        _logs += "\n- Respuesta del servidor: ${response.statusCode}";
        if (response.statusCode >= 200 && response.statusCode < 300) {
          _logs += " ✅";
          _logs += "\n- Body (primeros 100 caracteres): ${response.body.length > 100 ? response.body.substring(0, 100) + '...' : response.body}";
        } else {
          _logs += " ❌";
        }
      });
    } catch (e) {
      setState(() {
        _logs += "\n❌ Error en solicitud HTTP: $e";
      });
    }
  }
  
  Future<void> _testApiEndpoints() async {
    setState(() {
      _logs += "\n\n🔌 PRUEBA DE ENDPOINTS API:";
    });
    
    // Lista de endpoints a probar
    final endpoints = [
      {"nombre": "Novedades", "metodo": "getNovedades()"},
      {"nombre": "Valores", "metodo": "getValoresImportantes()"},
      {"nombre": "Cursos", "metodo": "getCursos()"},
      {"nombre": "Matrícula", "metodo": "getMatricula()"},
      {"nombre": "Contactos", "metodo": "getContactos()"}
    ];
    
    for (var endpoint in endpoints) {
      setState(() {
        _logs += "\n\n- Probando '${endpoint["nombre"]}':";
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
          case "getMatricula()":
            result = await _apiService.getMatricula(forceRefresh: true);
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
          _logs += "\n  ✅ Respuesta obtenida correctamente";
          
          if (result is List && result.isNotEmpty) {
            _logs += "\n  📊 Items: ${result.length}";
            if (result.length > 0) {
              _logs += "\n  🔍 Primer item: ${_formatObjectForDisplay(result[0])}";
            }
          } else if (result != null) {
            _logs += "\n  🔍 Datos: ${_formatObjectForDisplay(result)}";
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
  }
  
  String _formatObjectForDisplay(dynamic obj) {
    // Convertir un objeto en un string resumido para mostrar
    if (obj == null) return "null";
    
    try {
      final str = obj.toString();
      if (str.length > 100) {
        return "${str.substring(0, 100)}...";
      }
      return str;
    } catch (e) {
      return "Error formateando objeto: $e";
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _ejecutarDiagnostico,
            tooltip: "Ejecutar diagnóstico de nuevo",
          ),
        ],
      ),
      body: Stack(
        children: [
          // Contenido de diagnóstico
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
                          "Resultados del Diagnóstico",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF009639),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Este análisis muestra información sobre la conectividad y funcionamiento de la aplicación.",
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
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.share),
                        label: Text("Compartir resultados"),
                        onPressed: _compartirResultados,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          
          // Indicador de carga
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
  
  void _compartirResultados() {
    // Por ahora muestra un mensaje simple
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Función para compartir aún no implementada"),
      ),
    );
    
    // Para implementar compartir resultados, necesitarías:
    // 1. Añadir la dependencia share_plus
    // 2. Importar el paquete
    // 3. Implementar algo como esto:
    /*
    import 'package:share_plus/share_plus.dart';
    
    // Dentro del método _compartirResultados:
    Share.share(_logs, subject: 'Diagnóstico de la app Colegio de Abogados');
    */
  }
}
