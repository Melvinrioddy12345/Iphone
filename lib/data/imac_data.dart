import '../models/product_model.dart';

final List<ProductModel> listaImacs = [
  ProductModel(
    nombre: 'iMac 24"',
    categoria: 'iMac',
    anio: 2024,
    pantalla: '24" Retina 4.5K',
    procesador: 'Apple M4',
    almacenamiento: '256GB / 512GB / 1TB / 2TB',
    memoria: '16GB / 24GB / 32GB RAM',
    camara: '12MP Center Stage',
    bateria: 'N/A (escritorio)',
    conectividad: 'Wi-Fi 6E, 4x Thunderbolt 4, 2x USB-A, Ethernet, Bluetooth 5.3',
    precioBase: 1299.0,
    preciosPorAlmacenamiento: {
      '256GB': 1299.0,
      '512GB': 1499.0,
      '1TB': 1699.0,
      '2TB': 2099.0,
    },
  ),
];