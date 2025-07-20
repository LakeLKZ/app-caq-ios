// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/models.dart';

class TasasJusticiaScreen extends StatefulWidget {
  @override
  _TasasJusticiaScreenState createState() => _TasasJusticiaScreenState();
}

class _TasasJusticiaScreenState extends State<TasasJusticiaScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  List<TasaJusticia> _todasLasTasas = [];
  List<TasaJusticia> _tasasFiltradas = [];
  bool _isSearching = false;
  
  @override
  void initState() {
    super.initState();
    _todasLasTasas = TasasJusticiaData.obtenerTodasLasTasas();
    _tasasFiltradas = _todasLasTasas.take(5).toList(); // Mostrar solo las primeras 5 inicialmente
    
    _searchController.addListener(_filtrarTasas);
  }
  
  @override
  void dispose() {
    _searchController.removeListener(_filtrarTasas);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
  
  void _filtrarTasas() {
    final query = _searchController.text.toLowerCase().trim();
    
    setState(() {
      _isSearching = query.isNotEmpty;
      
      if (query.isEmpty) {
        // Si no hay búsqueda, mostrar solo las primeras 5
        _tasasFiltradas = _todasLasTasas.take(5).toList();
      } else {
        // Filtrar por texto de búsqueda
        _tasasFiltradas = _todasLasTasas.where((tasa) {
          return tasa.textoCompleto.contains(query);
        }).toList();
      }
    });
  }
  
  void _limpiarBusqueda() {
    _searchController.clear();
    _searchFocusNode.unfocus();
  }
  
  void _copiarValor(String valor) {
    Clipboard.setData(ClipboardData(text: valor));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Valor copiado: $valor'),
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
  
  IconData _getIconByTipo(TipoTasa tipo) {
    switch (tipo) {
      case TipoTasa.fijo:
        return Icons.attach_money;
      case TipoTasa.porcentual:
        return Icons.percent;
      case TipoTasa.porMil:
        return Icons.calculate;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasas de Justicia 2025",
          style: TextStyle(color: Color(0xFF009639)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF009639)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_isSearching)
            IconButton(
              icon: Icon(Icons.clear, color: Color(0xFF009639)),
              onPressed: _limpiarBusqueda,
              tooltip: "Limpiar búsqueda",
            ),
        ],
      ),
      body: Column(
        children: [
          // Header con información
          _buildHeaderCard(),
          
          // Buscador
          _buildSearchBar(),
          
          // Resultados de búsqueda
          _buildSearchInfo(),
          
          // Lista de tasas
          Expanded(
            child: _buildTasasList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gavel,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Tasas de Justicia 2025",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Consulte los valores vigentes para tasas judiciales en la Provincia de Buenos Aires",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${_todasLasTasas.length} tasas disponibles",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isSearching ? Color(0xFF009639) : Colors.grey[300]!,
          width: _isSearching ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: _isSearching ? Color(0xFF009639) : Colors.grey[600],
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
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
          if (_isSearching)
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey[600],
                size: 20,
              ),
              onPressed: _limpiarBusqueda,
              tooltip: "Limpiar",
            ),
        ],
      ),
    );
  }
  
  Widget _buildSearchInfo() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.grey[600],
            size: 16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              _isSearching 
                ? "Mostrando ${_tasasFiltradas.length} resultado(s) de ${_todasLasTasas.length}"
                : "Mostrando primeras 5 tasas. Use el buscador para ver todas.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTasasList() {
    if (_tasasFiltradas.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: _tasasFiltradas.length,
      itemBuilder: (context, index) {
        final tasa = _tasasFiltradas[index];
        return _buildTasaCard(tasa, index);
      },
    );
  }
  
  Widget _buildTasaCard(TasaJusticia tasa, int index) {
    final color = _getColorByTipo(tasa.tipo);
    final icon = _getIconByTipo(tasa.tipo);
    
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.2), width: 1),
      ),
      child: InkWell(
        onTap: () => _copiarValor(tasa.valor),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con artículo e ícono
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tasa.tituloFormateado,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.copy,
                      size: 14,
                      color: color,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 12),
              
              // Descripción
              Text(
                tasa.descripcion,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF003366),
                  height: 1.3,
                ),
              ),
              
              SizedBox(height: 12),
              
              // Valor
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tasa.valor,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            "No se encontraron resultados",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Intente con otros términos de búsqueda",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _limpiarBusqueda,
            icon: Icon(Icons.clear_all, size: 18),
            label: Text("Limpiar búsqueda"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF009639),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}