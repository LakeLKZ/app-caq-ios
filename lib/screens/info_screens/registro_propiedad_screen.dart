import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class RegistroPropiedadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registro de la Propiedad",
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
            
            // Información del servicio
            _buildServicioCard(),
            
            SizedBox(height: 20),
            
            // Formularios disponibles
            _buildFormulariosCard(),
            
            SizedBox(height: 20),
            
            // Proceso de alta
            _buildAltaCard(),
            
            SizedBox(height: 20),
            
            // Compra de créditos
            _buildCreditosCard(),
            
            SizedBox(height: 20),
            
            // Links útiles
            _buildLinksCard(),
            
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
                Icons.home_work,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "¿Cómo puedo tramitar mi usuario ante el RPBA?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Registro de la Propiedad de la Provincia de Buenos Aires",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Formularios online (RPI)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicioCard() {
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
                    Icons.verified,
                    color: Color(0xFF009639),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "CAQ Delegación Habilitada",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "El CAQ es delegación habilitada del RPBA para:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009639),
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildServicioItem("Alta de usuarios profesionales matriculados en el CAQ"),
                  _buildServicioItem("Venta de créditos para generación online de formularios"),
                  _buildServicioItem("Gestión de formularios RPI (Registro de la Propiedad Inmueble)"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicioItem(String texto) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFF009639),
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
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulariosCard() {
    final formularios = [
      _FormularioInfo("750", "Certificado de Dominio", Icons.description),
      _FormularioInfo("751", "Certificado de Anotaciones Personales / Cesión", Icons.person_outline),
      _FormularioInfo("752", "Informe de Dominio", Icons.info_outline),
      _FormularioInfo("753", "Informe Anotaciones Personales / Cesión", Icons.assignment_ind),
      _FormularioInfo("754", "Copia de Dominio", Icons.content_copy),
      _FormularioInfo("755", "Consulta al Índice de Titulares", Icons.search),
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
                    Icons.list_alt,
                    color: Color(0xFF1976D2),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Formularios Disponibles",
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
              "Formularios online que puede generar:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16),
            
            ...formularios.map((formulario) => _buildFormularioItem(formulario)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormularioItem(_FormularioInfo formulario) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
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
              color: Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              formulario.numero,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(width: 12),
          Icon(
            formulario.icono,
            color: Color(0xFF1976D2),
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              formulario.descripcion,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF003366),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAltaCard() {
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
                    Icons.person_add,
                    color: Color(0xFF4CAF50),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Alta de Usuario",
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
                  Text(
                    "Proceso de alta:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  _buildPasoAlta(
                    numero: "1",
                    descripcion: "Cumplimentar formulario y enviarlo al CAQ",
                  ),
                  _buildPasoAlta(
                    numero: "2",
                    descripcion: "El CAQ procederá al alta como usuario",
                  ),
                  _buildPasoAlta(
                    numero: "3",
                    descripcion: "Se le informará el PIN asignado para su suscripción",
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Opciones de tramitación
                  Text(
                    "Modalidades de tramitación:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  _buildModalidadAlta(
                    icono: Icons.store,
                    titulo: "Presencial",
                    descripcion: "Alvear 414, 1° piso\nHorario: 8:00 a 16:00 hs",
                  ),
                  SizedBox(height: 12),
                  _buildModalidadAlta(
                    icono: Icons.chat,
                    titulo: "A distancia",
                    descripcion: "WhatsApp Tesorería CAQ\n11 4870-0655",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasoAlta({required String numero, required String descripcion}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50),
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
            child: Text(
              descripcion,
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

  Widget _buildModalidadAlta({
    required IconData icono,
    required String titulo,
    required String descripcion,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icono, color: Color(0xFF4CAF50), size: 20),
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
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(height: 4),
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
      ),
    );
  }

  Widget _buildCreditosCard() {
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
                    Icons.payment,
                    color: Color(0xFFFF9800),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Compra de Créditos",
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
            
            // Valor del crédito
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_money, color: Color(0xFFFF9800), size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Valor por crédito",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          "\$8.100",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE65100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Modalidades de compra
            Text(
              "Modalidades de compra:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            SizedBox(height: 12),
            
            _buildModalidadCompra(
              icono: Icons.store,
              titulo: "Presencial",
              descripcion: "Alvear 414, 1° piso - Horario: 8:00 a 16:00 hs",
            ),
            SizedBox(height: 12),
            _buildModalidadCompra(
              icono: Icons.account_balance,
              titulo: "Transferencia Bancaria",
              descripcion: "WhatsApp Tesorería: 11 4870-0655",
            ),
            
            SizedBox(height: 20),
            
            // Datos bancarios
            _buildDatosBancarios(),
          ],
        ),
      ),
    );
  }

  Widget _buildModalidadCompra({
    required IconData icono,
    required String titulo,
    required String descripcion,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFF9800).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icono, color: Color(0xFFFF9800), size: 20),
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
                    color: Color(0xFFFF9800),
                  ),
                ),
                SizedBox(height: 4),
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
      ),
    );
  }

  Widget _buildDatosBancarios() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Datos para Transferencia Bancaria:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366),
            ),
          ),
          SizedBox(height: 16),
          
          _buildDatoBancario("Número de cuenta", "13059/8"),
          _buildDatoBancario("Tipo de cuenta", "Cuenta Corriente en Pesos"),
          _buildDatoBancario("Banco", "Provincia de Buenos Aires"),
          _buildDatoBancario("Sucursal", "5087 Quilmes Centro"),
          _buildDatoBancario("CBU", "01400274-01508701-305981"),
          _buildDatoBancario("CUIT", "30-63984756-6"),
          
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF1976D2), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Recuerde enviar el comprobante de transferencia y su CUIT al WhatsApp de Tesorería",
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
        ],
      ),
    );
  }

  Widget _buildDatoBancario(String label, String valor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              valor,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksCard() {
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
                    color: Color(0x1A7B1FA2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.link,
                    color: Color(0xFF7B1FA2),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Enlaces Útiles",
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
            
            _buildLinkItem(
              titulo: "Portal RPBA",
              url: "www.rpba.gov.ar",
              descripcion: "Sitio oficial del Registro de la Propiedad",
              onTap: () => _abrirUrl("https://www.rpba.gov.ar"),
            ),
            SizedBox(height: 12),
            _buildLinkItem(
              titulo: "Guía de Tasas",
              url: "Documento PDF de tasas",
              descripcion: "Consulte los valores actualizados",
              onTap: () => _abrirUrl("https://www.rpba.gov.ar/pdfs/Tasas"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkItem({
    required String titulo,
    required String url,
    required String descripcion,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF7B1FA2).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFF7B1FA2).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.open_in_new, color: Color(0xFF7B1FA2), size: 20),
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
                      color: Color(0xFF7B1FA2),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    url,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (descripcion.isNotEmpty) ...[
                    SizedBox(height: 2),
                    Text(
                      descripcion,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Color(0xFF7B1FA2), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBotonesAccion() {
    return Column(
      children: [
        // Botón para contactar Tesorería
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _contactarTesoreria,
            icon: Icon(Icons.chat, size: 20),
            label: Text(
              "Contactar Tesorería por WhatsApp",
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
        
        // Botón para abrir portal RPBA
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _abrirUrl("https://www.rpba.gov.ar"),
            icon: Icon(Icons.web, size: 20),
            label: Text(
              "Portal RPBA",
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
        
        // Botón para contactar administración
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _contactarAdministracion,
            icon: Icon(Icons.info, size: 20),
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
        
        // Botones para copiar datos
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () => _copiarTexto("01400274-01508701-305981"),
                icon: Icon(Icons.copy, size: 16),
                label: Text(
                  "Copiar CBU",
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
                onPressed: () => _copiarTexto("30-63984756-6"),
                icon: Icon(Icons.copy, size: 16),
                label: Text(
                  "Copiar CUIT",
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

  Future<void> _contactarTesoreria() async {
    final message = "Hola, necesito información sobre el usuario RPBA y compra de créditos para formularios online";
    final whatsappUrl = "https://wa.me/541148700655?text=${Uri.encodeComponent(message)}";
    
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
    final message = "Hola, necesito información sobre el Registro de la Propiedad de Buenos Aires";
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

  Future<void> _abrirUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir $url';
      }
    } catch (e) {
      print('Error al abrir URL: $e');
    }
  }

  void _copiarTexto(String texto) {
    Clipboard.setData(ClipboardData(text: texto));
  }
}

// Clases auxiliares
class _FormularioInfo {
  final String numero;
  final String descripcion;
  final IconData icono;

  _FormularioInfo(this.numero, this.descripcion, this.icono);
}