import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel producto;
  final bool esFavorito;
  final VoidCallback onTap;
  final VoidCallback onFavorito;
  final VoidCallback? onComparar;

  const ProductCard({
    super.key,
    required this.producto,
    required this.esFavorito,
    required this.onTap,
    required this.onFavorito,
    this.onComparar,
  });

  IconData get _icono {
    switch (producto.categoria) {
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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Ícono de categoría
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1D1F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_icono, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),

              // Info del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producto.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF1D1D1F),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${producto.anio} · ${producto.procesador}',
                      style: const TextStyle(
                        color: Color(0xFF86868B),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Precios USD y Bs
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
              ),

              // Acciones
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      esFavorito ? Icons.favorite : Icons.favorite_border,
                      color: esFavorito ? Colors.red : const Color(0xFF86868B),
                    ),
                    onPressed: onFavorito,
                  ),
                  if (onComparar != null)
                    IconButton(
                      icon: const Icon(Icons.compare_arrows,
                          color: Color(0xFF86868B)),
                      onPressed: onComparar,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}