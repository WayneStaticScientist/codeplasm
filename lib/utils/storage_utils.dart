import 'dart:io';

import 'package:codeplasm/db/db_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProjectStorage {
  Future<String> get getProjectDirectory async {
    return join(
      (await getApplicationDocumentsDirectory()).path,
      "codeplasm",
      "projects",
    );
  }

  Future<void> writeToDirectoryIndex(
    String data,
    String project,
    String index,
  ) async {
    final directory = Directory(
      "${await getProjectDirectory}/${project.replaceAll(" ", "")}",
    );
    try {
      await directory.create(recursive: true);
    } catch (e) {
      throw "failed to create directory";
    }
    final path = await getProjectDirectory;
    final file = File('$path/${project.replaceAll(" ", "")}/$index');
    file.writeAsString(data);
  }

  Future<String> projectFinilizedPath(Project project) async {
    return (Directory(
      "${await getProjectDirectory}/${project.name.replaceAll(" ", "")}",
    )).path;
  }
}
