import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../utils/currency.dart';
import '../widgets/menu_image.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    required this.item,
    required this.onAddToCart,
    super.key,
  });

  final FoodItem item;
  final void Function(FoodItem item, int quantity) onAddToCart;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final total = item.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail menu'),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 28),
          children: [
            AspectRatio(
              aspectRatio: 1.12,
              child: MenuImage(imagePath: item.imagePath, borderRadius: 25),
            ),
            const SizedBox(height: 21),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF202C25),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF3EC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.category,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF34785A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF68736B),
                height: 1.55,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Harga per porsi',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: const Color(0xFF758078)),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              formatRupiah(item.price),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: const Color(0xFF34785A),
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      _QuantityControl(
                        quantity: _quantity,
                        onDecrease: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                        onIncrease: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                  const Divider(height: 27),
                  Row(
                    children: [
                      Text(
                        'Total pesanan',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Text(
                        formatRupiah(total),
                        key: const ValueKey('order-total'),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF202C25),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: () {
                  widget.onAddToCart(item, _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.name} ditambahkan ke keranjang'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart_rounded),
                label: Text('Tambah ke keranjang • ${formatRupiah(total)}'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF34785A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback? onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6F1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Kurangi porsi',
            onPressed: onDecrease,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.remove_rounded),
          ),
          Text(
            '$quantity',
            key: const ValueKey('portion-count'),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            tooltip: 'Tambah porsi',
            onPressed: onIncrease,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
