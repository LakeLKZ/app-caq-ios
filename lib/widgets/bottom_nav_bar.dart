import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

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
    4: '/perfil', // Nueva ruta para perfil
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
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Perfil',
      tooltip: 'Mi Perfil',
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
    if (index == widget.currentIndex && index != 3 && index != 4) {
      return; // No hacer nada si ya estamos en la misma pantalla (excepto contacto y perfil)
    }
    
    // Feedback háptico optimizado
    HapticFeedback.selectionClick();
    
    if (index == 3) {
      _handleContactTap();
    } else if (index == 4) {
      _handleProfileTap();
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

  void _handleProfileTap() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    if (!userProvider.isLoggedIn) {
      // Si no está logueado, ir al login
      Navigator.pushNamed(context, '/login');
      return;
    }
    
    // Si está logueado, mostrar perfil en modal
    _showProfileModal();
  }

  void _showProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Column(
              children: [
                // Handle del modal
                Container(
                  margin: EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Header
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        'Mi Perfil',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003366),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Avatar y nombre
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFF009639),
                          child: Text(
                            userProvider.userName.split(' ')
                                .map((e) => e.isNotEmpty ? e[0] : '')
                                .take(2)
                                .join()
                                .toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        Text(
                          userProvider.userName,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                        
                        SizedBox(height: 8),
                        
                        Text(
                          'DNI: ${userProvider.userDni}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        
                        SizedBox(height: 30),
                        
                        // Información del usuario
                        _buildInfoCard('Email', userProvider.userEmail, Icons.email),
                        _buildInfoCard('WhatsApp', userProvider.userWhatsapp, Icons.phone),
                        _buildInfoCard('Tomo', userProvider.userTomo, Icons.book),
                        _buildInfoCard('Folio', userProvider.userFolio, Icons.description),
                        
                        SizedBox(height: 30),
                        
                        // Botón de logout
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _showLogoutDialog(userProvider),
                            icon: Icon(Icons.logout),
                            label: Text('Cerrar Sesión'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Color(0xFF009639)),
          SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF003366),
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar Sesión'),
          content: Text('¿Estás seguro que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar dialog
                Navigator.of(context).pop(); // Cerrar modal
                await userProvider.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToRoute(int index) {
    final route = _routes[index];
    if (route != null && route != '/perfil') {
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