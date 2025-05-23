// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  int _currentCarouselIndex = 0;
  
  // Variables para el control del carrusel
  late PageController _pageController;
  bool _isDisposed = false;
  List<Novedad>? _novedadesCache;
  
  // Agregar ScrollController para bloquear scroll
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    // Carga los datos de novedades al inicio
    _apiService.getNovedades().then((novedades) {
      if (mounted) {
        setState(() {
          _novedadesCache = novedades;
        });
      }
    }).catchError((error) {
      print('Error cargando novedades: $error');
    });
  }

  Future<void> _loadNovedades() async {
    try {
      _novedadesCache = await _apiService.getNovedades();
      if (mounted) setState(() {});
    } catch (e) {
      print('Error cargando novedades: $e');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Reemplazar con logo real
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF009639),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "CA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Colegio de Abogados de Quilmes",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF009639),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Actualizar todos los datos cuando el usuario hace pull-to-refresh
          await _apiService.refreshAllData();
          await _loadNovedades();
          setState(() {});
        },
        child: ScrollConfiguration(
          // Desactivar efecto de rebote en Android
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: ClampingScrollPhysics(),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección de Novedades (Carrusel)
                  _buildNovedadesSection(),
                  SizedBox(height: 24),
                  
                  // Sección de Valores Importantes (Grid 2x2)
                  _buildValoresImportantesSection(),
                  SizedBox(height: 24),
                  
                  // Sección de Últimos Cursos (Mini-carrusel)
                  _buildUltimosCursosSection(),
                  SizedBox(height: 24),
                  
                  // Sección de Matrículas (Cards horizontales)
                  _buildMatriculasSection(),
                  
                  // Espacio extra al final para evitar que el último elemento quede detrás del bottomNavigationBar
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  // Widget para la sección de Novedades con carrusel (sin franja amarilla y negra)
  Widget _buildNovedadesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Últimas Novedades",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        
        // Tamaño fijo para evitar cambios de layout
        SizedBox(
          height: 220, // Aumentado para dar más espacio a la imagen
          child: _novedadesCache == null || _novedadesCache!.isEmpty
            ? Center(child: CircularProgressIndicator())
            : AbsorbPointer(
                // Absorber solo los eventos de scroll vertical
                absorbing: false,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _novedadesCache!.length,
                  // Evitar que el PageView capture los gestos de scroll vertical
                  physics: ClampingScrollPhysics(),
                  onPageChanged: (index) {
                    // Actualizar el índice
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildNovedadCard(_novedadesCache![index]);
                  },
                ),
              ),
        ),
        
        // Indicadores
        if (_novedadesCache != null && _novedadesCache!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _novedadesCache!.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarouselIndex == entry.key
                        ? Color(0xFF009639)
                        : Color(0xFFCCCCCC),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
  
  // Widget para cada tarjeta de novedad - rediseñado con texto sobre la imagen
  Widget _buildNovedadCard(Novedad novedad) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Imagen de fondo que ocupa todo el espacio
            Positioned.fill(
              child: novedad.imageUrl.isNotEmpty
                ? Image.network(
                    novedad.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error cargando imagen: $error');
                      // Fallback en caso de error al cargar la imagen
                      return Container(
                        color: Color(0xFFEEEEEE),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[400],
                          ),
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
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
            ),
            
            // Gradiente oscuro en la parte inferior para que el texto sea legible
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            
            // Texto en la parte inferior
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    novedad.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    novedad.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para la sección de Valores Importantes con grid 2x2
  Widget _buildValoresImportantesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Valores Importantes",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        FutureBuilder<List<ValorImportante>>(
          future: _apiService.getValoresImportantes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            
            if (snapshot.hasError) {
              return SizedBox(
                height: 120,
                child: ApiErrorWidget(
                  errorMessage: snapshot.error.toString(),
                  onRetry: () {
                    setState(() {});
                  },
                ),
              );
            }
            
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No hay valores disponibles"));
            }
            
            final valores = snapshot.data!;
            
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: valores.length,
              itemBuilder: (context, index) {
                final valor = valores[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          valor.label,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "\$${valor.value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF009639),
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
      ],
    );
  }

  // Widget para la sección de Matrículas
  Widget _buildMatriculasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Matrícula",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        FutureBuilder<Matricula>(
          future: _apiService.getMatricula(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            
            if (snapshot.hasError) {
              return SizedBox(
                height: 120,
                child: ApiErrorWidget(
                  errorMessage: snapshot.error.toString(),
                  onRetry: () {
                    setState(() {});
                  },
                ),
              );
            }
            
            if (!snapshot.hasData) {
              return Center(child: Text("Información no disponible"));
            }
            
            final matricula = snapshot.data!;
            
            return Row(
              children: [
                // Card de información de matrícula
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Valor actual:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "\$${matricula.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF009639),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Vencimiento:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            _formatDate(matricula.date),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Card de botón para inscripción
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/inscripcion'),
                    child: Card(
                      elevation: 2,
                      color: Color(0xFF009639),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.assignment_turned_in,
                              color: Colors.white,
                              size: 48,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Matriculate ahora",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // Widget para la sección de Últimos Cursos con mini-carrusel
  Widget _buildUltimosCursosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Últimos Cursos",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        FutureBuilder<List<Curso>>(
          future: _apiService.getCursos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 160,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            
            if (snapshot.hasError) {
              return SizedBox(
                height: 160,
                child: ApiErrorWidget(
                  errorMessage: snapshot.error.toString(),
                  onRetry: () {
                    setState(() {});
                  },
                ),
              );
            }
            
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No hay cursos disponibles"));
            }
            
            final cursos = snapshot.data!;
            
            // Contenedor con altura fija para evitar cambios de layout
            return SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width,
              // Absorber solo eventos verticales
              child: AbsorbPointer(
                absorbing: false,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // Evitar el rebote al final del scroll
                  physics: ClampingScrollPhysics(),
                  children: [
                    // Items de cursos (limitados a 3)
                    ...cursos.take(3).map((curso) => _buildCursoItem(curso)),
                    
                    // Card "Ver todos los cursos"
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/cursos'),
                      child: Container(
                        width: 140,
                        height: 160, // Misma altura que los cursos
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFF009639), width: 2),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF009639),
                              size: 24,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Ver todos\nlos cursos",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF009639),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
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
        ),
      ],
    );
  }  
  
  // Widget para cada elemento de curso - mejorado con texto superpuesto
  Widget _buildCursoItem(Curso curso) {
    return Container(
      width: 250,
      height: 160,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Imagen de fondo
            Positioned.fill(
              child: curso.imageUrl.isNotEmpty
                ? Image.network(
                    curso.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error cargando imagen del curso: $error');
                      return Container(
                        color: Color(0xFFEEEEEE),
                        child: Center(
                          child: Icon(
                            Icons.school,
                            size: 40, 
                            color: Colors.grey[400],
                          ),
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
                      child: Icon(
                        Icons.school,
                        size: 40, 
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
            ),
            
            // Gradiente oscuro en la parte inferior
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            
            // Texto en la parte inferior
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curso.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    curso.formattedDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5),
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
  
  // Método utilitario para formatear fechas
  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateStr;
    }
  }
}