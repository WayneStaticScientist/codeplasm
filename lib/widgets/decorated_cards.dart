import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DecoratedCard extends StatelessWidget {
  final Widget child;
  const DecoratedCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.theme.colorScheme.onSurface.withAlpha(16),
      child: child,
    );
  }
}
