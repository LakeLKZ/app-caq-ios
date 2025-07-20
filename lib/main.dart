// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider para autenticación
import 'providers/user_provider.dart';

// Importamos las pantallas de autenticación
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

// Importamos las pantallas existentes
import 'screens/home_screen.dart';
import 'screens/cursos_screen.dart';
import 'screens/info_screen.dart';
import 'screens/contacto_screen.dart';
import 'screens/diagnostico_screen.dart'; 
import 'screens/info_screens/sedes_horarios_screen.dart';
import 'screens/info_screens/correos_utiles_screen.dart';
import 'screens/info_screens/matricula_pago_screen.dart';
import 'screens/info_screens/renovacion_credencial_screen.dart';
import 'screens/info_screens/certificado_matricula_screen.dart';
import 'screens/info_screens/credencial_empleado_screen.dart';
import 'screens/info_screens/credencial_mediador_screen.dart';
import 'screens/info_screens/portal_colproba_screen.dart';
import 'screens/info_screens/sustitucion_patrocinio_screen.dart';
import 'screens/info_screens/beneficios_matriculados_screen.dart'; 
import 'screens/info_screens/servicios_oca_screen.dart';
import 'screens/info_screens/personas_juridicas_screen.dart';
import 'screens/info_screens/firma_digital_screen.dart';
import 'screens/info_screens/dni_pasaporte_screen.dart';
import 'screens/info_screens/registro_propiedad_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
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
            // Rutas de autenticación
            case '/':
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/register':
              return MaterialPageRoute(builder: (_) => RegisterScreen());
            
            // Rutas principales existentes
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case '/cursos':
              return MaterialPageRoute(builder: (_) => CursosScreen());
            case '/info':
              return MaterialPageRoute(builder: (_) => InfoScreen());
            case '/contacto':
              return MaterialPageRoute(builder: (_) => ContactoScreen());
            case '/diagnostico':
              return MaterialPageRoute(builder: (_) => DiagnosticoScreen());
              
            // Rutas de información existentes
            case '/info/sedes-horarios':
              return MaterialPageRoute(builder: (_) => SedesHorariosScreen());
            case '/info/correos-utiles':
              return MaterialPageRoute(builder: (_) => CorreosUtilesScreen());
            case '/info/matricula-pago':
              return MaterialPageRoute(builder: (_) => MatriculaPagoScreen());
            case '/info/renovacion-credencial':
              return MaterialPageRoute(builder: (_) => RenovacionCredencialScreen());
            case '/info/certificado-matricula': 
              return MaterialPageRoute(builder: (_) => CertificadoMatriculaScreen());
            case '/info/credencial-empleado':
              return MaterialPageRoute(builder: (_) => CredencialEmpleadoScreen());
            case '/info/credencial-mediador':
              return MaterialPageRoute(builder: (_) => CredencialMediadorScreen());
            case '/info/portal-colproba':
              return MaterialPageRoute(builder: (_) => PortalColprobaScreen());
            case '/info/sustitucion-patrocinio':
              return MaterialPageRoute(builder: (_) => SustitucionPatrocinioScreen());
            case '/info/beneficios-matriculados':
              return MaterialPageRoute(builder: (_) => BeneficiosMatriculadosScreen());
            case '/info/servicios-oca':
              return MaterialPageRoute(builder: (_) => ServiciosOcaScreen());
            case '/info/personas-juridicas':
              return MaterialPageRoute(builder: (_) => PersonasJuridicasScreen());
            case '/info/firma-digital':
              return MaterialPageRoute(builder: (_) => FirmaDigitalScreen());
            case '/info/dni-pasaporte':
              return MaterialPageRoute(builder: (_) => DniPasaporteScreen());
            case '/info/registro-propiedad':
              return MaterialPageRoute(builder: (_) => RegistroPropiedadScreen());
              
            // Ruta por defecto
            default:
              return MaterialPageRoute(builder: (_) => HomeScreen());
          }
        },
      ),
    );
  }
}