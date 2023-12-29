class Task {
  final String uid;
  final String title;
  final String description;
  final String date;
  final String category;
  final bool isFinished;
  final String? id;

  Task({
    this.id,
    required this.isFinished,
    required this.uid,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });
}
