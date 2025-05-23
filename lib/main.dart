import 'package:flutter/material.dart';
import 'dart:async';

// Importamos las pantallas
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cursos_screen.dart';
import 'screens/info_screen.dart';
import 'screens/contacto_screen.dart';
import 'screens/info_detail_screen.dart';
import 'screens/inscripcion_screen.dart';
import 'screens/diagnostico_screen.dart'; // Añadimos la pantalla de diagnóstico

// Importamos los servicios
import 'services/api_service.dart';

// Importamos los modelos
import 'models/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colegio de Abogados de Quilmes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Colores principales
        primaryColor: Color(0xFF009639), // Verde Quilmes
        colorScheme: ColorScheme.light(
          primary: Color(0xFF009639),
          secondary: Color(0xFF003366), // Azul acento
          background: Colors.white,
          surface: Colors.white,
        ),
        
        // Fondos y Cards
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        
        // Tipografía
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        
        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF009639),
          elevation: 0,
          centerTitle: true,
        ),
        
        // Botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF009639),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case '/cursos':
            return MaterialPageRoute(builder: (_) => CursosScreen());
          case '/info':
            return MaterialPageRoute(builder: (_) => InfoScreen());
          case '/contacto':
            return MaterialPageRoute(builder: (_) => ContactoScreen());
          case '/inscripcion':
            return MaterialPageRoute(builder: (_) => InscripcionScreen());
          case '/diagnostico': // Nueva ruta para la pantalla de diagnóstico
            return MaterialPageRoute(builder: (_) => DiagnosticoScreen());
          default:
            // Manejo de rutas de información detallada
            if (settings.name!.startsWith('/info/')) {
              final subRoute = settings.name!.split('/')[2];
              return MaterialPageRoute(
                builder: (_) => InfoDetailScreen(
                  title: subRoute.substring(0, 1).toUpperCase() + subRoute.substring(1),
                  route: subRoute,
                ),
              );
            }
            // Ruta por defecto en caso de no encontrar la solicitada
            return MaterialPageRoute(builder: (_) => HomeScreen());
        }
      },
    );
  }
}
