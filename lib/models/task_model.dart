
class TaskModel {
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.finished,
    required this.type,
  });

  String? id;
  String title;
  String description;
  String date;
  bool finished;
  String type;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    date: json["date"],
    description: json["description"],
    finished: json["finished"],
    title: json["title"],
    type: json["type"],
    id: json["id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "description": description,
    "finished": finished,
    "title": title,
    "type": type,
    "id": id,
  };
}