import 'package:flutter/material.dart';

class CatalogSkeleton extends StatelessWidget {
  const CatalogSkeleton({super.key});

  Widget line(double width, double height) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: const Color(0xffeadfe1),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    label: 'Cargando catálogo de helados',
    child: ExcludeSemantics(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth < 420 ? 1 : 2;
          final width =
              (constraints.maxWidth - 40 - (columns - 1) * 12) / columns;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              line(double.infinity, 150),
              const SizedBox(height: 20),
              line(double.infinity, 56),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  4,
                  (_) => SizedBox(
                    width: width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            line(double.infinity, 110),
                            const SizedBox(height: 12),
                            line(width * .7, 18),
                            const SizedBox(height: 8),
                            line(width * .45, 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
