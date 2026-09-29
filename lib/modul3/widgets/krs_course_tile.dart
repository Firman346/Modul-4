import 'package:flutter/material.dart';

import '../models/krs_course.dart';

class KrsCourseTile extends StatelessWidget {
  const KrsCourseTile({
    super.key,
    required this.course,
    required this.onTap,
    required this.onDelete,
  });

  final KrsCourse course;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          child: Text(
            course.sks.toString(),
          ),
        ),
        title: Text(
          course.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${course.code} • ${course.lecturer}',
          ),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'detail') {
              onTap();
            } else if (value == 'hapus') {
              onDelete();
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 'detail',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Detail'),
                ),
              ),
              PopupMenuItem(
                value: 'hapus',
                child: ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Hapus'),
                ),
              ),
            ];
          },
        ),
        onTap: onTap,
      ),
    );
  }
}