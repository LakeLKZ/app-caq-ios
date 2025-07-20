import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class ServiciosOcaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Servicios OCA",
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
            
            // Servicios de Carta Documento
            _buildCartaDocumentoCard(),
            
            SizedBox(height: 20),
            
            // Servicios de Envío de Sobres
            _buildEnvioSobresCard(),
            
            SizedBox(height: 20),
            
            // Información de contacto
            _buildContactoCard(),
            
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
              Color(0xFFFF6F00), // Naranja OCA
              Color(0xFFE65100),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.local_post_office,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "Servicios OCA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Envío de carta documento y sobres a través del CAQ",
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

  Widget _buildCartaDocumentoCard() {
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
                    "Carta Documento OCA",
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
            
            Text(
              "Le informamos que cuenta con 2 formas de envío en el servicio de carta documento OCA:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Opción 1: Presencial
            _buildOpcionServicio(
              numero: "1",
              titulo: "Presencial",
              precio: "\$15.500",
              icono: Icons.store,
              color: Color(0xFF009639),
              detalles: [
                "📍 Sede Central: Alvear 414, 1° piso",
                "📍 Anexo CAQ: Colón 333, 4° piso",
                "🕐 Horario: 8:00 a 14:00 horas",
                "📄 Presentación en modo papel",
              ],
            ),
            
            SizedBox(height: 16),
            
            // Opción 2: Online
            _buildOpcionServicio(
              numero: "2",
              titulo: "Online",
              precio: "\$14.500",
              icono: Icons.computer,
              color: Color(0xFF1976D2),
              detalles: [
                "💻 Gestión disponible 24/7",
                "✍️ Firma digital incluida",
                "📧 Acuse de recibo automático",
                "📁 Documentación guardada por 5 años",
                "💳 Sistema de créditos con transferencia bancaria",
              ],
              mostrarBeneficios: true,
            ),
            
            SizedBox(height: 16),
            
            // Información sobre solicitud de usuario online
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
                      Icon(Icons.person_add, color: Color(0xFF1976D2), size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Para usar la opción Online:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Deberá solicitar su usuario en nuestro Centro de Mediación:",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildContactoInfo(Icons.phone, "WhatsApp", "11 6505-2181"),
                  SizedBox(height: 6),
                  _buildContactoInfo(Icons.email, "Email", "mediacion@caq.org.ar"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcionServicio({
    required String numero,
    required String titulo,
    required String precio,
    required IconData icono,
    required Color color,
    required List<String> detalles,
    bool mostrarBeneficios = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la opción
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    numero,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Icon(icono, color: color, size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  precio,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Detalles
          if (mostrarBeneficios) ...[
            Text(
              "Beneficios:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
          ],
          
          ...detalles.map((detalle) => Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              detalle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.3,
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildEnvioSobresCard() {
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
                    color: Color(0x1AFF9800),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mail,
                    color: Color(0xFFFF9800),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Servicio OCA para Envío de Sobres",
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
            
            Text(
              "Podrá realizar el envío de sobres a través del CAQ:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Información de sede
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE9ECEF)),
              ),
              child: Column(
                children: [
                  _buildInfoItem(Icons.place, "Sede", "Alvear 414, 1° piso"),
                  SizedBox(height: 12),
                  _buildInfoItem(Icons.access_time, "Horario", "8:00 a 14:00 horas"),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Tipos de envío
            _buildTipoEnvio(
              titulo: "OCA SIMPLE",
              precio: "\$3.760",
              color: Color(0xFF4CAF50),
              descripcion: "Envío estándar de sobres",
            ),
            
            SizedBox(height: 12),
            
            _buildTipoEnvio(
              titulo: "OCA POSTAL",
              precio: "\$10.470",
              color: Color(0xFF2196F3),
              descripcion: "Envío con seguimiento postal",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipoEnvio({
    required String titulo,
    required String precio,
    required Color color,
    required String descripcion,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_shipping,
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
                  titulo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  descripcion,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              precio,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactoCard() {
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
                    color: Color(0x1A25D366),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.contact_support,
                    color: Color(0xFF25D366),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Información de Contacto",
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
                color: Color(0xFFF0FFF4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF25D366).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    "Centro de Mediación",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25D366),
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildContactoInfo(Icons.phone, "WhatsApp", "11 6505-2181"),
                  SizedBox(height: 8),
                  _buildContactoInfo(Icons.email, "Email", "mediacion@caq.org.ar"),
                  SizedBox(height: 16),
                  Text(
                    "Para solicitar usuario de carta documento online",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactoInfo(IconData icono, String tipo, String valor) {
    return Row(
      children: [
        Icon(icono, color: Color(0xFF25D366), size: 16),
        SizedBox(width: 8),
        Text(
          "$tipo: ",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            valor,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF25D366),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBotonesAccion() {
    return Column(
      children: [
        // Botón para contactar Centro de Mediación
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _contactarCentroMediacion,
            icon: Icon(Icons.chat, size: 20),
            label: Text(
              "Contactar Centro de Mediación",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF25D366),
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
        
        // Botón para contactar Administración
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _contactarAdministracion,
            icon: Icon(Icons.info, size: 20),
            label: Text(
              "Consultar sobre Servicios OCA",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Color(0xFFFF9800),
              side: BorderSide(color: Color(0xFFFF9800), width: 2),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 12),
        
        // Botón para enviar email
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: _enviarEmailMediacion,
            icon: Icon(Icons.email, size: 18),
            label: Text(
              "Enviar email a mediacion@caq.org.ar",
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

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFFFF9800), size: 20),
        SizedBox(width: 12),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _contactarCentroMediacion() async {
    final message = "Hola, necesito información sobre el servicio de carta documento OCA online y solicitar usuario";
    final whatsappUrl = "https://wa.me/541165052181?text=${Uri.encodeComponent(message)}";
    
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

  Future<void> _contactarAdministracion() async {
    final message = "Hola, necesito información sobre los servicios OCA disponibles en el CAQ";
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

  Future<void> _enviarEmailMediacion() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mediacion@caq.org.ar',
      queryParameters: {
        'subject': 'Consulta sobre servicios OCA - Carta documento online',
        'body': 'Estimados,\n\nQuisiera obtener información sobre el servicio de carta documento OCA online y solicitar mi usuario para acceder a la plataforma.\n\nGracias por su atención.\n\nSaludos cordiales.',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Si no puede abrir la app de correo, copiar email al portapapeles
        Clipboard.setData(ClipboardData(text: 'mediacion@caq.org.ar'));
      }
    } catch (e) {
      print('Error al abrir correo: $e');
      // Fallback: copiar email al portapapeles
      Clipboard.setData(ClipboardData(text: 'mediacion@caq.org.ar'));
    }
  }
}