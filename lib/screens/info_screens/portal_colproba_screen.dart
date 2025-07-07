import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class PortalColprobaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Portal de Autogestión ColProba",
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
            
            // Acceso directo al portal
            _buildAccesoDirectoCard(),
            
            SizedBox(height: 20),
            
            // Actualización de datos - NUEVO
            _buildActualizacionDatosCard(),
            
            SizedBox(height: 20),
            
            // Trámites principales
            _buildTramitesPrincipalesCard(),
            
            SizedBox(height: 20),
            
            // Links de acceso
            _buildLinksAccesoCard(),
            
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
                Icons.computer,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "Portal de Autogestión del ColProba",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Colegio de Abogados de la Provincia de Buenos Aires",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "portal.colproba.org.ar",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccesoDirectoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: _abrirPortalColproba,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF009639).withOpacity(0.1),
                Color(0xFF009639).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF009639).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF009639),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.launch,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Acceder al Portal",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF009639),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Ingresa directamente al portal de autogestión",
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
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActualizacionDatosCard() {
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
                    Icons.edit,
                    color: Color(0xFF25D366),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "¿Queres cambiar tus datos?",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "¿Puedo actualizar mis datos en el CAQ?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25D366),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Podrás solicitar el formulario de actualización de datos por WhatsApp Administración o retirarlo en formato papel en Alvear 414, 1° piso, Quilmes.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Color(0xFF009639), size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "El CAQ procederá a realizar la actualización en el Portal de Autogestión del ColProba",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF009639),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Opciones de solicitud
                  Row(
                    children: [
                      Expanded(
                        child: _buildOpcionSolicitud(
                          icono: Icons.chat,
                          titulo: "Por WhatsApp",
                          subtitulo: "Solicitar formulario",
                          onTap: _solicitarFormularioWhatsApp,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildOpcionSolicitud(
                          icono: Icons.location_on,
                          titulo: "Presencial",
                          subtitulo: "Retirar en sede",
                          onTap: _informacionPresencial,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcionSolicitud({
    required IconData icono,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFF25D366).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icono, color: Color(0xFF25D366), size: 20),
            SizedBox(height: 6),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitulo,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTramitesPrincipalesCard() {
    final tramites = [
      _TramiteInfo("Su legajo personal", Icons.person, "Consulta y gestión de información personal"),
      _TramiteInfo("Actualización de datos personales", Icons.edit, "Modificar información de contacto"),
      _TramiteInfo("Cambios de domicilio constituido", Icons.home, "Actualizar domicilio legal"),
      _TramiteInfo("Sustitución de patrocinio letrado", Icons.swap_horizontal_circle, "Cambios en representación legal"),
      _TramiteInfo("Generación y pago del derecho fijo Ley 8480", Icons.receipt, "Bono verde y azul"),
      _TramiteInfo("Liquidaciones y actualizaciones de montos", Icons.calculate, "Cálculos actualizados"),
      _TramiteInfo("Guía de abogados y procuradores", Icons.book, "Directorio de la Provincia de Buenos Aires"),
      _TramiteInfo("Sistema MEDIARE", Icons.balance, "Plataforma de mediación"),
    ];

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
                    Icons.assignment,
                    color: Color(0xFF1976D2),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Trámites Disponibles",
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
            
            ...tramites.map((tramite) => _buildTramiteItem(tramite)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTramiteItem(_TramiteInfo tramite) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE9ECEF)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(0xFF1976D2).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              tramite.icono,
              color: Color(0xFF1976D2),
              size: 16,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tramite.nombre,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                if (tramite.descripcion.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Text(
                    tramite.descripcion,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksAccesoCard() {
    final links = [
      _LinkInfo("MEV (Mesa de Entradas Virtual)", Icons.input, "Presentaciones digitales"),
      _LinkInfo("Sistema de presentaciones y notificaciones electrónicas", Icons.notifications, "Gestión electrónica"),
      _LinkInfo("SIMP (consulta de causas penales)", Icons.gavel, "Consultas penales"),
      _LinkInfo("Suspensión de términos SCBA", Icons.pause_circle, "Gestión de plazos"),
      _LinkInfo("Generación de anticipo/pago tasa de justicia", Icons.payment, "Tasas judiciales"),
      _LinkInfo("Declaración jurada de mediación", Icons.description, "Declaraciones de mediación"),
      _LinkInfo("DNRPA", Icons.directions_car, "Registro Nacional de la Propiedad del Automotor"),
      _LinkInfo("Castro Boletín Oficial", Icons.article, "Publicaciones oficiales"),
      _LinkInfo("Registro de testamentos", Icons.assignment_ind, "Gestión testamentaria"),
      _LinkInfo("RPBA", Icons.business, "Registro de la Provincia de Buenos Aires"),
      _LinkInfo("DPPJ", Icons.corporate_fare, "Dirección Provincial de Personas Jurídicas"),
      _LinkInfo("Registro de las personas", Icons.people, "Registro civil"),
    ];

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
                    Icons.link,
                    color: Color(0xFF009639),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Links de Acceso Directo",
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
            
            // Mostrar links en grid de 1 columna para mejor legibilidad
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 4,
              ),
              itemCount: links.length,
              itemBuilder: (context, index) => _buildLinkItem(links[index]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem(_LinkInfo link) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF009639).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF009639).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            link.icono,
            color: Color(0xFF009639),
            size: 16,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  link.nombre,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (link.descripcion.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Text(
                    link.descripcion,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
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
                    icono: Icons.account_circle,
                    titulo: "Registro requerido",
                    descripcion: "Necesitas estar registrado en el portal para acceder a los servicios",
                  ),
                  SizedBox(height: 12),
                  _buildInfoPoint(
                    icono: Icons.security,
                    titulo: "Credenciales seguras",
                    descripcion: "Utiliza tus credenciales del Colegio de Abogados de la Provincia",
                  ),
                  SizedBox(height: 12),
                  _buildInfoPoint(
                    icono: Icons.support_agent,
                    titulo: "Soporte técnico",
                    descripcion: "Para problemas de acceso, contacta al soporte del ColProba",
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
        // Botón principal para acceder al portal
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _abrirPortalColproba,
            icon: Icon(Icons.computer, size: 20),
            label: Text(
              "Acceder al Portal ColProba",
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
        
        // Botón secundario para contactar administración
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _contactarAdministracion,
            icon: Icon(Icons.chat, size: 20),
            label: Text(
              "Consultar sobre el Portal",
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
        
        // Botón para copiar URL
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: _copiarURL,
            icon: Icon(Icons.copy, size: 18),
            label: Text(
              "Copiar URL del Portal",
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

  Future<void> _solicitarFormularioWhatsApp() async {
    final message = "Hola, quiero solicitar el formulario de actualización de datos para el Portal de Autogestión del ColProba";
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

  Future<void> _informacionPresencial() async {
    final message = "Hola, quiero información sobre cómo retirar el formulario de actualización de datos en la sede de Alvear 414";
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

  Future<void> _contactarAdministracion() async {
    final message = "Hola, necesito información sobre el Portal de Autogestión del ColProba";
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

  Future<void> _copiarURL() async {
    const String portalUrl = "https://portal.colproba.org.ar/";
    await Clipboard.setData(ClipboardData(text: portalUrl));
  }
}

// Clases auxiliares
class _TramiteInfo {
  final String nombre;
  final IconData icono;
  final String descripcion;

  _TramiteInfo(this.nombre, this.icono, this.descripcion);
}

class _LinkInfo {
  final String nombre;
  final IconData icono;
  final String descripcion;

  _LinkInfo(this.nombre, this.icono, this.descripcion);
}