import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class PersonasJuridicasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personas Jurídicas",
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
            
            // Delegación en CAQ
            _buildDelegacionCAQCard(),
            
            SizedBox(height: 20),
            
            // Sede Central Provincial
            _buildSedeCentralCard(),
            
            SizedBox(height: 20),
            
            // Información adicional
            _buildInformacionAdicionalCard(),
            
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
                Icons.corporate_fare,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "Delegación de Personas Jurídicas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Dirección Provincial de Personas Jurídicas - Provincia de Buenos Aires",
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

  Widget _buildDelegacionCAQCard() {
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
                    "Delegación en CAQ Quilmes",
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
                    "El CAQ cuenta con una delegación de la Dirección Provincial de Personas Jurídicas en la sede central.",
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
            
            // Información de atención
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
                    valor: "Alvear 414, Planta Baja",
                    color: Color(0xFF009639),
                  ),
                  SizedBox(height: 16),
                  _buildInfoItem(
                    icono: Icons.access_time,
                    titulo: "Días de atención",
                    valor: "Lunes y Miércoles",
                    color: Color(0xFF009639),
                  ),
                  SizedBox(height: 16),
                  _buildInfoItem(
                    icono: Icons.schedule,
                    titulo: "Horario",
                    valor: "8:00 a 10:30 horas",
                    color: Color(0xFF009639),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Contacto de la delegación
            _buildContactoSection(
              titulo: "Contacto Delegación Quilmes",
              email: "ddppjdelegacionquilmes@gmail.com",
              color: Color(0xFF009639),
              descripcion: "Para consultas específicas de la delegación en Quilmes",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSedeCentralCard() {
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
                    Icons.account_balance,
                    color: Color(0xFF1976D2),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Sede Central Provincial",
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
            
            // Información de la sede central
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF3F7FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF1976D2).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  _buildInfoItem(
                    icono: Icons.location_on,
                    titulo: "Dirección",
                    valor: "Calle 6 esquina 48, La Plata",
                    color: Color(0xFF1976D2),
                  ),
                  SizedBox(height: 16),
                  _buildInfoItem(
                    icono: Icons.business,
                    titulo: "Organismo",
                    valor: "DPPJ Sede Central",
                    color: Color(0xFF1976D2),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Contacto sede central
            _buildContactoSection(
              titulo: "Contacto Sede Central",
              email: "privada.dppj@mjus.gba.gob.ar",
              color: Color(0xFF1976D2),
              descripcion: "Para consultas generales de la Dirección Provincial",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactoSection({
    required String titulo,
    required String email,
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
          SizedBox(height: 12),
          
          InkWell(
            onTap: () => _abrirEmail(email),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.email, color: color, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      size: 16,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 8),
          Text(
            descripcion,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformacionAdicionalCard() {
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
                    Icons.info_outline,
                    color: Color(0xFFFF9800),
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
                color: Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  _buildInfoPoint(
                    icono: Icons.access_time,
                    titulo: "Horario limitado",
                    descripcion: "La delegación atiende solo lunes y miércoles en horario matutino",
                  ),
                  SizedBox(height: 12),
                  _buildInfoPoint(
                    icono: Icons.event_note,
                    titulo: "Consulta previa",
                    descripcion: "Se recomienda contactar por email antes de acercarse",
                  ),
                  SizedBox(height: 12),
                  _buildInfoPoint(
                    icono: Icons.business_center,
                    titulo: "Trámites oficiales",
                    descripcion: "Solo se realizan trámites de personas jurídicas de la Provincia de Buenos Aires",
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
            color: Color(0xFFFF9800),
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
        // Botón para email delegación Quilmes
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _abrirEmail("ddppjdelegacionquilmes@gmail.com"),
            icon: Icon(Icons.email, size: 20),
            label: Text(
              "Contactar Delegación Quilmes",
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
        
        // Botón para email sede central
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _abrirEmail("privada.dppj@mjus.gba.gob.ar"),
            icon: Icon(Icons.business, size: 20),
            label: Text(
              "Contactar Sede Central La Plata",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1976D2),
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
        
        // Botón para contactar administración CAQ
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _contactarAdministracion,
            icon: Icon(Icons.chat, size: 20),
            label: Text(
              "Consultar en Administración CAQ",
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
        
        // Botones para copiar emails
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () => _copiarEmail("ddppjdelegacionquilmes@gmail.com"),
                icon: Icon(Icons.copy, size: 16),
                label: Text(
                  "Copiar email Quilmes",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextButton.icon(
                onPressed: () => _copiarEmail("privada.dppj@mjus.gba.gob.ar"),
                icon: Icon(Icons.copy, size: 16),
                label: Text(
                  "Copiar email La Plata",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ],
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
                  fontSize: 16,
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

  Future<void> _abrirEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Consulta - Personas Jurídicas',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Si no puede abrir la app de correo, copiar email al portapapeles
        _copiarEmail(email);
      }
    } catch (e) {
      print('Error al abrir correo: $e');
      // Fallback: copiar email al portapapeles
      _copiarEmail(email);
    }
  }

  void _copiarEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
  }

  Future<void> _contactarAdministracion() async {
    final message = "Hola, necesito información sobre la delegación de Personas Jurídicas en el CAQ";
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
}