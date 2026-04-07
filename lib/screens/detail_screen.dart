import 'package:flutter/material.dart';
import '../models/product_model.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel producto;

  const DetailScreen({super.key, required this.producto});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? _almacenamientoSeleccionado;

  @override
  void initState() {
    super.initState();
    _almacenamientoSeleccionado =
        widget.producto.preciosPorAlmacenamiento.keys.first;
  }

  double get _precioUSDSeleccionado =>
      widget.producto.precioUSDPorAlmacenamiento(
          _almacenamientoSeleccionado!);

  double get _precioBsSeleccionado =>
      widget.producto.precioBsPorAlmacenamiento(
          _almacenamientoSeleccionado!);

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1D1F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          producto.nombre,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Ícono del producto ─────────────────────────────────────────
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1D1F),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  _iconoCategoria(producto.categoria),
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Nombre y año ───────────────────────────────────────────────
            Center(
              child: Text(
                producto.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1D1D1F),
                ),
              ),
            ),
            Center(
              child: Text(
                'Lanzamiento ${producto.anio} · ${producto.categoria}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF86868B),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Selector de almacenamiento ─────────────────────────────────
            const Text(
              'Selecciona la variante',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1D1D1F),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: producto.preciosPorAlmacenamiento.keys.map((opcion) {
                final seleccionado = _almacenamientoSeleccionado == opcion;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _almacenamientoSeleccionado = opcion),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: seleccionado
                          ? const Color(0xFF1D1D1F)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: seleccionado
                            ? const Color(0xFF1D1D1F)
                            : const Color(0xFFE5E5EA),
                      ),
                    ),
                    child: Text(
                      opcion,
                      style: TextStyle(
                        color: seleccionado
                            ? Colors.white
                            : const Color(0xFF1D1D1F),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // ── Precios según variante ─────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1D1F),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  const Text(
                    'Precio referencial',
                    style: TextStyle(
                      color: Color(0xFF86868B),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_precioUSDSeleccionado.toStringAsFixed(0)} USD',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Bs ${_precioBsSeleccionado.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Tipo de cambio: 1 USD = 6.96 Bs',
                    style: TextStyle(
                      color: Color(0xFF86868B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Especificaciones técnicas ──────────────────────────────────
            const Text(
              'Especificaciones técnicas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1D1D1F),
              ),
            ),
            const SizedBox(height: 12),

            if (producto.pantalla != 'N/A')
              _specRow(Icons.monitor, 'Pantalla', producto.pantalla),
            _specRow(Icons.memory, 'Procesador', producto.procesador),
            if (producto.almacenamiento != 'N/A')
              _specRow(Icons.storage, 'Almacenamiento', producto.almacenamiento),
            if (producto.memoria != 'N/A')
              _specRow(Icons.developer_board, 'Memoria', producto.memoria),
            if (producto.camara != 'N/A')
              _specRow(Icons.camera_alt, 'Cámara', producto.camara),
            _specRow(Icons.battery_charging_full, 'Batería', producto.bateria),
            _specRow(Icons.wifi, 'Conectividad', producto.conectividad),
          ],
        ),
      ),
    );
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

  Widget _specRow(IconData icon, String titulo, String valor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF1D1D1F)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF86868B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1D1D1F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}