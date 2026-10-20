import 'package:flutter/material.dart';

import 'models.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key, required this.order});

  final Map<String, dynamic> order;

  int get currentStep {
    final status = '${order['status']}'.toLowerCase();
    if (status.contains('listo') || status.contains('ready')) return 2;
    if (status.contains('prepar')) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    const steps = [
      ('Pedido recibido', 'La tienda recibió la solicitud.'),
      ('En preparación', 'Estamos preparando tus helados.'),
      ('Listo para recoger', 'Puedes acercarte a la tienda.'),
    ];
    final simulated = order['status'] == 'Simulado';
    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento del pedido')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  simulated ? 'Pedido de demostración' : 'Estado del pedido',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text('Referencia: ${order['id']}'),
                Text('Total: ${money((order['total'] as num).round())}'),
                if (simulated)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      'Este seguimiento es una simulación y no corresponde a una tienda real.',
                    ),
                  ),
                const SizedBox(height: 24),
                ...List.generate(steps.length, (index) {
                  final completed = index <= currentStep;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      child: Icon(completed ? Icons.check : Icons.more_horiz),
                    ),
                    title: Text(steps[index].$1),
                    subtitle: Text(steps[index].$2),
                  );
                }),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Volver a mis pedidos'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
