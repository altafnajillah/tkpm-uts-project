class Task {
  final String id;
  final String subject;
  final String subtitle;
  final String desc;
  final DateTime deadline;

  Task({
    this.id = '',
    required this.subject,
    required this.subtitle,
    required this.desc,
    required this.deadline,
  });
}
