/// Data model for activity items
class ActivityItem {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final String? assignee;
  final String? priority;

  const ActivityItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.assignee,
    this.priority,
  });
}
