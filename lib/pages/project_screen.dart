import 'package:flutter/material.dart';
import 'package:codeplasm/db/db_helper.dart';
import 'package:codeplasm/widgets/text_widgets.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;
  const ProjectScreen({super.key, required this.project});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextTitle(title: widget.project.name)),
    );
  }
}
