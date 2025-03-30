class Project {
  final String name;
  final int dateTime;
  final String root;
  Project({required this.name, required this.dateTime, required this.root});
  Map<String, dynamic> toMap() {
    return {"root": root, "name": name, "dateTime": dateTime};
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map["name"],
      dateTime: map["dateTime"],
      root: map["root"],
    );
  }
}
