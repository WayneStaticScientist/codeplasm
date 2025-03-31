import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:get/get.dart';

class AwesomeEditor extends StatelessWidget {
  final CodeController controller;
  const AwesomeEditor({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: monokaiSublimeTheme),
      child: SingleChildScrollView(
        child: CodeField(
          textStyle: TextStyle(fontSize: 16),
          gutterStyle: GutterStyle(background: Colors.white),
          controller: controller,
          background: Get.theme.colorScheme.surface,
        ),
      ),
    );
  }
}
