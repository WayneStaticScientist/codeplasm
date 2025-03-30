import 'package:flutter/material.dart';

class DecoratedTextfields extends StatelessWidget {
  final String hint;
  final Widget icon;
  final TextEditingController? controller;
  const DecoratedTextfields({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface.withAlpha(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: icon,
        prefixIconColor: Theme.of(context).colorScheme.primary,
        hintText: hint,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
        ),
      ),
    );
  }
}
