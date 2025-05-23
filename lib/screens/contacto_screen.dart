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

class _ContactoScreenState extends State<ContactoScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<ContactoItem>> _contactosFuture;

  @override
  void initState() {
    super.initState();
    _loadContactos();
  }

  void _loadContactos() {
    _contactosFuture = _apiService.getContactos();
  }

  // Función para lanzar una llamada o WhatsApp
  Future<void> _launchContact(String type, String number) async {
    String url;
    
    if (type.toLowerCase() == "whatsapp") {
      // Formatear número para WhatsApp (eliminar espacios y +)
      String formattedNumber = number.replaceAll(RegExp(r'\s+'), '').replaceAll('+', '');
      url = 'whatsapp://send?phone=$formattedNumber';
    } else if (type.toLowerCase() == "email") {
      url = 'mailto:$number';
    } else {
      // Por defecto, llamada telefónica
      url = 'tel:$number';
    }
    
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo abrir $type con $number'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "¿Cómo podemos ayudarte?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Comunícate con nosotros a través de cualquiera de estos canales:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            
            // Lista de contactos
            Expanded(
              child: FutureBuilder<List<ContactoItem>>(
                future: _contactosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (snapshot.hasError) {
                    return ApiErrorWidget(
                      errorMessage: snapshot.error.toString(),
                      onRetry: () {
                        setState(() {
                          _loadContactos();
                        });
                      },
                    );
                  }
                  
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No hay contactos disponibles"));
                  }
                  
                  final contactos = snapshot.data!;
                  
                  return ListView.builder(
                    itemCount: contactos.length,
                    itemBuilder: (context, index) {
                      final contacto = contactos[index];
                      
                      // Determinar icono según tipo de contacto
                      IconData icon;
                      Color iconColor;
                      
                      switch(contacto.type.toLowerCase()) {
                        case "whatsapp":
                          icon = FontAwesomeIcons.whatsapp;
                          iconColor = const Color(0xFF25D366);
                          break;
                        case "email":
                          icon = Icons.email;
                          iconColor = Colors.blue;
                          break;
                        case "teléfono":
                        case "telefono":
                        case "phone":
                          icon = Icons.phone;
                          iconColor = Colors.blueGrey;
                          break;
                        default:
                          icon = Icons.contact_phone;
                          iconColor = Colors.grey;
                          break;
                      }
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, 
                            vertical: 8
                          ),
                          leading: CircleAvatar(
                            backgroundColor: iconColor.withOpacity(0.2),
                            child: Icon(
                              icon,
                              color: iconColor,
                            ),
                          ),
                          title: Text(
                            contacto.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(contacto.number),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFF009639),
                            ),
                            onPressed: () {
                              _launchContact(contacto.type, contacto.number);
                            },
                          ),
                          onTap: () {
                            _launchContact(contacto.type, contacto.number);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  BottomNavBar(currentIndex: 3),
    );
  }
}