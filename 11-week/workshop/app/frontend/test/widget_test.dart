import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models.dart';
import 'package:frontend/store.dart';

class PendingCheckoutStore extends ShopStore {
  final response = Completer<void>();
  int submissions = 0;

  @override
  Future<void> checkout(String customer, String note) {
    submissions++;
    return response.future;
  }
}

void main() {
  testWidgets('El envío bloquea duplicados y el error conserva los datos', (
    tester,
  ) async {
    final store = PendingCheckoutStore();
    store.add(demoProducts.first, 'Una bola', 'Sin topping');
    await tester.pumpWidget(MaterialApp(home: CheckoutPage(store: store)));
    final send = find.widgetWithText(FilledButton, 'Simular pedido');
    expect(tester.widget<FilledButton>(send).onPressed, isNull);
    await tester.enterText(find.byType(TextFormField).first, 'Ana');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.ensureVisible(send);
    await tester.pumpAndSettle();
    await tester.tap(send);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(store.submissions, 1);
    expect(
      tester.widget<TextFormField>(find.byType(TextFormField).first).enabled,
      isFalse,
    );
    expect(
      tester
          .widget<TextButton>(
            find.widgetWithText(TextButton, 'Cancelar pedido'),
          )
          .onPressed,
      isNull,
    );
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(find.byType(AlertDialog), findsNothing);
    store.response.completeError(const OrderFailure('Servidor no disponible.'));
    await tester.pumpAndSettle();
    expect(find.text('Servidor no disponible.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Ana'), findsOneWidget);
    expect(store.cart, hasLength(1));
    expect(store.orders, isEmpty);
    expect(tester.widget<FilledButton>(send).onPressed, isNotNull);
  });

  testWidgets('Atrás confirma la cancelación y conserva el carrito', (
    tester,
  ) async {
    final store = ShopStore();
    store.add(demoProducts.first, 'Una bola', 'Sin topping');
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => CheckoutPage(store: store),
                ),
              ),
              child: const Text('Abrir formulario'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Abrir formulario'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Ana');
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('¿Cancelar el pedido?'), findsOneWidget);
    await tester.tap(find.text('Continuar editando'));
    await tester.pumpAndSettle();
    expect(find.text('Ana'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('¿Cancelar el pedido?'), findsOneWidget);
    await tester.tap(find.text('Sí, cancelar'));
    await tester.pumpAndSettle();
    expect(find.text('Abrir formulario'), findsOneWidget);
    expect(store.cart, hasLength(1));
    expect(store.orders, isEmpty);
  });

  testWidgets('Catálogo, personalización, carrito y pedido simulado', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final store = ShopStore();
    await tester.runAsync(store.init);
    await tester.pumpWidget(IceCreamApp(store: store));
    await tester.pumpAndSettle();
    expect(find.text('Ice Cream App'), findsOneWidget);
    await tester.ensureVisible(find.text('Fresa de temporada'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fresa de temporada'));
    await tester.pumpAndSettle();
    expect(find.text('Detalle del sabor'), findsOneWidget);
    await tester.tap(find.text('Personalizar este sabor'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Añadir · \$ 2.500 COP'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Carrito'));
    await tester.pumpAndSettle();
    expect(find.text('Tu bolsa de felicidad'), findsOneWidget);
    await tester.tap(find.text('Continuar con el pedido'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'A');
    await tester.pumpAndSettle();
    expect(find.text('Escribe al menos 2 caracteres.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, 'Ana');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Simular pedido'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simular pedido'));
    await tester.pumpAndSettle();
    expect(store.orders.single['customer'], 'Ana');
    expect(store.cart, isEmpty);
  });

  testWidgets('El error permite reintentar la carga del catálogo', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    var requests = 0;
    final store = ShopStore(
      catalogDelay: Duration.zero,
      catalogLoader: () async {
        requests++;
        if (requests == 1) throw Exception('Fallo simulado');
        return List.of(demoProducts);
      },
    );

    await tester.runAsync(store.init);
    await tester.pumpWidget(IceCreamApp(store: store));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('No pudimos cargar el catálogo'),
      findsOneWidget,
    );
    expect(requests, 1);

    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(requests, 2);
    expect(find.text('Fresa de temporada'), findsOneWidget);
    expect(find.byKey(const Key('catalog-refresh')), findsOneWidget);
  });
}
