# Apple Phones Sucre 

Aplicación móvil en Flutter para explorar un catálogo de iPhones organizado por generación.

## Estudiante
Melvin Rioddy Chipana Peña  
Universidad Privada Domingo Savio — Sede Sucre  
Materia: Aplicaciones Móviles 1 · Turno: Noche · 2026

## Tecnologías
- Flutter 3.x · Dart
- Android Studio
- shared_preferences

## Estructura
```
lib/
├── main.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   ├── favorites_screen.dart
│   └── compare_screen.dart
├── widgets/
│   └── iphone_card.dart
├── models/
│   └── iphone_model.dart
└── data/
    └── iphones_data.dart
```

## Funcionalidades
- Splash screen con animación fade-in
- Catálogo de 11 iPhones (serie 12 al 16) agrupados por generación
- Búsqueda en tiempo real y filtros por serie
- Favoritos persistentes entre sesiones
- Comparador de dos modelos lado a lado
- Vista de detalle con especificaciones técnicas completas

## Cómo ejecutar
```bash
flutter clean
flutter pub get
flutter run
```