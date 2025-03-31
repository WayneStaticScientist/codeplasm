import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:codeplasm/db/db_helper.dart';
import 'package:codeplasm/utils/storage_utils.dart';
import 'package:codeplasm/widgets/code_editor.dart';
import 'package:codeplasm/widgets/text_widgets.dart';
import 'package:codeplasm/utils/snappers_object.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/xml.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;
  const ProjectScreen({super.key, required this.project});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late String projectPath;
  String _openedProject = "";
  final _projectsMap = <String, SnappersMap>{};
  final _projectsTitles = <String, SnappersObject>{};
  @override
  void initState() {
    super.initState();
  }

  Future<Object?> _getProjectData() async {
    final projectStorage = ProjectStorage();
    projectPath = await projectStorage.projectFinilizedPath(widget.project);
    _projectsTitles[join(projectPath, widget.project.root)] = SnappersObject(
      label: widget.project.root,
      path: join(projectPath, widget.project.root),
    );
    final projectsController = CodeController(language: xml);
    _projectsMap[join(projectPath, widget.project.root)] = SnappersMap(
      controller: projectsController,
      editor: AwesomeEditor(controller: projectsController),
    );
    _openedProject = join(projectPath, widget.project.root);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: FutureBuilder(
        future: _getProjectData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return _buildScrollView(snapshot);
          if (snapshot.hasError) {
            return Center(child: Text("There was error ${snapshot.error}"));
          }
          return SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _buildScrollView(data) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: TextTitle(title: widget.project.name),
          floating: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
            IconButton(onPressed: () {}, icon: Icon(Icons.undo)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    _projectsTitles.entries
                        .map(
                          (e) => Chip(
                            label: Text(
                              e.value.label,
                              style: TextStyle(
                                color:
                                    e.value.path == _openedProject
                                        ? Get.theme.colorScheme.surface
                                        : null,
                              ),
                            ),
                            side: BorderSide.none,
                            backgroundColor:
                                e.value.path == _openedProject
                                    ? Get.theme.colorScheme.onSurface
                                    : null,
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ),
        _getEditorWindow(),
      ],
    );
  }

  Widget _getEditorWindow() {
    final editorWindow = _projectsMap[_openedProject];
    return SliverFillRemaining(
      child:
          editorWindow == null
              ? Center(child: Text("No opened editors found!"))
              : editorWindow.editor,
    );
  }
}
