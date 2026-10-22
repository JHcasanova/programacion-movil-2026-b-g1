import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models.dart';
import 'package:frontend/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('La demo respeta el modo de error y conserva el carrito', () async {
    SharedPreferences.setMockInitialValues({});
    final store = ShopStore(catalogDelay: Duration.zero);
    await store.init();
    store.add(demoProducts.first, 'Una bola', 'Sin topping');
    if (ShopStore.demoCheckoutError) {
      await expectLater(store.checkout('Ana', ''), throwsA(isA<OrderFailure>()));
      expect(store.cart, hasLength(1));
      expect(store.orders, isEmpty);
    } else {
      await store.checkout('Ana', '');
      expect(store.cart, isEmpty);
      expect(store.orders.single['customer'], 'Ana');
    }
  });
}
