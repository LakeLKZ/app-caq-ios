import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _contactTapCount = 0;
  DateTime? _lastTapTime;
  
  // Optimización: Caché de las rutas
  static const Map<int, String> _routes = {
    0: '/home',
    1: '/cursos',
    2: '/info',
    3: '/contacto',
  };
  
  // Optimización: Caché de los ítems del bottom navigation
  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Inicio',
      tooltip: 'Ir a Inicio',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school_outlined),
      activeIcon: Icon(Icons.school),
      label: 'Cursos',
      tooltip: 'Ver Cursos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_outline),
      activeIcon: Icon(Icons.info),
      label: 'Info',
      tooltip: 'Información',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.contact_phone_outlined),
      activeIcon: Icon(Icons.contact_phone),
      label: 'Contacto',
      tooltip: 'Contacto',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF009639),
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        elevation: 0, // Eliminamos elevation del widget, usamos Container
        
        // Optimización de texto
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        
        // Optimización de iconos
        selectedIconTheme: IconThemeData(
          size: 26,
          color: Color(0xFF009639),
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: Colors.grey[600],
        ),
        
        items: _navItems,
        onTap: _handleNavTap,
      ),
    );
  }

  void _handleNavTap(int index) {
    // Optimización: Evitar navegación innecesaria
    if (index == widget.currentIndex && index != 3) {
      return; // No hacer nada si ya estamos en la misma pantalla (excepto contacto)
    }
    
    // Feedback háptico optimizado
    HapticFeedback.selectionClick();
    
    if (index == 3) {
      _handleContactTap();
    } else {
      _navigateToRoute(index);
    }
  }

  void _handleContactTap() {
    final now = DateTime.now();
    
    // Resetear contador si ha pasado más de 3 segundos
    if (_lastTapTime != null && 
        now.difference(_lastTapTime!).inSeconds > 3) {
      _contactTapCount = 0;
    }
    
    _lastTapTime = now;
    _contactTapCount++;
    
    // Feedback visual discreto para el easter egg
    if (_contactTapCount >= 2 && _contactTapCount < 5) {
      _showDiscreteSnackBar(
        "${5 - _contactTapCount} toques más para diagnóstico",
        duration: Duration(milliseconds: 800),
      );
    }
    
    // Activar pantalla de diagnóstico con 5 toques
    if (_contactTapCount >= 5) {
      _contactTapCount = 0;
      _showDiscreteSnackBar(
        "Accediendo a diagnóstico...",
        duration: Duration(milliseconds: 1000),
      );
      
      // Feedback háptico más fuerte para el easter egg
      HapticFeedback.heavyImpact();
      
      // Navegar a diagnóstico sin reemplazar (usar push)
      Navigator.pushNamed(context, '/diagnostico');
    } else if (widget.currentIndex != 3) {
      // Solo navegar a contacto si no estamos ya ahí
      _navigateToRoute(3);
    }
  }

  void _navigateToRoute(int index) {
    final route = _routes[index];
    if (route != null) {
      // Optimización: usar pushReplacementNamed para mejor gestión de memoria
      Navigator.pushReplacementNamed(context, route);
    }
  }

  void _showDiscreteSnackBar(String message, {Duration? duration}) {
    // Optimización: verificar si el widget aún está montado
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: duration ?? Duration(milliseconds: 500),
        backgroundColor: Colors.grey[800],
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: 100, // Mostrar arriba del bottom nav
          left: 16,
          right: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
      ),
    );
  }
}