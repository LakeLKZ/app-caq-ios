import 'package:flutter/material.dart';

class InfoDetailScreen extends StatelessWidget {
  final String title;
  final String route;

  const InfoDetailScreen({
    Key? key,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Color(0xFF009639)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF009639)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildContent(),
      ),
    );
  }

  // Contenido de la página según la ruta
  Widget _buildContent() {
    // Este es un contenido estático de ejemplo
    // Que puede ser personalizado según la ruta
    
    switch (route) {
      case 'turnos':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Turnos DNI'),
            _buildParagraph(
              'Para solicitar un turno para el trámite de DNI, debe presentarse con la siguiente documentación:'
            ),
            _buildBulletPoint('Documento de identidad original'),
            _buildBulletPoint('Partida de nacimiento (en caso de primer DNI)'),
            _buildBulletPoint('Comprobante de domicilio'),
            _buildBulletPoint('Constancia de matrícula vigente'),
            SizedBox(height: 16),
            _buildParagraph(
              'Los turnos se asignan de lunes a viernes de 9:00 a 15:00 hs.'
            ),
            SizedBox(height: 24),
            _buildInfoBox(
              'Los turnos deben solicitarse con al menos 48 horas de anticipación.',
              Icons.access_time
            ),
          ],
        );
        
      case 'matricula':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Matrícula Profesional'),
            _buildParagraph(
              'La matrícula profesional es el registro que habilita al abogado a ejercer la profesión.'
            ),
            _buildParagraph(
              'Para matricularse en el Colegio de Abogados de Quilmes debe presentar:'
            ),
            _buildBulletPoint('Título original y copia'),
            _buildBulletPoint('DNI original y copia'),
            _buildBulletPoint('2 fotos carnet'),
            _buildBulletPoint('Abonar el arancel correspondiente'),
            SizedBox(height: 16),
            _buildParagraph(
              'La renovación anual de la matrícula debe realizarse antes del vencimiento para evitar recargos.'
            ),
            SizedBox(height: 24),
            _buildInfoBox(
              'El trámite de matriculación se realiza personalmente en la sede del Colegio.',
              Icons.person
            ),
          ],
        );
        
      // Para el resto de opciones
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Icon(
              Icons.construction,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 24),
            Text(
              'Próximamente',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Estamos trabajando para brindarte información detallada sobre esta sección.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        );
    }
  }

  // Widgets auxiliares para construir el contenido
  
  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF003366),
        ),
      ),
    );
  }
  
  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
  
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF009639),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoBox(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0x1A009639), // Verde con opacidad
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Color(0xFF009639),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}