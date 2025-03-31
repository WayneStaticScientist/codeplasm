import 'package:codeplasm/widgets/code_editor.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

class SnappersObject {
  final String label;
  final String path;
  bool unsaved = false;
  SnappersObject({required this.label, required this.path});
}

class SnappersMap {
  final CodeController controller;
  final AwesomeEditor editor;
  SnappersMap({required this.controller, required this.editor});
}
