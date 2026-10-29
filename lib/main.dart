 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/menu_data.dart';
import 'models/food_item.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const CanteenCatalogApp());
}

class CanteenCatalogApp extends StatefulWidget {
  const CanteenCatalogApp({super.key});

  @override
  State<CanteenCatalogApp> createState() => _CanteenCatalogAppState();
}

class _CanteenCatalogAppState extends State<CanteenCatalogApp> {
  final Map<String, int> _cartQuantities = {};

  void _addToCart(FoodItem item, int quantity) {
    setState(() {
      _cartQuantities.update(
        item.id,
        (currentQuantity) => currentQuantity + quantity,
        ifAbsent: () => quantity,
      );
    });
  }

  void _updateCartQuantity(FoodItem item, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _cartQuantities.remove(item.id);
      } else {
        _cartQuantities[item.id] = quantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF34785A),
      surface: const Color(0xFFF7F8F3),
    );

    return MaterialApp(
      title: 'Kantin Kita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF7F8F3),
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F8F3),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: HomePage(
        menuItems: canteenMenu,
        cartQuantities: _cartQuantities,
        onAddToCart: _addToCart,
        onCartQuantityChanged: _updateCartQuantity,
      ),
    );
  }
}
