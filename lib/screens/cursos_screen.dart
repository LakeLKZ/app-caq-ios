import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/bottom_nav_bar.dart';

class CursosScreen extends StatefulWidget {
  @override
  _CursosScreenState createState() => _CursosScreenState();
}

class _CursosScreenState extends State<CursosScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cursos y Capacitaciones",
          style: TextStyle(color: Color(0xFF009639)),
        ),
      ),
      body: FutureBuilder<List<Curso>>(
        future: _apiService.getCursos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay cursos disponibles"));
          }
          
          final cursos = snapshot.data!;
          
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: cursos.length,
            itemBuilder: (context, index) {
              final curso = cursos[index];
              
              return GestureDetector(
                onTap: () => _showCursoDetailDialog(context, curso),
                child: Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Imagen del curso desde la API
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Container(
                          width: 120,
                          height: 120,
                          child: curso.imageUrl.isNotEmpty
                            ? Image.network(
                                curso.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error cargando imagen: $error');
                                  return Container(
                                    color: Color(0xFFEEEEEE),
                                    child: Center(
                                      child: Icon(Icons.school, size: 40, color: Colors.grey),
                                    ),
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: Color(0xFFEEEEEE),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / 
                                              loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: Color(0xFFEEEEEE),
                                child: Center(
                                  child: Icon(Icons.school, size: 40, color: Colors.grey),
                                ),
                              ),
                        ),
                      ),
                      
                      // Información del curso
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                curso.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                curso.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Color(0xFF009639),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    curso.formattedDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }

  // Mostrar diálogo con detalles del curso
  void _showCursoDetailDialog(BuildContext context, Curso curso) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: 500, maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Imagen del curso desde la API
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    child: curso.imageUrl.isNotEmpty
                      ? Image.network(
                          curso.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error cargando imagen de detalle: $error');
                            return Container(
                              color: Color(0xFFEEEEEE),
                              child: Center(
                                child: Icon(Icons.school, size: 60, color: Colors.grey),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Color(0xFFEEEEEE),
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / 
                                        loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Color(0xFFEEEEEE),
                          child: Center(
                            child: Icon(Icons.school, size: 60, color: Colors.grey),
                          ),
                        ),
                  ),
                ),
                
                // Contenido del diálogo
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        curso.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Color(0xFF009639),
                          ),
                          SizedBox(width: 6),
                          Text(
                            curso.formattedDate,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        curso.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 24),
                      // Botón de inscripción
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _anotarseAlCurso(curso),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Anotate",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      },
    );
  }

  // Abrir WhatsApp para inscribirse al curso
  void _anotarseAlCurso(Curso curso) async {
    final message = "Hola, me quiero anotar a ${curso.title} de la fecha ${curso.formattedDate}";
    final whatsappUrl = "https://wa.me/5491121639878?text=${Uri.encodeComponent(message)}";
    
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // Si no puede abrir WhatsApp, mostrar un snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No se pudo abrir WhatsApp"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}