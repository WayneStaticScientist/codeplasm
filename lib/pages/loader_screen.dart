import 'package:codeplasm/db/db_init.dart';
import 'package:codeplasm/pages/main_screen.dart';
import 'package:codeplasm/pages/project_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  @override
  void initState() {
    super.initState();
    _fetchProject();
  }

  _fetchProject() async {
    final preferences = await SharedPreferences.getInstance();
    final projectName = preferences.getString('name');
    if (projectName == null || projectName.isEmpty) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
      return;
    }
    final db = ProjectsDb();
    final project = await db.getProject(projectName);
    if (project != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectScreen(project: project),
          ),
        );
      }
      return;
    }
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
