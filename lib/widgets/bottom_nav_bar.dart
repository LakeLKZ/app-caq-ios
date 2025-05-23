import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  // Constructor con const para evitar el error
  const BottomNavBar({required this.currentIndex});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Contador para activar la pantalla de diagnóstico
  int _contactTapCount = 0;
  DateTime? _lastTapTime;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      selectedItemColor: Color(0xFF009639),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        // Si el índice es diferente al actual, navegar a esa pantalla
        if (index != widget.currentIndex) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/cursos');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/info');
              break;
            case 3: // Contacto
              _handleContactTap(context);
              break;
          }
        } else if (index == 3) {
          // Si ya estamos en la pantalla de contacto y se toca de nuevo
          _handleContactTap(context);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Cursos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: 'Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_phone),
          label: 'Contacto',
        ),
      ],
    );
  }

  void _handleContactTap(BuildContext context) {
    final now = DateTime.now();
    
    // Reiniciar contador si ha pasado más de 3 segundos desde el último tap
    if (_lastTapTime != null && 
        now.difference(_lastTapTime!).inSeconds > 3) {
      _contactTapCount = 0;
    }
    
    _lastTapTime = now;
    _contactTapCount++;
    
    // Mensaje más discreto para el usuario (opcional)
    if (_contactTapCount >= 2 && _contactTapCount < 5) {
      // Puedes comentar esta sección si prefieres que sea completamente oculto
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${5 - _contactTapCount} toques más para diagnóstico"),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.grey[800],
        ),
      );
    }
    
    // Si se alcanzaron los 5 toques, abrir la pantalla de diagnóstico
    if (_contactTapCount >= 5) {
      _contactTapCount = 0; // Reiniciar contador
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      
      // Navegar a la pantalla de diagnóstico usando pushNamed en lugar de pushReplacementNamed
      Navigator.pushNamed(context, '/diagnostico');
    } else if (widget.currentIndex != 3) {
      // Solo navegar a contacto si no estamos ya en esa pantalla
      Navigator.pushReplacementNamed(context, '/contacto');
    }
  }
}