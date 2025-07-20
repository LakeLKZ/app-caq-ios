import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class DniPasaporteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DNI y Pasaporte",
          style: TextStyle(color: Color(0xFF009639)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF009639)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header principal
            _buildHeaderCard(),
            
            SizedBox(height: 20),
            
            // Centro de Documentación
            _buildCentroDocumentacionCard(),
            
            SizedBox(height: 20),
            
            // Servicios disponibles
            _buildServiciosCard(),
            
            SizedBox(height: 20),
            
            // Solicitud de turno
            _buildSolicitudTurnoCard(),
            
            SizedBox(height: 20),
            
            // Información importante
            _buildInformacionImportanteCard(),
            
            SizedBox(height: 20),
            
            // Botones de acción
            _buildBotonesAccion(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1976D2),
              Color(0xFF1565C0),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.assignment_ind,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "¿Cómo puedo tramitar mi DNI y Pasaporte?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Centro de Documentación ReNaPer en el CAQ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCentroDocumentacionCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x1A009639),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_city,
                    color: Color(0xFF009639),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Centro de Documentación ReNaPer",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Información principal
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF009639).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "El CAQ cuenta con un Centro de Documentación dependiente del Registro Nacional de las Personas (ReNaPer).",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF009639),
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Información de ubicación
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE9ECEF)),
              ),
              child: Column(
                children: [
                  _buildInfoItem(
                    icono: Icons.place,
                    titulo: "Ubicación",
                    valor: "Alvear 414, Planta Baja, Quilmes",
                    color: Color(0xFF009639),
                  ),
                  SizedBox(height: 16),
                  _buildInfoItem(
                    icono: Icons.business,
                    titulo: "Organismo",
                    valor: "Dependiente del Registro Nacional de las Personas",
                    color: Color(0xFF009639),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiciosCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x1A1976D2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.description,
                    color: Color(0xFF1976D2),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Servicios Disponibles",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Beneficiarios
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF1976D2).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, color: Color(0xFF1976D2), size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Servicio exclusivo para:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildBeneficiarioItem("Matriculados del CAQ"),
                  _buildBeneficiarioItem("Grupo familiar de matriculados"),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Lista de servicios
            Text(
              "Trámites que puede realizar:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            SizedBox(height: 12),
            
            _buildServicioItem(
              icono: Icons.badge,
              titulo: "Tramitación de DNI",
              descripcion: "Documento Nacional de Identidad - Primera vez y renovaciones",
            ),
            SizedBox(height: 12),
            _buildServicioItem(
              icono: Icons.home,
              titulo: "Cambio de domicilio",
              descripcion: "Actualización de domicilio en el DNI",
            ),
            SizedBox(height: 12),
            _buildServicioItem(
              icono: Icons.flight,
              titulo: "Tramitación de Pasaporte",
              descripcion: "Pasaporte argentino - Primera vez y renovaciones",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficiarioItem(String texto) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFF1976D2),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              texto,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicioItem({
    required IconData icono,
    required String titulo,
    required String descripcion,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE9ECEF)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF1976D2).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icono,
              color: Color(0xFF1976D2),
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  descripcion,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolicitudTurnoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x1AFF6F00),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.event,
                    color: Color(0xFFFF6F00),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Solicitud de Turno",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFFF6F00).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Para solicitar turno para tramitar DNI, cambio de domicilio y pasaporte:",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  InkWell(
                    onTap: () => _enviarEmailDni(),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFFF6F00).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF6F00),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enviar solicitud por email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF6F00),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "dni@caq.org.ar",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.send,
                            color: Color(0xFFFF6F00),
                            size: 20,
                          ),
                        ],
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

  Widget _buildInformacionImportanteCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x1A4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Color(0xFF4CAF50),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Información Importante",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  _buildInfoPoint(
                    icono: Icons.schedule,
                    titulo: "Solicitud previa obligatoria",
                    descripcion: "Es necesario solicitar turno por email antes de acercarse",
                  ),
                  SizedBox(height: 12),
                  _buildInfoPoint(
                    icono: Icons.people,
                    titulo: "Servicio exclusivo",
                    descripcion: "Solo para matriculados del CAQ y su grupo familiar",
                  ),
                  SizedBox(height: 12),
                  _buildInfoPoint(
                    icono: Icons.description,
                    titulo: "Documentación requerida",
                    descripcion: "Consulte los requisitos específicos al solicitar el turno",
                  ),
                  SizedBox(height: 12),
                  _buildInfoPoint(
                    icono: Icons.location_on,
                    titulo: "Ubicación específica",
                    descripcion: "Planta baja de la sede central del CAQ",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoPoint({
    required IconData icono,
    required String titulo,
    required String descripcion,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(0xFF4CAF50),
            shape: BoxShape.circle,
          ),
          child: Icon(icono, color: Colors.white, size: 14),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
              SizedBox(height: 2),
              Text(
                descripcion,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBotonesAccion() {
    return Column(
      children: [
        // Botón principal para solicitar turno
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _enviarEmailDni,
            icon: Icon(Icons.schedule, size: 20),
            label: Text(
              "Solicitar Turno por Email",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF6F00),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        ),
        
        SizedBox(height: 12),
        
        // Botón para contactar administración
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _contactarAdministracion,
            icon: Icon(Icons.chat, size: 20),
            label: Text(
              "Consultar en Administración",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Color(0xFF009639),
              side: BorderSide(color: Color(0xFF009639), width: 2),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 12),
        
        // Botón para copiar email
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () => _copiarEmail("dni@caq.org.ar"),
            icon: Icon(Icons.copy, size: 18),
            label: Text(
              "Copiar email: dni@caq.org.ar",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[700],
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icono,
    required String titulo,
    required String valor,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icono, color: Colors.white, size: 16),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 2),
              Text(
                valor,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _enviarEmailDni() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'dni@caq.org.ar',
      queryParameters: {
        'subject': 'Solicitud de turno - Centro de Documentación ReNaPer',
        'body': 'Estimados,\n\nQuisiera solicitar un turno para realizar el siguiente trámite:\n\n[ ] DNI (primera vez / renovación)\n[ ] Cambio de domicilio\n[ ] Pasaporte (primera vez / renovación)\n\nMis datos:\nNombre completo: \nDNI: \nMatrícula CAQ: \nTeléfono: \nEmail: \n\nFecha y horario preferido: \n\nGracias por su atención.\n\nSaludos cordiales.',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _copiarEmail('dni@caq.org.ar');
      }
    } catch (e) {
      print('Error al abrir correo: $e');
      _copiarEmail('dni@caq.org.ar');
    }
  }

  Future<void> _contactarAdministracion() async {
    final message = "Hola, necesito información sobre el Centro de Documentación ReNaPer del CAQ";
    final whatsappUrl = "https://wa.me/5491158044895?text=${Uri.encodeComponent(message)}";
    
    try {
      final Uri uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir WhatsApp';
      }
    } catch (e) {
      print('Error al abrir WhatsApp: $e');
    }
  }

  void _copiarEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
  }
}