class ProductModel {
  final String nombre;
  final String categoria;
  final int anio;
  final String pantalla;
  final String procesador;
  final String almacenamiento;
  final String memoria;
  final String camara;
  final String bateria;
  final String conectividad;
  final double precioBase;
  final Map<String, double> preciosPorAlmacenamiento;

  static const double tipoCambio = 6.96;

  ProductModel({
    required this.nombre,
    required this.categoria,
    required this.anio,
    required this.pantalla,
    required this.procesador,
    required this.almacenamiento,
    required this.memoria,
    required this.camara,
    required this.bateria,
    required this.conectividad,
    required this.precioBase,
    required this.preciosPorAlmacenamiento,
  });

  double get precioUSD => precioBase;
  double get precioBs => precioBase * tipoCambio;

  double precioUSDPorAlmacenamiento(String almac) =>
      preciosPorAlmacenamiento[almac] ?? precioBase;

  double precioBsPorAlmacenamiento(String almac) =>
      precioUSDPorAlmacenamiento(almac) * tipoCambio;
}