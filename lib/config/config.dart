import 'dart:io';
import 'package:http/http.dart' as http;

class AppConfig {
  // URL del servidor en la nube
  static const String apiBaseUrl = 'http://179.43.112.55:8080/api';
  
  // URLs alternativas (comentadas)
  // static const String apiBaseUrlLocal = 'https://10.0.2.2:7016/api'; // Para emulador Android
  // static const String apiBaseUrlLAN = 'https://192.168.1.X:7016/api'; // Para dispositivo real en red local
  
  // Configuración para tiempo de espera de las peticiones (en segundos)
  static const int requestTimeout = 15;
  
  // Configuración para expiración de caché (en horas)
  static const int cacheExpirationHours = 1;
  
  // Crear un cliente HTTP que acepta certificados autofirmados
  static http.Client createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    
    return _CustomHttpClient(httpClient);
  }
}

// Cliente HTTP personalizado que acepta certificados autofirmados
class _CustomHttpClient extends http.BaseClient {
  final HttpClient _httpClient;
  
  _CustomHttpClient(this._httpClient);
  
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final httpRequest = await _httpClient.openUrl(request.method, request.url);
    
    // Copiar encabezados manualmente sin usar 'keys'
    request.headers.forEach((name, value) {
      httpRequest.headers.set(name, value);
    });
    
    // Configurar el cuerpo de la solicitud si es necesario
    if (request.method != 'GET' && request.method != 'HEAD') {
      final requestBody = await request.finalize().toBytes();
      httpRequest.contentLength = requestBody.length;
      httpRequest.add(requestBody);
    } else {
      httpRequest.contentLength = 0;
    }
    
    // Obtener respuesta HTTP
    final httpResponse = await httpRequest.close();
    
    // Crear mapa de encabezados para la respuesta
    final headers = <String, String>{};
    httpResponse.headers.forEach((name, values) {
      headers[name] = values.join(',');
    });
    
    // Devolver respuesta en formato esperado por http package
    return http.StreamedResponse(
      httpResponse.cast<List<int>>(),
      httpResponse.statusCode,
      contentLength: httpResponse.contentLength == -1 ? null : httpResponse.contentLength,
      isRedirect: httpResponse.isRedirect,
      headers: headers,
      reasonPhrase: httpResponse.reasonPhrase,
    );
  }
}