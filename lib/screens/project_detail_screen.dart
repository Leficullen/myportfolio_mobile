import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(project.title)),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.image.isNotEmpty)
            Image.network(
              project.image,
              errorBuilder: (_, _, _) => const Text('Image unavailable'),
            ),
          Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(project.description),
          const SizedBox(height: 12),
          Text('Tech stack: ${project.techStack}'),
          if (project.urlLink.isNotEmpty) ...[
            const SizedBox(height: 12),
            SelectableText('Project URL: ${project.urlLink}'),
          ],
        ],
      ),
    ),
  );
}
