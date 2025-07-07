import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BeneficiosMatriculadosScreen extends StatelessWidget {
  const BeneficiosMatriculadosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Beneficios para Matriculados",
          style: TextStyle(color: Color(0xFF009639)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF009639)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header verde independiente (no card)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF009639),
                    Color(0xFF007A2E),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.local_offer,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Beneficios Exclusivos para Matriculados",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Descuentos y promociones especiales en comercios adheridos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Beneficios por categoría
            _buildEducacionSection(),
            const SizedBox(height: 20),
            
            _buildDeporteSection(),
            const SizedBox(height: 20),
            
            _buildGastronomiaSection(),
            const SizedBox(height: 20),
            
            _buildSaludSection(),
            const SizedBox(height: 20),
            
            _buildLibreriaSection(),
            const SizedBox(height: 20),
            
            _buildTurismoSection(),
            const SizedBox(height: 20),
            
            _buildOtrosSection(),
            
            const SizedBox(height: 24),
            
          ],
        ),
      ),
    );
  }

  Widget _buildEducacionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Educación", Icons.school, const Color(0xFF1976D2)),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Instituto Ausonia de Quilmes",
          "Quilmes",
          "50% matrícula + 20% aranceles",
          const Color(0xFF1976D2),
          Icons.school,
        ),
      ],
    );
  }

  Widget _buildDeporteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Deporte y Fitness", Icons.fitness_center, const Color(0xFF388E3C)),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Compact Gym",
          "Quilmes",
          "20%",
          const Color(0xFF388E3C),
          Icons.fitness_center,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Rugby Don Bosco",
          "Quilmes",
          "3 meses sin cargo + 6 meses adicionales",
          const Color(0xFF388E3C),
          Icons.fitness_center,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Funky Dance! Estudio de Danza",
          "Gral. Smith N°344, Bernal",
          "20%",
          const Color(0xFF388E3C),
          Icons.fitness_center,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "El Balón Complejo Deportivo Fútbol 5",
          "Gral Smith N°344, Bernal",
          "20%",
          const Color(0xFF388E3C),
          Icons.fitness_center,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Cinquac Natación",
          "Guido N°450, Quilmes",
          "25% + 10% pago efectivo",
          const Color(0xFF388E3C),
          Icons.fitness_center,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Realwomen_OK Grupo de Entrenamiento",
          "Quilmes",
          "10%",
          const Color(0xFF388E3C),
          Icons.fitness_center,
        ),
      ],
    );
  }

  Widget _buildGastronomiaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Gastronomía", Icons.restaurant, const Color(0xFFFF5722)),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Señor V. (Venería)",
          "Quilmes",
          "20%",
          const Color(0xFFFF5722),
          Icons.restaurant,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Café Martínez",
          "Bdo. De Irigoyen N°1197, Quilmes",
          "10%",
          const Color(0xFFFF5722),
          Icons.restaurant,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Sushi Club",
          "Quilmes",
          "20%",
          const Color(0xFFFF5722),
          Icons.restaurant,
        ),
      ],
    );
  }

  Widget _buildSaludSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Salud y Estética", Icons.local_hospital, const Color(0xFFE91E63)),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Óptica Visión",
          "Berazategui",
          "10%",
          const Color(0xFFE91E63),
          Icons.local_hospital,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Centro de Estética Integral Fénix",
          "Quilmes",
          "20%",
          const Color(0xFFE91E63),
          Icons.local_hospital,
        ),
      ],
    );
  }

  Widget _buildLibreriaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Librería y Papelería", Icons.menu_book, const Color(0xFF7B1FA2)),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Libros de Derecho",
          "Quilmes",
          "10%",
          const Color(0xFF7B1FA2),
          Icons.menu_book,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Dimaqxxi Librería y Juguetería",
          "Rodolfo López 1249, Quilmes",
          "20%",
          const Color(0xFF7B1FA2),
          Icons.menu_book,
        ),
      ],
    );
  }

  Widget _buildTurismoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Turismo y Viajes", Icons.flight, const Color(0xFF00ACC1)),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Alejoy Travel Consultants",
          "Quilmes",
          "5%",
          const Color(0xFF00ACC1),
          Icons.flight,
        ),
      ],
    );
  }

  Widget _buildOtrosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Otros Servicios", Icons.local_offer, const Color(0xFF9E9E9E)),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Las Liben H",
          "CABA",
          "20%",
          const Color(0xFF9E9E9E),
          Icons.local_offer,
        ),
        const SizedBox(height: 12),
        _buildBeneficioCard(
          "Las Magnolias",
          "Calle Paz N°871, Quilmes",
          "20%",
          const Color(0xFF9E9E9E),
          Icons.local_offer,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficioCard(String nombre, String ubicacion, String descuento, Color color, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Ubicación
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          ubicacion,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Descuento
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      descuento,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformacionCard(IconData icon, String titulo, String descripcion) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descripcion,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _contactarAdministracion(BuildContext context) async {
    const message = "Hola, necesito información sobre los beneficios para matriculados del Colegio de Abogados de Quilmes";
    final whatsappUrl = "https://wa.me/5491158044895?text=${Uri.encodeComponent(message)}";

    try {
      final Uri uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir WhatsApp';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al abrir WhatsApp'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}