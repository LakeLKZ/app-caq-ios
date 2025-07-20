import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class FirmaDigitalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Firma Digital",
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
            
            // ¿Qué es la firma digital?
            _buildQueEsCard(),
            
            SizedBox(height: 20),
            
            // Información del trámite
            _buildTramiteCard(),
            
            SizedBox(height: 20),
            
            // Beneficio para nuevos matriculados
            _buildBeneficioNuevosCard(),
            
            SizedBox(height: 20),
            
            // Reintegro de la Caja
            _buildReintegroCard(),
            
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
              Color(0xFF1565C0),
              Color(0xFF0D47A1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.verified_user,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "¿Cómo puedo tramitar mi Firma Digital?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "El CAQ es autoridad de registro para la tramitación de su firma digital",
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

  Widget _buildQueEsCard() {
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
                    Icons.info_outline,
                    color: Color(0xFF009639),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "¿Qué es la Firma Digital?",
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
                border: Border.all(color: Color(0xFF009639).withOpacity(0.3)),
              ),
              child: Text(
                "La firma digital es una herramienta tecnológica que nos permite asegurar la autoría de un documento o mensaje y verificar que su contenido no ha sido alterado, otorga validez jurídica, autenticidad e integridad del documento.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF009639),
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Beneficios
            Text(
              "Beneficios de la Firma Digital:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            SizedBox(height: 8),
            
            _buildBeneficioItem(Icons.security, "Asegura la autoría del documento"),
            _buildBeneficioItem(Icons.verified, "Verifica que no ha sido alterado"),
            _buildBeneficioItem(Icons.gavel, "Otorga validez jurídica"),
            _buildBeneficioItem(Icons.check_circle, "Garantiza autenticidad e integridad"),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficioItem(IconData icono, String texto) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icono, color: Color(0xFF009639), size: 16),
          SizedBox(width: 8),
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

  Widget _buildTramiteCard() {
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
                    color: Color(0x1A1565C0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.assignment,
                    color: Color(0xFF1565C0),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Información del Trámite",
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
            
            // Alertas importantes
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: Color(0xFFFF9800), size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "El trámite es personal y de modalidad presencial",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Información detallada
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE9ECEF)),
              ),
              child: Column(
                children: [
                  _buildInfoTramite(
                    icono: Icons.place,
                    titulo: "Ubicación",
                    valor: "Biblioteca del CAQ - Alvear 414, 1° subsuelo",
                  ),
                  SizedBox(height: 16),
                  _buildInfoTramite(
                    icono: Icons.access_time,
                    titulo: "Horario de atención",
                    valor: "8:00 a 16:00 horas",
                  ),
                  SizedBox(height: 16),
                  _buildInfoTramite(
                    icono: Icons.attach_money,
                    titulo: "Valor del token",
                    valor: "\$76.000",
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Solicitud de turno
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF1565C0).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.event, color: Color(0xFF1565C0), size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Para solicitar un turno:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  
                  InkWell(
                    onTap: () => _enviarEmailFirmaDigital(),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Color(0xFF1565C0).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.email, color: Color(0xFF1565C0), size: 20),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "firmadigital@caq.org.ar",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xFF1565C0).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.send,
                              size: 16,
                              color: Color(0xFF1565C0),
                            ),
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

  Widget _buildBeneficioNuevosCard() {
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
                    Icons.new_releases,
                    color: Color(0xFF4CAF50),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Beneficio para Nuevos Matriculados",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.discount, color: Color(0xFF4CAF50), size: 20),
                      SizedBox(width: 8),
                      Text(
                        "50% de descuento en el primer token",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "La Caja de Previsión Social para Abogados de la Provincia de Buenos Aires le aplicará el 50% del valor del token. El trámite deberá realizarlo en:",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        _buildInfoTramite(
                          icono: Icons.place,
                          titulo: "Delegación de la Caja del CAQ",
                          valor: "Alvear 414, 1° piso",
                        ),
                        SizedBox(height: 12),
                        _buildInfoTramite(
                          icono: Icons.description,
                          titulo: "Documentación",
                          valor: "Copia del comprobante emitido por el CAQ",
                        ),
                      ],
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

  Widget _buildReintegroCard() {
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
                    Icons.account_balance_wallet,
                    color: Color(0xFFFF6F00),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Reintegro por Compra de Token",
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
              "Caja de Previsión Social para Abogados de la Provincia de Buenos Aires",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            SizedBox(height: 12),
            
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
                    "La Caja le reintegrará en concepto de aportes a cuenta, mediante solicitud online, un monto correspondiente al valor del token hasta 2 JUS arancelarios.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Condiciones
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: Color(0xFF1976D2), size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Podrán acceder al beneficio quienes se encuentren dentro de los 12 primeros meses de matriculación al momento de solicitarlo",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF1976D2),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Portal de acceso
                  InkWell(
                    onTap: _abrirPortalCaja,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFFF6F00).withOpacity(0.1),
                            Color(0xFFFF6F00).withOpacity(0.05),
                          ],
                        ),
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
                              Icons.computer,
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
                                  "Portal Caja de Abogados",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF6F00),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "servicios.cajaabogados.org.ar",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.launch,
                            color: Color(0xFFFF6F00),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Pasos del trámite
                  Text(
                    "Pasos para solicitar el reintegro:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  _buildPasoReintegro(
                    numero: "1",
                    titulo: "Ingresar con tu usuario y contraseña",
                    descripcion: "Accede a servicios.cajaabogados.org.ar",
                  ),
                  _buildPasoReintegro(
                    numero: "2",
                    titulo: "Navegar a Trámites",
                    descripcion: "TRÁMITES > Trámites virtuales > selecciona \"reintegro por token\"",
                  ),
                  _buildPasoReintegro(
                    numero: "3",
                    titulo: "Cargar comprobante",
                    descripcion: "Sube el comprobante de compra del token",
                  ),
                  _buildPasoReintegro(
                    numero: "4",
                    titulo: "Confirmar trámite",
                    descripcion: "El reintegro se acreditará en la cuenta correspondiente de aportes",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasoReintegro({
    required String numero,
    required String titulo,
    required String descripcion,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFFFF6F00),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                numero,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
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

  Widget _buildBotonesAccion() {
    return Column(
      children: [
        // Botón para solicitar turno
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _enviarEmailFirmaDigital,
            icon: Icon(Icons.schedule, size: 20),
            label: Text(
              "Solicitar Turno para Firma Digital",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1565C0),
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
        
        // Botón para acceder al portal de la caja
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _abrirPortalCaja,
            icon: Icon(Icons.computer, size: 20),
            label: Text(
              "Portal Caja de Abogados",
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
            onPressed: () => _copiarEmail("firmadigital@caq.org.ar"),
            icon: Icon(Icons.copy, size: 18),
            label: Text(
              "Copiar email: firmadigital@caq.org.ar",
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

  Widget _buildInfoTramite({
    required IconData icono,
    required String titulo,
    required String valor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(0xFF1565C0),
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

  Future<void> _enviarEmailFirmaDigital() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'firmadigital@caq.org.ar',
      queryParameters: {
        'subject': 'Solicitud de turno para tramitar firma digital',
        'body': 'Estimados,\n\nQuisiera solicitar un turno para tramitar mi firma digital.\n\nMis datos de contacto:\nNombre: \nDNI: \nTeléfono: \nEmail: \n\nGracias por su atención.\n\nSaludos cordiales.',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _copiarEmail('firmadigital@caq.org.ar');
      }
    } catch (e) {
      print('Error al abrir correo: $e');
      _copiarEmail('firmadigital@caq.org.ar');
    }
  }

  Future<void> _abrirPortalCaja() async {
    const String portalUrl = "https://servicios.cajaabogados.org.ar";
    
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

  Future<void> _contactarAdministracion() async {
    final message = "Hola, necesito información sobre el trámite de firma digital";
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