import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/error_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactoScreen extends StatefulWidget {
  const ContactoScreen({Key? key}) : super(key: key);

  @override
  _ContactoScreenState createState() => _ContactoScreenState();
}

class _ContactoScreenState extends State<ContactoScreen> 
    with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true; // Mantener estado al cambiar tabs
  
  final ApiService _apiService = ApiService();
  List<ContactoItem> _contactos = [];
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadContactos();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _loadContactos() {
    if (_isDisposed) return;
    setState(() {
      _contactos = _getContactosEstaticos();
    });
  }

  List<ContactoItem> _getContactosEstaticos() {
    return [
      // WhatsApps principales (más importantes)
      ContactoItem(
        type: "whatsapp",
        title: "Administración",
        number: "+5491158044895",
      ),
      ContactoItem(
        type: "whatsapp",
        title: "Tesorería",
        number: "+541148700655",
      ),
      ContactoItem(
        type: "whatsapp",
        title: "Noticias y Cursos",
        number: "+541140248141",
      ),
      ContactoItem(
        type: "whatsapp",
        title: "Biblioteca",
        number: "+541158002500",
      ),
      ContactoItem(
        type: "whatsapp",
        title: "Mediación",
        number: "+541165052181",
      ),
      ContactoItem(
        type: "whatsapp",
        title: "Matrícula",
        number: "+541131701440",
      ),
      
      // Líneas telefónicas (menos importantes)
      ContactoItem(
        type: "telefono",
        title: "Sede Central - Línea 1",
        number: "+541142578105",
      ),
      ContactoItem(
        type: "telefono",
        title: "Sede Central - Línea 2", 
        number: "+541142578171",
      ),
      ContactoItem(
        type: "telefono",
        title: "Sala Profesionales - Florencio Varela",
        number: "+541160814483",
      ),
      ContactoItem(
        type: "telefono",
        title: "Sala Profesionales - Berazategui",
        number: "+541148806560",
      ),
    ];
  }

  // Función optimizada para lanzar contactos
  Future<void> _launchContact(String type, String number) async {
    if (_isDisposed) return;
    
    String url;
    
    if (type.toLowerCase() == "whatsapp") {
      String formattedNumber = number.replaceAll(RegExp(r'\s+'), '').replaceAll('+', '');
      url = 'whatsapp://send?phone=$formattedNumber';
    } else if (type.toLowerCase() == "email") {
      url = 'mailto:$number';
    } else {
      url = 'tel:$number';
    }
    
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        _showError('No se pudo abrir $type con $number');
      }
    } catch (e) {
      _showError('Error al abrir $type: $e');
    }
  }

  void _showError(String message) {
    if (_isDisposed || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Función optimizada para abrir Google Maps
  Future<void> _openGoogleMaps() async {
    if (_isDisposed) return;
    
    const String address = "Alvear 414, Quilmes, Buenos Aires, Argentina";
    
    final List<String> mapUrls = [
      "https://maps.google.com/maps?q=Alvear+414+Quilmes",
      "https://www.google.com/maps/@-34.7237,-58.2642,17z",
      "https://maps.google.com/?q=Alvear+414+Quilmes",
    ];
    
    for (final String url in mapUrls) {
      try {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        }
      } catch (e) {
        continue;
      }
    }
    
    _showError('No se pudo abrir Google Maps');
  }

  // Widget optimizado para cada contacto con mejor performance
  Widget _buildContactoCard(ContactoItem contacto, bool esPrioritario) {
    IconData icon;
    Color iconColor;
    String descripcion = "";
    
    switch(contacto.type.toLowerCase()) {
      case "whatsapp":
        icon = FontAwesomeIcons.whatsapp;
        iconColor = const Color(0xFF25D366);
        switch(contacto.title.toLowerCase()) {
          case "tesorería":
            descripcion = "Consultas y pago matrícula, alta registro de propiedad";
            break;
          case "noticias y cursos":
            descripcion = "Ofertas diarias de cursos, servicios y beneficios";
            break;
          case "biblioteca":
            descripcion = "Consultas bibliográficas, leyes, doctrina, jurisprudencia";
            break;
          case "mediación":
            descripcion = "Centro de mediación, carta documento OCA digital";
            break;
          case "matrícula":
            descripcion = "Consultas sobre requisitos para la matriculación";
            break;
        }
        break;
      case "telefono":
        icon = Icons.phone;
        iconColor = Colors.blueGrey;
        break;
      default:
        icon = Icons.contact_phone;
        iconColor = Colors.grey;
        break;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: esPrioritario ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: esPrioritario 
            ? BorderSide(color: iconColor.withOpacity(0.3), width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => _launchContact(contacto.type, contacto.number),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16, 
            vertical: esPrioritario ? 12 : 8,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(esPrioritario ? 12 : 10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: esPrioritario ? 24 : 20,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contacto.title,
                      style: TextStyle(
                        fontWeight: esPrioritario ? FontWeight.bold : FontWeight.w600,
                        fontSize: esPrioritario ? 16 : 15,
                        color: esPrioritario ? Color(0xFF003366) : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      contacto.number.replaceAll("+54", "").replaceAll("+", ""),
                      style: TextStyle(
                        fontSize: 14,
                        color: iconColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (descripcion.isNotEmpty) ...[
                      SizedBox(height: 6),
                      Text(
                        descripcion,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget optimizado para redes sociales
  Widget _buildRedesSocialesGrid() {
    final redes = [
      _RedSocial("Web", "www.caq.org.ar", Icons.language, Color(0xFF009639), "https://www.caq.org.ar"),
      _RedSocial("Instagram", "@caqsitiooficial", FontAwesomeIcons.instagram, Color(0xFFE4405F), "https://instagram.com/caqsitiooficial"),
      _RedSocial("Facebook", "@caqsitiooficial", FontAwesomeIcons.facebook, Color(0xFF1877F2), "https://facebook.com/caqsitiooficial"),
      _RedSocial("Twitter", "@caqsitiooficial", FontAwesomeIcons.twitter, Color(0xFF1DA1F2), "https://twitter.com/caqsitiooficial"),
      _RedSocial("YouTube", "CAQ Quilmes", FontAwesomeIcons.youtube, Color(0xFFFF0000), "https://youtube.com/@colegiodeabogadosdequilmes"),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: redes.length,
      itemBuilder: (context, index) => _buildRedSocialCard(redes[index]),
    );
  }

  Widget _buildRedSocialCard(_RedSocial red) {
    return InkWell(
      onTap: () => _launchUrl(red.url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: red.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: red.color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              red.icon,
              color: red.color,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              red.nombre,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: red.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (_isDisposed) return;
    
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showError('No se pudo abrir $url');
      }
    } catch (e) {
      _showError('Error al abrir enlace: $e');
    }
  }

  // Widget simplificado de ubicación SIN WebView
  Widget _buildUbicacionSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF009639),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Sede Central',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.place, color: Color(0xFF009639), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Alvear 414, Quilmes\nBuenos Aires, Argentina',
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 20),
                
                // Botón simplificado para abrir maps
                InkWell(
                  onTap: _openGoogleMaps,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFE8F5E8), Color(0xFFD4EDDA)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF009639),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.map,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Toca para abrir en Maps',
                            style: TextStyle(
                              color: Color(0xFF009639),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(width: 8),
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

  @override
  Widget build(BuildContext context) {
    super.build(context); // Importante para AutomaticKeepAliveClientMixin
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacto",
          style: TextStyle(
            color: Color(0xFF009639),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUbicacionSection(),
            const SizedBox(height: 24),
            
            const Text(
              "Canales de Comunicación",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildContactosSection(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildContactosSection() {
    final whatsapps = _contactos.where((c) => c.type.toLowerCase() == "whatsapp").toList();
    final telefonos = _contactos.where((c) => c.type.toLowerCase() == "telefono").toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (whatsapps.isNotEmpty) ...[
          _buildSectionHeader(
            'WhatsApp (Prioritarios)',
            FontAwesomeIcons.whatsapp,
            Color(0xFF25D366),
          ),
          SizedBox(height: 12),
          
          ...whatsapps.map((contacto) => _buildContactoCard(contacto, true)),
          
          SizedBox(height: 20),
        ],
        
        if (telefonos.isNotEmpty) ...[
          _buildSectionHeader(
            'Líneas Telefónicas',
            Icons.phone,
            Colors.blueGrey,
          ),
          SizedBox(height: 12),
          
          ...telefonos.map((contacto) => _buildContactoCard(contacto, false)),
          
          SizedBox(height: 20),
        ],
        
        _buildSectionHeader(
          'Sitio Web y Redes Sociales',
          Icons.public,
          Color(0xFF009639),
        ),
        SizedBox(height: 12),
        
        _buildRedesSocialesGrid(),
      ],
    );
  }
}

class _RedSocial {
  final String nombre;
  final String handle;
  final IconData icon;
  final Color color;
  final String url;

  _RedSocial(this.nombre, this.handle, this.icon, this.color, this.url);
}