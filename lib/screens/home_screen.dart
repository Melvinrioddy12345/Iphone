import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/iphones_data.dart';
import '../data/ipad_data.dart';
import '../data/macbook_data.dart';
import '../data/imac_data.dart';
import '../data/apple_watch_data.dart';
import '../data/airpods_data.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';
import 'compare_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _favoritos = [];
  String _busqueda = '';
  String _categoriaSeleccionada = 'Todos';
  ProductModel? _productoParaComparar;

  final List<String> _categorias = [
    'Todos', 'iPhone', 'iPad', 'MacBook', 'iMac', 'Apple Watch', 'AirPods'
  ];

  // Todos los productos juntos
  List<ProductModel> get _todosLosProductos => [
    ...listaIphones,
    ...listaIpads,
    ...listaMacbooks,
    ...listaImacs,
    ...listaAppleWatches,
    ...listaAirpods,
  ];

  @override
  void initState() {
    super.initState();
    _cargarFavoritos();
  }

  Future<void> _cargarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoritos = prefs.getStringList('favoritos') ?? [];
    });
  }

  Future<void> _toggleFavorito(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favoritos.contains(nombre)) {
        _favoritos.remove(nombre);
      } else {
        _favoritos.add(nombre);
      }
    });
    await prefs.setStringList('favoritos', _favoritos);
  }

  void _seleccionarParaComparar(ProductModel producto) {
    if (_productoParaComparar == null) {
      setState(() => _productoParaComparar = producto);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${producto.nombre} seleccionado. Elige el segundo.'),
          backgroundColor: const Color(0xFF1D1D1F),
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (_productoParaComparar!.nombre == producto.nombre) {
      setState(() => _productoParaComparar = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selección cancelada.'),
          backgroundColor: Color(0xFF86868B),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CompareScreen(
            iphone1: _productoParaComparar!,
            iphone2: producto,
          ),
        ),
      );
      setState(() => _productoParaComparar = null);
    }
  }

  List<ProductModel> get _productosFiltrados {
    return _todosLosProductos.where((producto) {
      final coincideBusqueda = producto.nombre
          .toLowerCase()
          .contains(_busqueda.toLowerCase());
      final coincideCategoria = _categoriaSeleccionada == 'Todos' ||
          producto.categoria == _categoriaSeleccionada;
      return coincideBusqueda && coincideCategoria;
    }).toList();
  }

  Map<String, List<ProductModel>> get _productosAgrupados {
    final Map<String, List<ProductModel>> grupos = {};
    for (var producto in _productosFiltrados) {
      grupos.putIfAbsent(producto.categoria, () => []).add(producto);
    }
    return grupos;
  }

  IconData _iconoCategoria(String categoria) {
    switch (categoria) {
      case 'iPhone':      return Icons.smartphone;
      case 'iPad':        return Icons.tablet;
      case 'MacBook':     return Icons.laptop;
      case 'iMac':        return Icons.desktop_mac;
      case 'Apple Watch': return Icons.watch;
      case 'AirPods':     return Icons.headphones;
      default:            return Icons.apple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1D1F),
        title: const Text(
          'Apple Store Sucre',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favoritos: _favoritos,
                    onToggleFavorito: _toggleFavorito,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Barra de búsqueda ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (valor) => setState(() => _busqueda = valor),
              decoration: InputDecoration(
                hintText: 'Buscar producto Apple...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF86868B)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(color: Color(0xFF86868B)),
              ),
            ),
          ),

          // ── Filtros por categoría ──────────────────────────────────────────
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                final seleccionada = _categoriaSeleccionada == categoria;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _categoriaSeleccionada = categoria),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: seleccionada
                          ? const Color(0xFF1D1D1F)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: seleccionada
                            ? const Color(0xFF1D1D1F)
                            : const Color(0xFFE5E5EA),
                      ),
                    ),
                    child: Text(
                      categoria,
                      style: TextStyle(
                        color: seleccionada
                            ? Colors.white
                            : const Color(0xFF1D1D1F),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Banner comparador activo ───────────────────────────────────────
          if (_productoParaComparar != null)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF0071E3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.compare_arrows,
                      color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Comparando con: ${_productoParaComparar!.nombre}',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 13),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _productoParaComparar = null),
                    child: const Icon(Icons.close,
                        color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),

          // ── Lista de productos agrupados ───────────────────────────────────
          Expanded(
            child: _productosAgrupados.isEmpty
                ? const Center(
                    child: Text(
                      'No se encontraron productos',
                      style: TextStyle(
                        color: Color(0xFF86868B),
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: _productosAgrupados.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Encabezado de categoría
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Icon(
                                  _iconoCategoria(entry.key),
                                  size: 22,
                                  color: const Color(0xFF1D1D1F),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1D1D1F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Cards de productos
                          ...entry.value.map((producto) {
                            return ProductCard(
                              producto: producto,
                              esFavorito:
                                  _favoritos.contains(producto.nombre),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailScreen(producto: producto),
                                ),
                              ),
                              onFavorito: () =>
                                  _toggleFavorito(producto.nombre),
                              onComparar: () =>
                                  _seleccionarParaComparar(producto),
                            );
                          }),
                        ],
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}