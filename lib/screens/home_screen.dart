import 'dart:async';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/error_widget.dart';
import '../screens/info_screens/tasas_justicia_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  
  @override
  bool get wantKeepAlive => true;
  
  final ApiService _apiService = ApiService();
  int _currentCarouselIndex = 0;
  
  late PageController _pageController;
  Timer? _autoScrollTimer;
  bool _isDisposed = false;
  
  // Cache para datos - SOLO DE API
  List<Novedad>? _novedadesCache;
  List<ValorImportante>? _valoresCache;
  List<Curso>? _cursosCache;
  // Eliminamos Matricula completamente
  
  // Estados de carga individual
  bool _novedadesLoading = true;
  bool _valoresLoading = true;
  bool _cursosLoading = true;
  
  // Estados de error
  bool _novedadesError = false;
  bool _valoresError = false;
  bool _cursosError = false;
  
  final ScrollController _scrollController = ScrollController();

  // Variables para Tasas de Justicia
  final TextEditingController _tasasSearchController = TextEditingController();
  List<TasaJusticia> _todasLasTasas = [];
  List<TasaJusticia> _tasasFiltradas = [];
  bool _isTasasSearching = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadAllData();
    _initTasasJusticia();
  }

  void _initTasasJusticia() {
    _todasLasTasas = TasasJusticiaData.obtenerTodasLasTasas();
    _tasasFiltradas = _todasLasTasas; // Mostrar todas las tasas desde el inicio
    _tasasSearchController.addListener(_filtrarTasas);
  }

  void _filtrarTasas() {
    final query = _tasasSearchController.text.toLowerCase().trim();
    
    setState(() {
      _isTasasSearching = query.isNotEmpty;
      
      if (query.isEmpty) {
        // Si no hay búsqueda, mostrar todas las tasas (sin límite de 5)
        _tasasFiltradas = _todasLasTasas;
      } else {
        // Filtrar por texto de búsqueda
        _tasasFiltradas = _todasLasTasas.where((tasa) {
          return tasa.textoCompleto.contains(query);
        }).toList();
      }
    });
  }

  Color _getColorByTipo(TipoTasa tipo) {
    switch (tipo) {
      case TipoTasa.fijo:
        return Color(0xFF009639);
      case TipoTasa.porcentual:
        return Color(0xFF1976D2);
      case TipoTasa.porMil:
        return Color(0xFFFF9800);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    _tasasSearchController.removeListener(_filtrarTasas);
    _tasasSearchController.dispose();
    super.dispose();
  }

  Future<void> _loadAllData() async {
    if (_isDisposed) return;
    
    // Cargar datos individualmente para mejor manejo de errores
    _loadNovedades();
    _loadValores();
    _loadCursos();
  }

  Future<void> _loadNovedades() async {
    if (_isDisposed) return;
    
    setState(() {
      _novedadesLoading = true;
      _novedadesError = false;
    });
    
    try {
      final novedades = await _apiService.getNovedades();
      if (!_isDisposed && mounted) {
        setState(() {
          _novedadesCache = novedades;
          _novedadesLoading = false;
          _novedadesError = false;
        });
        _startAutoScroll();
      }
    } catch (e) {
      print('Error cargando novedades: $e');
      if (!_isDisposed && mounted) {
        setState(() {
          _novedadesCache = null;
          _novedadesLoading = false;
          _novedadesError = true;
        });
      }
    }
  }

  Future<void> _loadValores() async {
    if (_isDisposed) return;
    
    setState(() {
      _valoresLoading = true;
      _valoresError = false;
    });
    
    try {
      final valores = await _apiService.getValoresImportantes();
      if (!_isDisposed && mounted) {
        setState(() {
          _valoresCache = valores;
          _valoresLoading = false;
          _valoresError = false;
        });
      }
    } catch (e) {
      print('Error cargando valores: $e');
      if (!_isDisposed && mounted) {
        setState(() {
          _valoresCache = null;
          _valoresLoading = false;
          _valoresError = true;
        });
      }
    }
  }

  Future<void> _loadCursos() async {
    if (_isDisposed) return;
    
    setState(() {
      _cursosLoading = true;
      _cursosError = false;
    });
    
    try {
      final cursos = await _apiService.getCursos();
      if (!_isDisposed && mounted) {
        setState(() {
          _cursosCache = cursos;
          _cursosLoading = false;
          _cursosError = false;
        });
      }
    } catch (e) {
      print('Error cargando cursos: $e');
      if (!_isDisposed && mounted) {
        setState(() {
          _cursosCache = null;
          _cursosLoading = false;
          _cursosError = true;
        });
      }
    }
  }

  void _startAutoScroll() {
    if (_isDisposed || _novedadesCache == null || _novedadesCache!.length <= 1) return;
    
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_isDisposed || !mounted) {
        timer.cancel();
        return;
      }
      
      final nextIndex = (_currentCarouselIndex + 1) % _novedadesCache!.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          nextIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  String _formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Flexible(
              child: Text(
                "Colegio de Abogados de Quilmes",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF009639),
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadAllData,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNovedadesSection(),
                SizedBox(height: 24),
                _buildValoresImportantesSection(),
                SizedBox(height: 24),
                _buildUltimosCursosSection(),
                SizedBox(height: 24),
                _buildTasasJusticiaSection(), // Nueva sección
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  // Nueva sección para Tasas de Justicia
  Widget _buildTasasJusticiaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título sin ícono
        Text(
          "Tasas de Justicia 2025",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        
        // Buscador
        _buildTasasSearchBar(),
        SizedBox(height: 16),
        
        // Info sobre resultados
        _buildTasasSearchInfo(),
        SizedBox(height: 8),
        
        // Lista de tasas (scrolleable) - mostrar 5 páginas de 5 tasas
        _buildTasasList(),
      ],
    );
  }

  Widget _buildTasasSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isTasasSearching ? Color(0xFF009639) : Colors.grey[300]!,
          width: _isTasasSearching ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: _isTasasSearching ? Color(0xFF009639) : Colors.grey[600],
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _tasasSearchController,
              decoration: InputDecoration(
                hintText: "Buscar por artículo, descripción o valor...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          if (_isTasasSearching)
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey[600],
                size: 20,
              ),
              onPressed: () {
                _tasasSearchController.clear();
              },
              tooltip: "Limpiar",
            ),
        ],
      ),
    );
  }

  Widget _buildTasasSearchInfo() {
    return Row(
      children: [
        Icon(
          Icons.info_outline,
          color: Colors.grey[600],
          size: 16,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            _isTasasSearching 
              ? "Mostrando ${_tasasFiltradas.length} resultado(s) de ${_todasLasTasas.length}"
              : "Mostrando todas las tasas disponibles (${_todasLasTasas.length})",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTasasList() {
    if (_tasasFiltradas.isEmpty) {
      return Container(
        height: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                color: Colors.grey[400],
                size: 32,
              ),
              SizedBox(height: 8),
              Text(
                "No se encontraron tasas",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return Container(
      height: 300, // Altura fija para permitir scroll
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _tasasFiltradas.length,
        itemBuilder: (context, index) {
          final tasa = _tasasFiltradas[index];
          return _buildTasaItem(tasa);
        },
      ),
    );
  }

  Widget _buildTasaItem(TasaJusticia tasa) {
    Color color = _getColorByTipo(tasa.tipo);
    
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tasa.descripcion,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003366),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  tasa.articulo,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            tasa.valor,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNovedadesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Últimas Novedades",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        
        SizedBox(
          height: 200,
          child: _novedadesLoading
            ? _buildLoadingWidget()
            : _novedadesError
              ? _buildErrorWidget("Error al cargar novedades", _loadNovedades)
              : _novedadesCache == null || _novedadesCache!.isEmpty
                ? _buildEmptyWidget("No hay novedades disponibles")
                : PageView.builder(
                    controller: _pageController,
                    itemCount: _novedadesCache!.length,
                    onPageChanged: (index) {
                      if (!_isDisposed) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      }
                    },
                    itemBuilder: (context, index) {
                      return _buildNovedadCard(_novedadesCache![index]);
                    },
                  ),
        ),
        
        if (_novedadesCache != null && _novedadesCache!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _novedadesCache!.length,
                (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarouselIndex == index
                        ? Color(0xFF009639)
                        : Color(0xFFCCCCCC),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildNovedadCard(Novedad novedad) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Imagen de fondo si está disponible
            Positioned.fill(
              child: novedad.imageUrl.isNotEmpty
                ? Image.network(
                    novedad.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Si la imagen falla, usar gradiente como fallback
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF009639),
                              Color(0xFF007A2E),
                            ],
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF009639),
                              Color(0xFF007A2E),
                            ],
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF009639),
                          Color(0xFF007A2E),
                        ],
                      ),
                    ),
                  ),
            ),
            
            // Gradiente oscuro para legibilidad del texto
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
            
            // Contenido de texto
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
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    novedad.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    maxLines: 2,
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

  Widget _buildValoresImportantesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Valores Importantes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        
        _valoresLoading
          ? _buildLoadingWidget(height: 120)
          : _valoresError
            ? _buildErrorWidget("Error al cargar valores", _loadValores)
            : _valoresCache == null || _valoresCache!.isEmpty
              ? _buildEmptyWidget("No hay valores disponibles")
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: _valoresCache!.length,
                  itemBuilder: (context, index) {
                    final valor = _valoresCache![index];
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
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "\$${_formatNumber(valor.value)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF009639),
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


  Widget _buildUltimosCursosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Últimos Cursos",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        
        SizedBox(
          height: 140,
          child: _cursosLoading
            ? _buildLoadingWidget(height: 140)
            : _cursosError
              ? _buildErrorWidget("Error al cargar cursos", _loadCursos)
              : _cursosCache == null || _cursosCache!.isEmpty
                ? _buildEmptyWidget("No hay cursos disponibles")
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _cursosCache!.take(3).length + 1,
                    itemBuilder: (context, index) {
                      if (index < _cursosCache!.take(3).length) {
                        return _buildCursoItem(_cursosCache![index]);
                      } else {
                        return _buildVerTodosCursosCard();
                      }
                    },
                  ),
        ),
      ],
    );
  }

  Widget _buildCursoItem(Curso curso) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Imagen de fondo si está disponible
            Positioned.fill(
              child: curso.imageUrl.isNotEmpty
                ? Image.network(
                    curso.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue[700]!,
                              Colors.blue[900]!,
                            ],
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue[700]!,
                              Colors.blue[900]!,
                            ],
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue[700]!,
                          Colors.blue[900]!,
                        ],
                      ),
                    ),
                  ),
            ),
            
            // Gradiente para legibilidad
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
            
            // Contenido
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
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    curso.formattedDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
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

  Widget _buildVerTodosCursosCard() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/cursos'),
      child: Container(
        width: 120,
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
    );
  }

  Widget _buildLoadingWidget({double height = 50}) {
    return Container(
      height: height,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF009639)),
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(String message) {
    return Container(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.grey[400],
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message, VoidCallback onRetry) {
    return Container(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red[400],
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh, size: 16),
              label: Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF009639),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateStr;
    }
  }
}