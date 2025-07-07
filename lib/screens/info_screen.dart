// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Información",
          style: TextStyle(color: Color(0xFF009639)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Card para Portal ColProba - NUEVO (ubicado al principio por importancia)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/portal-colproba'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1A1976D2), // Azul con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.computer,
                          color: Color(0xFF1976D2),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Portal de Autogestión ColProba',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Trámites online del Colegio Provincial',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF1976D2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Sedes y Horarios
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/sedes-horarios'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1A009639), // Verde con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_city,
                          color: Color(0xFF009639),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Text(
                          'Sedes y Horarios',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF009639),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Correos Útiles
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/correos-utiles'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1A2196F3), // Azul con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mail_outline,
                          color: Color(0xFF2196F3),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Text(
                          'Correos Útiles',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF2196F3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Beneficios para Matriculados - NUEVO
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/beneficios-matriculados'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1AFF9800), // Naranja con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.local_offer,
                          color: Color(0xFFFF9800),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Beneficios para Matriculados',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Descuentos exclusivos en comercios adheridos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFFFF9800),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Pago de Matrícula
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/matricula-pago'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1A4CAF50), // Verde con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.card_membership,
                          color: Color(0xFF4CAF50),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Text(
                          'Pago de Matrícula',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF4CAF50),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Renovación de Credencial
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/renovacion-credencial'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1AFF9800), // Naranja con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.badge,
                          color: Color(0xFFFF9800),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Text(
                          'Renovación de Credencial',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFFFF9800),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Certificado de Matrícula
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/certificado-matricula'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1A9C27B0), // Púrpura con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_user,
                          color: Color(0xFF9C27B0),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Text(
                          'Certificado de Matrícula',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF9C27B0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Credencial de Empleado de Estudio
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/credencial-empleado'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1AFF5722), // Rojo-naranja con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.work_outline,
                          color: Color(0xFFFF5722),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Text(
                          'Credencial de Empleado de Estudio',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFFFF5722),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Credencial de Mediador/a
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/credencial-mediador'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1A7B1FA2), // Púrpura mediación con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.balance,
                          color: Color(0xFF7B1FA2),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Text(
                          'Credencial de Mediador/a',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF7B1FA2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Card para Sustitución de Patrocinio Letrado
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/info/sustitucion-patrocinio'),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Ícono
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0x1A7B1FA2), // Púrpura con opacidad
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.swap_horizontal_circle,
                          color: Color(0xFF7B1FA2),
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 20),
                      
                      // Contenido
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sustitución de Patrocinio Letrado',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Cómo realizar el aviso de sustitución',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Flecha
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF7B1FA2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}