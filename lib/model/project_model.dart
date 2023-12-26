class ProjectModel {
  final String? projectName;
  final String? typeProject;
  final String? frameworkUsing;
  final String? startProject;
  final String? projectBy;
  final String? endProject;
  final String? descriptionProject;
  final String? pathImage;
  final String? githubLink;
  final String? playStoreLink;
  final String? appStoreLink;
  final String? webLink;
  const ProjectModel(
      {required this.projectName,
      required this.typeProject,
      required this.frameworkUsing,
      required this.startProject,
      required this.endProject,
      required this.projectBy,
      required this.descriptionProject,
      required this.pathImage,
      required this.appStoreLink,
      required this.webLink,
      required this.githubLink,
      required this.playStoreLink});

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
      projectName: json["project_name"],
      typeProject: json["type_project"],
      frameworkUsing: json["framework_using"],
      startProject: json["start_project"],
      endProject: json["end_project"],
      projectBy: json["project_by"],
      descriptionProject: json["description_project"],
      pathImage: json["path_image"],
      appStoreLink: json["appstore_link"],
      webLink: json["web_link"],
      githubLink: json["github_link"],
      playStoreLink: json["playstore_link"]);
}
