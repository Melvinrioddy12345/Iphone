import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CompareScreen extends StatefulWidget {
  final ProductModel iphone1;
  final ProductModel iphone2;

  const CompareScreen({
    super.key,
    required this.iphone1,
    required this.iphone2,
  });

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  String? _almac1;
  String? _almac2;

  @override
  void initState() {
    super.initState();
    _almac1 = widget.iphone1.preciosPorAlmacenamiento.keys.first;
    _almac2 = widget.iphone2.preciosPorAlmacenamiento.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final p1 = widget.iphone1;
    final p2 = widget.iphone2;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1D1F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Comparar Productos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Encabezados ────────────────────────────────────────────────
            Row(
              children: [
                Expanded(child: _headerProducto(p1)),
                const SizedBox(width: 12),
                Expanded(child: _headerProducto(p2)),
              ],
            ),
            const SizedBox(height: 16),

            // ── Selector de variante producto 1 ───────────────────────────
            _selectorVariante(p1, _almac1, (val) =>
                setState(() => _almac1 = val)),
            const SizedBox(height: 8),

            // ── Selector de variante producto 2 ───────────────────────────
            _selectorVariante(p2, _almac2, (val) =>
                setState(() => _almac2 = val)),
            const SizedBox(height: 16),

            // ── Precios comparados ─────────────────────────────────────────
            _filaPrecio(p1, p2),
            const SizedBox(height: 8),

            // ── Especificaciones ───────────────────────────────────────────
            _filaComparacion('Año',
                p1.anio.toString(), p2.anio.toString()),
            _filaComparacion('Procesador',
                p1.procesador, p2.procesador),
            if (p1.pantalla != 'N/A' || p2.pantalla != 'N/A')
              _filaComparacion('Pantalla',
                  p1.pantalla, p2.pantalla),
            if (p1.memoria != 'N/A' || p2.memoria != 'N/A')
              _filaComparacion('Memoria',
                  p1.memoria, p2.memoria),
            if (p1.camara != 'N/A' || p2.camara != 'N/A')
              _filaComparacion('Cámara',
                  p1.camara, p2.camara),
            _filaComparacion('Batería',
                p1.bateria, p2.bateria),
            _filaComparacion('Conectividad',
                p1.conectividad, p2.conectividad),
          ],
        ),
      ),
    );
  }

  Widget _headerProducto(ProductModel p) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(_iconoCategoria(p.categoria),
              color: Colors.white, size: 40),
          const SizedBox(height: 8),
          Text(
            p.nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            p.categoria,
            style: const TextStyle(
              color: Color(0xFF86868B),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectorVariante(ProductModel p, String? seleccionado,
      Function(String) onSeleccionar) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p.nombre,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF86868B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: p.preciosPorAlmacenamiento.keys.map((opcion) {
              final activo = seleccionado == opcion;
              return GestureDetector(
                onTap: () => onSeleccionar(opcion),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: activo
                        ? const Color(0xFF1D1D1F)
                        : const Color(0xFFF5F5F7),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: activo
                          ? const Color(0xFF1D1D1F)
                          : const Color(0xFFE5E5EA),
                    ),
                  ),
                  child: Text(
                    opcion,
                    style: TextStyle(
                      color: activo
                          ? Colors.white
                          : const Color(0xFF1D1D1F),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _filaPrecio(ProductModel p1, ProductModel p2) {
    final usd1 = p1.precioUSDPorAlmacenamiento(_almac1!);
    final usd2 = p2.precioUSDPorAlmacenamiento(_almac2!);
    final bs1  = p1.precioBsPorAlmacenamiento(_almac1!);
    final bs2  = p2.precioBsPorAlmacenamiento(_almac2!);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            child: const Text(
              'Precio',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF86868B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${usd1.toStringAsFixed(0)} USD',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Bs ${bs1.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF81C784),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 1, height: 40,
                    color: const Color(0xFF86868B)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${usd2.toStringAsFixed(0)} USD',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bs ${bs2.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Color(0xFF81C784),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filaComparacion(String spec, String valor1, String valor2) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              spec,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF86868B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    valor1,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1D1D1F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                    width: 1, height: 40,
                    color: const Color(0xFFE5E5EA)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      valor2,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1D1D1F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
}