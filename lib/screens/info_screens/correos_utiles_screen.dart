import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class CorreosUtilesScreen extends StatelessWidget {
  final List<_CorreoItem> _correos = [
    _CorreoItem(
      email: "caq@caq.org.ar",
      titulo: "Consultas Generales",
      descripcion: "Información general, consultas administrativas",
      icono: Icons.email,
      color: Color(0xFF009639),
    ),
    _CorreoItem(
      email: "matricula@caq.org.ar",
      titulo: "Matrícula",
      descripcion: "Consultas sobre matriculación y requisitos",
      icono: Icons.card_membership,
      color: Color(0xFF1976D2),
    ),
    _CorreoItem(
      email: "biblioteca@caq.org.ar",
      titulo: "Biblioteca",
      descripcion: "Consultas bibliográficas, leyes, doctrina, jurisprudencia",
      icono: Icons.library_books,
      color: Color(0xFF8E24AA),
    ),
    _CorreoItem(
      email: "dni@caq.org.ar",
      titulo: "Centro de Documentación ReNaPer",
      descripcion: "Servicios de documentación y trámites de identidad",
      icono: Icons.assignment_ind,
      color: Color(0xFF00796B),
    ),
    _CorreoItem(
      email: "firmadigital@caq.org.ar",
      titulo: "Firma Digital",
      descripcion: "Gestión y consultas sobre certificados digitales",
      icono: Icons.verified_user,
      color: Color(0xFFFF6F00),
    ),
    _CorreoItem(
      email: "mediacion@caq.org.ar",
      titulo: "Centro de Mediación",
      descripcion: "Servicios de mediación y resolución de conflictos",
      icono: Icons.balance,
      color: Color(0xFF7B1FA2),
    ),
    _CorreoItem(
      email: "boletinoficialcaq@caq.org.ar",
      titulo: "Boletín Oficial",
      descripcion: "Delegación Boletín Oficial, publicaciones",
      icono: Icons.description,
      color: Color(0xFFD32F2F),
    ),
    _CorreoItem(
      email: "casillerosquilmes@caq.org.ar",
      titulo: "Casilleros Quilmes",
      descripcion: "Servicios de casilleros en sede Quilmes",
      icono: Icons.inbox,
      color: Color(0xFF388E3C),
    ),
    _CorreoItem(
      email: "casillerosvarela@caq.org.ar",
      titulo: "Casilleros Florencio Varela",
      descripcion: "Servicios de casilleros en Florencio Varela",
      icono: Icons.inbox,
      color: Color(0xFF303F9F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Correos Útiles",
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
            // Header con información
            Card(
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
                            Icons.mail_outline,
                            color: Color(0xFF009639),
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Correos Útiles",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003366),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Aquí encontrarás los correos electrónicos para contactar directamente con cada área del Colegio de Abogados de Quilmes.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Lista de correos
            ...(_correos.map((correo) => _buildCorreoCard(context, correo)).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildCorreoCard(BuildContext context, _CorreoItem correo) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: correo.color.withOpacity(0.2), width: 1),
      ),
      child: InkWell(
        onTap: () => _mostrarOpcionesCorreo(context, correo),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Ícono
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: correo.color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  correo.icono,
                  color: correo.color,
                  size: 24,
                ),
              ),
              
              SizedBox(width: 16),
              
              // Contenido
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      correo.titulo,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      correo.email,
                      style: TextStyle(
                        fontSize: 14,
                        color: correo.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (correo.descripcion.isNotEmpty) ...[
                      SizedBox(height: 6),
                      Text(
                        correo.descripcion,
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
              
              // Flecha
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: correo.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: correo.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarOpcionesCorreo(BuildContext context, _CorreoItem correo) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle del modal
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: correo.color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      correo.icono,
                      color: correo.color,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          correo.titulo,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                        Text(
                          correo.email,
                          style: TextStyle(
                            fontSize: 14,
                            color: correo.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 24),
              
              // Opciones
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x1A009639),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.mail, color: Color(0xFF009639), size: 20),
                ),
                title: Text(
                  'Abrir aplicación de correo',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Enviar correo desde tu app predeterminada'),
                onTap: () {
                  Navigator.pop(context);
                  _abrirCorreo(correo.email);
                },
              ),
              
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x1A2196F3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.copy, color: Color(0xFF2196F3), size: 20),
                ),
                title: Text(
                  'Copiar dirección',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Copiar email al portapapeles'),
                onTap: () {
                  Navigator.pop(context);
                  _copiarCorreo(context, correo.email);
                },
              ),
              
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Future<void> _abrirCorreo(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Consulta - Colegio de Abogados de Quilmes',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Si no puede abrir la app de correo, mostrar error
        throw 'No se pudo abrir la aplicación de correo';
      }
    } catch (e) {
      print('Error al abrir correo: $e');
    }
  }

  void _copiarCorreo(BuildContext context, String email) {
    Clipboard.setData(ClipboardData(text: email));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Correo copiado: $email'),
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
}

class _CorreoItem {
  final String email;
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Color color;

  _CorreoItem({
    required this.email,
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.color,
  });
}