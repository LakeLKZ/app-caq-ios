import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class MatriculaPagoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pago de Matrícula",
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
            
            // Información de vencimientos
            _buildVencimientosCard(),
            
            SizedBox(height: 20),
            
            // Opciones de pago en cuotas
            _buildCuotasCard(),
            
            SizedBox(height: 20),
            
            // Formas de pago
            _buildFormasPagoCard(),
            
            SizedBox(height: 20),
            
            // Datos bancarios
            _buildDatosBancariosCard(context),
            
            SizedBox(height: 20),
            
            // Botón de contacto con Tesorería
            _buildContactoTesoreriaButton(),
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
              Color(0xFF009639),
              Color(0xFF007A2E),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.card_membership,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                "Cómo puedo abonar mi\nMatrícula Profesional",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Toda la información sobre pagos y vencimientos",
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

  Widget _buildVencimientosCard() {
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
                    color: Color(0x1AF44336),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Color(0xFFD32F2F),
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Vencimiento Anual",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Color(0xFFFF9800),
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "El vencimiento de la matrícula anual es el 31 de marzo de cada año",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE65100),
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

  Widget _buildCuotasCard() {
    final cuotas = [
      _CuotaInfo("1 cuota", "31 de marzo", Color(0xFF4CAF50)),
      _CuotaInfo("2 cuotas", "30 de junio", Color(0xFF2196F3)),
      _CuotaInfo("3 cuotas", "30 de septiembre", Color(0xFF9C27B0)),
      _CuotaInfo("4 cuotas", "30 de noviembre", Color(0xFFFF5722)),
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
                    color: Color(0x1A2196F3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.payment,
                    color: Color(0xFF2196F3),
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Opciones de Pago en Cuotas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            ...cuotas.map((cuota) => _buildCuotaItem(cuota)).toList(),
            
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Color(0xFF009639),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "El valor anual es el 100% del valor de 8 JUS arancelarios al momento del pago",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF009639),
                        fontWeight: FontWeight.w500,
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

  Widget _buildCuotaItem(_CuotaInfo cuota) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cuota.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cuota.color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: cuota.color,
              shape: BoxShape.circle,
            ),
            child: Text(
              cuota.numero.split(' ')[0],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cuota.numero,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: cuota.color,
                  ),
                ),
                Text(
                  "Vencimiento: ${cuota.vencimiento}",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormasPagoCard() {
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
                    Icons.store,
                    color: Color(0xFF009639),
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Formas de Pago",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Por mostrador
            _buildFormaPagoItem(
              titulo: "Por Mostrador",
              icono: Icons.store,
              color: Color(0xFF009639),
              detalles: [
                "📍 Alvear 414, 1er piso",
                "🕐 Horario: 8:00 a 16:00 hs",
                "💵 Efectivo, cheque",
                "💳 Todas las tarjetas de débito y crédito",
                "🏦 Convenio Banco Provincia: hasta 4 cuotas fijas (hasta 30/06)",
              ],
            ),
            
            SizedBox(height: 16),
            
            // Online
            _buildFormaPagoItem(
              titulo: "Online",
              icono: Icons.computer,
              color: Color(0xFF2196F3),
              detalles: [
                "📱 WhatsApp Tesorería: 11 4870-0655",
                "💳 Tarjetas de crédito/débito Visa",
                "🏦 Transferencia bancaria",
                "💰 Mercado Pago",
                "📄 PagoMisCuentas",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormaPagoItem({
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
            padding: EdgeInsets.only(bottom: 4),
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

  Widget _buildDatosBancariosCard(BuildContext context) {
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
                    Icons.account_balance,
                    color: Color(0xFFFF9800),
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Datos para Transferencia Bancaria",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            _buildDatoBancario(context, "Cuenta Corriente en Pesos", "5863-4 122-8", Icons.account_balance_wallet),
            _buildDatoBancario(context, "Banco", "GALICIA", Icons.account_balance),
            _buildDatoBancario(context, "CBU", "0070122420000005863482", Icons.confirmation_number),
            _buildDatoBancario(context, "CUIT CAQ", "30-63984756-6", Icons.business),
            
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF2196F3).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.send,
                    color: Color(0xFF2196F3),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Recuerde enviar el comprobante al WhatsApp de Tesorería",
                      style: TextStyle(
                        fontSize: 14,
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
      ),
    );
  }

  Widget _buildDatoBancario(BuildContext context, String label, String valor, IconData icono) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icono, color: Color(0xFF009639), size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
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
          IconButton(
            onPressed: () => _copiarDato(context, valor, label),
            icon: Icon(Icons.copy, color: Color(0xFF009639), size: 20),
            tooltip: "Copiar $label",
          ),
        ],
      ),
    );
  }

  Widget _buildContactoTesoreriaButton() {
    return SizedBox(
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
          backgroundColor: Color(0xFF25D366), // Color de WhatsApp
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  void _copiarDato(BuildContext context, String valor, String label) {
    Clipboard.setData(ClipboardData(text: valor));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('$label copiado'),
          ],
        ),
        backgroundColor: Color(0xFF009639),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _contactarTesoreria() async {
    final message = "Hola, necesito información sobre el pago de matrícula profesional";
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
}

class _CuotaInfo {
  final String numero;
  final String vencimiento;
  final Color color;

  _CuotaInfo(this.numero, this.vencimiento, this.color);
}