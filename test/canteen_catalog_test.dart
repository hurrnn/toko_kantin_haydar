import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/data/menu_data.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  test('menu has at least five choices', () {
    expect(canteenMenu.length, greaterThanOrEqualTo(5));
  });

  testWidgets('search filters menu without case sensitivity', (tester) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const CanteenCatalogApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'mIe');
    await tester.pumpAndSettle();

    expect(find.text('Mie Ayam'), findsOneWidget);
    expect(find.text('Nasi Goreng'), findsNothing);
    expect(find.text('1 pilihan'), findsOneWidget);
  });

  testWidgets('portion controls update the total and enforce minimum one', (
    tester,
  ) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const CanteenCatalogApp());
    await tester.pumpAndSettle();

    await _openMieAyam(tester);
    await tester.pumpAndSettle();
    _expectDetailTotal(tester, 'Rp 10.000');

    await tester.tap(find.byTooltip('Tambah porsi'));
    await tester.pumpAndSettle();
    _expectDetailTotal(tester, 'Rp 20.000');
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byTooltip('Kurangi porsi'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Kurangi porsi'));
    await tester.pumpAndSettle();
    _expectDetailTotal(tester, 'Rp 10.000');
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('chosen portions appear in the cart total', (tester) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const CanteenCatalogApp());
    await tester.pumpAndSettle();

    await _openMieAyam(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Tambah porsi'));
    await tester.pumpAndSettle();
    final addButton = find.textContaining('Tambah ke keranjang');
    await tester.scrollUntilVisible(
      addButton,
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(addButton);
    await tester.pump();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Keranjang belanja'));
    await tester.pumpAndSettle();

    expect(find.text('Mie Ayam'), findsOneWidget);
    expect(find.text('Rp 20.000'), findsNWidgets(2));
    expect(find.text('Siap dipesan'), findsOneWidget);
  });
}

Future<void> _openMieAyam(WidgetTester tester) async {
  final item = find.text('Mie Ayam');
  await tester.ensureVisible(item);
  await tester.pumpAndSettle();
  await tester.tap(item);
}

void _setTestViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void _expectDetailTotal(WidgetTester tester, String expected) {
  expect(
    tester.widget<Text>(find.byKey(const ValueKey('order-total'))).data,
    expected,
  );
}
