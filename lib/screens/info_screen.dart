import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class InfoScreen extends StatelessWidget {
  // Lista de opciones de información
  final List<Map<String, dynamic>> infoOptions = [
    {
      'title': 'Turnos DNI',
      'icon': Icons.assignment_ind,
      'route': '/info/turnos'
    },
    {
      'title': 'Matrícula',
      'icon': Icons.card_membership,
      'route': '/info/matricula'
    },
    {
      'title': 'Servicios',
      'icon': Icons.business_center,
      'route': '/info/servicios'
    },
    {
      'title': 'Biblioteca',
      'icon': Icons.book,
      'route': '/info/biblioteca'
    },
    {
      'title': 'Tribunal de Disciplina',
      'icon': Icons.gavel,
      'route': '/info/tribunal'
    },
    {
      'title': 'Beneficios',
      'icon': Icons.card_giftcard,
      'route': '/info/beneficios'
    },
    {
      'title': 'Normativas',
      'icon': Icons.description,
      'route': '/info/normativas'
    },
    {
      'title': 'Preguntas Frecuentes',
      'icon': Icons.help,
      'route': '/info/faq'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Información",
          style: TextStyle(color: Color(0xFF009639)),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: infoOptions.length,
        itemBuilder: (context, index) {
          final option = infoOptions[index];
          
          return Card(
            margin: EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, option['route']),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0x1A009639), // Verde con opacidad
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  option['icon'],
                  color: Color(0xFF009639),
                ),
              ),
              title: Text(
                option['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}