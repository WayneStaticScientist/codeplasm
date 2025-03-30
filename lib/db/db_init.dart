import 'package:codeplasm/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class ProjectsDb {
  static const String dbName = 'projects.db';
  static const String tableName = 'projects';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnRoot = 'root';
  static const String columnCreatedAt = 'dateTime';
  static Database? _database;
  // Create the database and the table
  Future<Database> init() async {
    if (ProjectsDb._database != null) return ProjectsDb._database!;
    return await openDatabase(
      dbName,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnRoot TEXT NOT NULL,
            $columnCreatedAt INTEGER NOT NULL,
          )
          ''');
      },
    );
  }

  Future<bool> insertProject(Project project) async {
    final db = await init();
    return await db.insert(tableName, project.toMap()) > 0;
  }

  Future<List<Project>> getProjects() async {
    final db = await init();
    final results = await db.query(tableName);
    return results.map((e) => Project.fromMap(e)).toList();
  }

  Future<bool> projectExists(String project) async {
    final db = await init();
    final query = await db.query(
      tableName,
      where: "$columnName = ?",
      whereArgs: [project],
    );
    return query.isNotEmpty;
  }
}
