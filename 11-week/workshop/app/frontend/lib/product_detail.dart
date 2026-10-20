import 'package:flutter/material.dart';

import 'models.dart';
import 'store.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.store, required this.productId});
  final ShopStore store;
  final int productId;
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  static const mode = String.fromEnvironment('DETAIL_MODE', defaultValue: 'normal');
  late Future<Product?> request;

  @override
  void initState() {
    super.initState();
    request = load();
  }

  Future<Product?> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (mode == 'error') throw Exception('Fallo de detalle simulado');
    if (mode == 'not-found') return null;
    return widget.store.products.where((p) => p.id == widget.productId).firstOrNull;
  }

  void retry() => setState(() => request = load());

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detalle del sabor')),
    body: SafeArea(
      child: FutureBuilder<Product?>(
        future: request,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: Semantics(
                liveRegion: true,
                label: 'Cargando detalle del sabor',
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return message(
              Icons.cloud_off,
              'No pudimos cargar este sabor',
              FilledButton(onPressed: retry, child: const Text('Reintentar')),
            );
          }
          final product = snapshot.data;
          if (product == null) {
            return message(
              Icons.search_off,
              'Este sabor ya no está disponible',
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver al catálogo'),
              ),
            );
          }
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const Icon(Icons.icecream_rounded,
                      size: 120, color: Color(0xff99596c)),
                  const SizedBox(height: 24),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Chip(label: Text(product.category)),
                  const SizedBox(height: 16),
                  Text(product.description),
                  const SizedBox(height: 16),
                  Text(
                    'Desde ${money(product.price)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Consulta al personal sobre alérgenos y contaminación cruzada.',
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () => Navigator.pop(context, product),
                    icon: const Icon(Icons.tune),
                    label: const Text('Personalizar este sabor'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );

  Widget message(IconData icon, String text, Widget action) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 72),
          const SizedBox(height: 20),
          Text(text, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          action,
        ],
      ),
    ),
  );
}
