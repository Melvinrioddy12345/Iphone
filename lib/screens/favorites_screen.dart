import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../data/iphones_data.dart';
import '../data/ipad_data.dart';
import '../data/macbook_data.dart';
import '../data/imac_data.dart';
import '../data/apple_watch_data.dart';
import '../data/airpods_data.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> favoritos;
  final Function(String) onToggleFavorito;

  const FavoritesScreen({
    super.key,
    required this.favoritos,
    required this.onToggleFavorito,
  });

  List<ProductModel> get _todosLosProductos => [
    ...listaIphones,
    ...listaIpads,
    ...listaMacbooks,
    ...listaImacs,
    ...listaAppleWatches,
    ...listaAirpods,
  ];

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
    final List<ProductModel> productosFavoritos = _todosLosProductos
        .where((p) => favoritos.contains(p.nombre))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1D1F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Mis Favoritos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: productosFavoritos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: 80, color: Color(0xFF86868B)),
                  SizedBox(height: 16),
                  Text(
                    'No tienes favoritos aún',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF86868B),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Toca el ícono ♡ en cualquier producto',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF86868B),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: productosFavoritos.length,
              itemBuilder: (context, index) {
                final producto = productosFavoritos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1D1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _iconoCategoria(producto.categoria),
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    title: Text(
                      producto.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${producto.categoria} · ${producto.anio}',
                          style: const TextStyle(
                            color: Color(0xFF86868B),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D1D1F),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '\$${producto.precioUSD.toStringAsFixed(0)} USD',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Bs ${producto.precioBs.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        onToggleFavorito(producto.nombre);
                        Navigator.pop(context);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(producto: producto),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}