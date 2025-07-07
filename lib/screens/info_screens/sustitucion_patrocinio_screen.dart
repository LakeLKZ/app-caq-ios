import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class SustitucionPatrocinioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sustitución de Patrocinio Letrado",
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
            
            // Opción vía web (Portal de Autogestión)
            _buildOpcionWebCard(),
            
            SizedBox(height: 20),
            
            // Opciones alternativas cuando no hay email registrado
            _buildOpcionesAlternativasCard(),
            
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
                Icons.swap_horizontal_circle,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "¿Cómo debo realizar el aviso de sustitución de patrocinio letrado?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Todas las opciones disponibles para realizar la sustitución",
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

  Widget _buildOpcionWebCard() {
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
                    Icons.computer,
                    color: Color(0xFF009639),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Opción Vía Web - Sin Cargo",
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
            
            // Acceso directo al portal
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: _abrirPortalColproba,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF009639).withOpacity(0.1),
                        Color(0xFF009639).withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF009639).withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF009639),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.launch,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Portal de Autogestión ColProba",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF009639),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "portal.colproba.org.ar",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF009639),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Condiciones para usar la opción web
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
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF009639), size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Requisito para usar esta opción:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF009639),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Podrá realizarlo por este medio siempre y cuando el profesional al que sustituya registre un correo electrónico en el portal.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Beneficios de la opción web
                  Text(
                    "Beneficios:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009639),
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  _buildBeneficioItem(
                    icono: Icons.email,
                    texto: "Recibirá por correo electrónico aviso de recibo",
                  ),
                  _buildBeneficioItem(
                    icono: Icons.picture_as_pdf,
                    texto: "Documento PDF con constancia del trámite",
                  ),
                  _buildBeneficioItem(
                    icono: Icons.history,
                    texto: "Podrá visualizar listado histórico de todas las sustituciones realizadas",
                  ),
                  _buildBeneficioItem(
                    icono: Icons.verified,
                    texto: "El CAQ validará el trámite automáticamente",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficioItem({required IconData icono, required String texto}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color(0xFF009639),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icono,
              color: Colors.white,
              size: 12,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              texto,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpcionesAlternativasCard() {
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
                    Icons.warning_amber,
                    color: Color(0xFFFF9800),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Si el colega no registra email",
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
                border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
              ),
              child: Text(
                "Si la/el colega que debe ser sustituido no registrara un correo electrónico en el portal de autogestión, deberá usar una de estas opciones:",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFE65100),
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Opción Presencial
            _buildOpcionAlternativa(
              titulo: "Presencial",
              icono: Icons.location_on,
              color: Color(0xFF2196F3),
              detalles: [
                "📍 Presentar formulario en Alvear 414, 1° piso",
                "🕐 Horario: 8:00 a 13:00 horas",
                "📄 Formulario en papel debidamente cumplimentado",
                "📮 El Colegio se hará cargo del envío postal",
              ],
            ),
            
            SizedBox(height: 16),
            
            // Opción por Correo Electrónico
            _buildOpcionAlternativa(
              titulo: "Correo Electrónico",
              icono: Icons.email,
              color: Color(0xFF7B1FA2),
              detalles: [
                "📧 Solicitar formulario en formato PDF",
                "✍️ Completar y firmar debidamente",
                "📤 Enviar a: tomas@caq.org.ar",
                "⚡ En el transcurso del día recibirá copia sellada como constancia",
              ],
            ),
            
            SizedBox(height: 16),
            
            // Botón para solicitar formulario por email
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _solicitarFormularioEmail,
                icon: Icon(Icons.email, size: 18),
                label: Text(
                  "Solicitar formulario por email",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B1FA2),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcionAlternativa({
    required String titulo,
    required IconData icono,
    required Color color,
    required List<String> detalles,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, color: color, size: 20),
              SizedBox(width: 8),
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
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

  Widget _buildBotonesAccion() {
    return Column(
      children: [
        // Botón principal - Portal ColProba
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _abrirPortalColproba,
            icon: Icon(Icons.computer, size: 20),
            label: Text(
              "Acceder al Portal de Autogestión",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF009639),
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
        
        // Botón secundario - Contactar administración
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _contactarAdministracion,
            icon: Icon(Icons.chat, size: 20),
            label: Text(
              "Consultar sobre Sustitución",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Color(0xFF1976D2),
              side: BorderSide(color: Color(0xFF1976D2), width: 2),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 12),
        
        // Botón para copiar email de Tomás
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: _copiarEmailTomas,
            icon: Icon(Icons.copy, size: 18),
            label: Text(
              "Copiar email: tomas@caq.org.ar",
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

  Future<void> _abrirPortalColproba() async {
    const String portalUrl = "https://portal.colproba.org.ar/";
    
    try {
      final Uri uri = Uri.parse(portalUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir el portal';
      }
    } catch (e) {
      print('Error al abrir portal: $e');
    }
  }

  Future<void> _solicitarFormularioEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'tomas@caq.org.ar',
      queryParameters: {
        'subject': 'Solicitud de formulario de sustitución de patrocinio letrado',
        'body': 'Estimado Tomás,\n\nSolicito el formulario de sustitución de patrocinio letrado en formato PDF.\n\nGracias por su atención.\n\nSaludos cordiales.',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Si no puede abrir la app de correo, mostrar información
        _mostrarInfoEmail();
      }
    } catch (e) {
      print('Error al abrir correo: $e');
      _mostrarInfoEmail();
    }
  }

  void _mostrarInfoEmail() {
    // Aquí podrías mostrar un diálogo con la información del email
    // o copiar automáticamente el email al portapapeles
    _copiarEmailTomas();
  }

  Future<void> _contactarAdministracion() async {
    final message = "Hola, necesito información sobre sustitución de patrocinio letrado";
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

  void _copiarEmailTomas() {
    Clipboard.setData(ClipboardData(text: 'tomas@caq.org.ar'));
  }
}