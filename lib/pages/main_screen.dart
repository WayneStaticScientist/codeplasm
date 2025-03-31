import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:codeplasm/db/db_helper.dart';
import 'package:codeplasm/db/db_init.dart';
import 'package:codeplasm/pages/project_screen.dart';
import 'package:codeplasm/utils/storage_utils.dart';
import 'package:codeplasm/utils/utils.dart';
import 'package:codeplasm/widgets/decorated_cards.dart';
import 'package:codeplasm/widgets/decorated_textfields.dart';
import 'package:codeplasm/widgets/drop_downs.dart';
import 'package:codeplasm/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ProjectsDb _projectsDb = ProjectsDb();
  List<TabItem> items = [
    TabItem(icon: Icons.home, title: 'main'),
    TabItem(icon: Icons.crib_outlined, title: 'samples'),
    TabItem(icon: Icons.add, title: 'new project'),
    TabItem(icon: Icons.document_scanner_rounded, title: 'projects'),
    TabItem(icon: Icons.settings, title: 'settings'),
  ];
  final List<String> defaultExample = [
    'Empty',
    'Simple Html Template',
    'Hello world Html Template',
    'Javascript Html Template',
    'Python Sample',
  ];
  int visit = 0;
  final _projectNameController = TextEditingController();
  final _fileNameController = TextEditingController(text: "index.html");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: ListTile(
              title: const TextTitle(title: "Hie User"),
              subtitle: const TextSubtitle(title: "Welcome to CodePlasm"),
              trailing: CircleAvatar(child: Icon(Icons.person)),
            ),
            floating: true,
            pinned: true,
          ),
          SliverList.list(
            children: [
              SizedBox(height: 16),
              DecoratedCard(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextTitle(title: "CodePlasm"),
                      const SizedBox(height: 8),
                      const TextSubtitle(
                        title: "Decorative Text editor and ide",
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showNewProjectBanner(context);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Create New Project"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: Get.theme.colorScheme.surface,
        color: Get.theme.colorScheme.onSurface,
        colorSelected: Get.theme.colorScheme.primary,
        indexSelected: visit,
        onTap:
            (int index) => setState(() {
              if (index == 2) {
                return _showNewProjectBanner(context);
              }
              visit = index;
            }),
      ),
    );
  }

  void _showNewProjectBanner(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Material(
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ListTile(
                    title: const TextTitle(title: "Create New Project"),
                    subtitle: const TextSubtitle(title: "Select a template"),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedTextfields(
                      controller: _projectNameController,
                      hint: 'Project Name',
                      icon: Icon(Icons.save),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: TextSubtitle(title: 'Project Type'),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedDropDown(
                      list: ["html/css/js", "other"],
                      dropDownHint: 'Project Type',
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextSubtitle(title: 'Project Template'),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedDropDown(
                      list: defaultExample,
                      dropDownHint: 'Select Project Template',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedTextfields(
                      hint: 'Project entry file',
                      controller: _fileNameController,
                      icon: Icon(Icons.video_file_sharp),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final projectRoot = _fileNameController.text;
                      final projectTitle = _projectNameController.text;
                      final preferences = await SharedPreferences.getInstance();
                      if (projectTitle.replaceAll(" ", "").isEmpty) {
                        Utils.showToast("The project title shouldnt be empty");
                      }
                      if (projectRoot.replaceAll(" ", "").isEmpty) {
                        Utils.showToast("The project root shouldnt be empty");
                      }
                      if (await _projectsDb.projectExists(projectTitle)) {
                        Utils.showToast("Project Already Exists Change Name");
                        return;
                      }
                      final projectStorage = ProjectStorage();
                      try {
                        await projectStorage.writeToDirectoryIndex(
                          "<h1></h1>",
                          projectTitle,
                          projectRoot,
                        );
                        final project = Project(
                          name: projectTitle,
                          dateTime: DateTime.now().millisecondsSinceEpoch,
                          root: projectRoot,
                        );
                        await _projectsDb.insertProject(project);
                        preferences.setString("name", projectTitle);
                        Get.to(ProjectScreen(project: project));
                      } catch (e) {
                        Utils.showToast(
                          "failed to save project $e",
                          error: true,
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Create New Project"),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
