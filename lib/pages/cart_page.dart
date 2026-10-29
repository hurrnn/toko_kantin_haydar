import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../utils/currency.dart';
import '../widgets/menu_image.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    required this.menuItems,
    required this.cartQuantities,
    required this.onQuantityChanged,
    super.key,
  });

  final List<FoodItem> menuItems;
  final Map<String, int> cartQuantities;
  final void Function(FoodItem item, int quantity) onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final cartItems = menuItems
        .where((item) => (cartQuantities[item.id] ?? 0) > 0)
        .toList();
    final total = cartItems.fold<int>(
      0,
      (sum, item) => sum + item.price * cartQuantities[item.id]!,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang belanja')),
      body: cartItems.isEmpty
          ? const _EmptyCart()
          : SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      itemCount: cartItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final quantity = cartQuantities[item.id]!;
                        return _CartItemTile(
                          item: item,
                          quantity: quantity,
                          onDecrease: () =>
                              onQuantityChanged(item, quantity - 1),
                          onIncrease: () =>
                              onQuantityChanged(item, quantity + 1),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Total sementara',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: const Color(0xFF758078),
                                      ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  formatRupiah(total),
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        color: const Color(0xFF34785A),
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF34785A),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            'Siap dipesan',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: const Color(0xFF34785A),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    required this.item,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final FoodItem item;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            height: 76,
            child: MenuImage(imagePath: item.imagePath, borderRadius: 13),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatRupiah(item.price * quantity),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF34785A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Kurangi satu porsi',
            onPressed: onDecrease,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.remove_circle_outline_rounded),
          ),
          Text(
            '$quantity',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            tooltip: 'Tambah satu porsi',
            onPressed: onIncrease,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: const BoxDecoration(
                color: Color(0xFFEAF3EC),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 43,
                color: Color(0xFF34785A),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Keranjangmu masih kosong',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Pilih menu favoritmu, lalu tambahkan ke keranjang.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF758078),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
