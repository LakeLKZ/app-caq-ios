import 'package:flutter/material.dart';

class SedesHorariosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sedes y Horarios",
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
            // Sede Principal
            _buildSedeCard(
              titulo: "Sede Central",
              direccion: "Alvear 414, Quilmes",
              icono: Icons.account_balance,
              color: Color(0xFF009639),
              servicios: [
                _ServiceInfo("Administración General", "8:00 a 16:00 hs", "Tesorería, Biblioteca, Delegación Boletín Oficial"),
                _ServiceInfo("Caja de Previsión Social", "8:00 a 14:30 hs", "Para abogados de la Provincia de Buenos Aires"),
                _ServiceInfo("Servicio ProvinciaNet", "8:00 a 14:00 hs", ""),
                _ServiceInfo("Centro de Documentación ReNaPer", "8:00 a 12:30 hs", ""),
                _ServiceInfo("Delegación Personas Jurídicas", "8:00 a 10:30 hs", "Lunes y Miércoles"),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Anexo Sede
            _buildSedeCard(
              titulo: "Anexo Sede",
              direccion: "Colón 333, Quilmes",
              icono: Icons.business,
              color: Color(0xFF2E7D32),
              servicios: [
                _ServiceInfo("Centro de Mediación", "8:00 a 16:00 hs", ""),
                _ServiceInfo("Delegación Caja de Previsión Social", "8:00 a 14:30 hs", "Para abogados de la Provincia de Buenos Aires"),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Fuero Laboral
            _buildSedeCard(
              titulo: "Fuero Laboral",
              direccion: "Alem 430, Quilmes",
              icono: Icons.work,
              color: Color(0xFF1976D2),
              servicios: [
                _ServiceInfo("Sala de Profesionales", "8:00 a 14:00 hs", "Servicio de casilleros, cobro matrícula"),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Fuero Penal
            _buildSedeCard(
              titulo: "Fuero Penal",
              direccion: "Hipólito Yrigoyen 475 5to, Quilmes",
              icono: Icons.gavel,
              color: Color(0xFF7B1FA2),
              servicios: [
                _ServiceInfo("Servicio General", "8:00 a 14:00 hs", "Servicio de fotocopias"),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Título para Consultorios Jurídicos
            Text(
              "Consultorios Jurídicos Gratuitos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            SizedBox(height: 16),
            
            // Consultorio Quilmes
            _buildConsultorioCard(
              titulo: "Quilmes",
              direccion: "Hipólito Yrigoyen 475 planta baja, Quilmes",
              horarios: "Martes y Jueves: 8:00 a 12:00 hs",
              servicios: [],
            ),
            
            SizedBox(height: 16),
            
            // Consultorio Florencio Varela
            _buildConsultorioCard(
              titulo: "Florencio Varela",
              direccion: "Rodo 3363, Florencio Varela",
              horarios: "Lunes, Martes y Jueves: 8:00 a 12:00 hs",
              servicios: ["Cobro de matrícula", "Jus previsional y bono ley 8480", "Librería", "Servicio de fotocopia"],
            ),
            
            SizedBox(height: 16),
            
            // Consultorio Berazategui
            _buildConsultorioCard(
              titulo: "Berazategui",
              direccion: "Lisandro de la Torre 1438 1er piso, Berazategui",
              horarios: "Miércoles y Viernes: 9:00 a 13:00 hs",
              servicios: ["Cobro de matrícula", "Jus previsional y bono ley 8480", "Librería", "Servicio de fotocopia"],
            ),
            
            SizedBox(height: 16),
            
            // Consultorio San Francisco Solano
            _buildConsultorioCard(
              titulo: "San Francisco Solano",
              direccion: "Calle 842 Nro 2519, San Francisco Solano",
              horarios: "Miércoles: 9:00 a 13:00 hs",
              servicios: [],
            ),
            
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSedeCard({
    required String titulo,
    required String direccion,
    required IconData icono,
    required Color color,
    required List<_ServiceInfo> servicios,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header de la sede
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icono,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              direccion,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
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
          
          // Lista de servicios
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: servicios.map((servicio) => _buildServiceItem(servicio)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultorioCard({
    required String titulo,
    required String direccion,
    required String horarios,
    required List<String> servicios,
  }) {
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
            // Header del consultorio
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x1A009639),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.balance,
                    color: Color(0xFF009639),
                    size: 20,
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003366),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        direccion,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Horarios
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE9ECEF)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Color(0xFF009639),
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    horarios,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF009639),
                    ),
                  ),
                ],
              ),
            ),
            
            // Servicios adicionales (si los hay)
            if (servicios.isNotEmpty) ...[
              SizedBox(height: 12),
              Text(
                "Servicios adicionales:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF003366),
                ),
              ),
              SizedBox(height: 8),
              ...servicios.map((servicio) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xFF009639),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        servicio,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(_ServiceInfo servicio) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFF009639),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  servicio.nombre,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  servicio.horario,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF009639),
                  ),
                ),
                if (servicio.descripcion.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Text(
                    servicio.descripcion,
                    style: TextStyle(
                      fontSize: 13,
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
}

class _ServiceInfo {
  final String nombre;
  final String horario;
  final String descripcion;

  _ServiceInfo(this.nombre, this.horario, this.descripcion);
}