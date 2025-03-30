import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class TextTitle extends StatelessWidget {
  final String title;
  const TextTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: 20,

        fontWeight: FontWeight.w800,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}

class TextSubtitle extends StatelessWidget {
  final String title;
  const TextSubtitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: 14,
        color: Get.isDarkMode ? Colors.white.withAlpha(150) : Colors.grey,
      ),
    );
  }
}
