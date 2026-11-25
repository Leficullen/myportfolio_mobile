import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/screens/project_detail_screen.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late Future<List<Project>> _future;
  @override
  void initState() {
    super.initState();
    _future = context.read<ApiClient>().getProjects();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getProjects();
    setState(() => _future = future);
    try {
      await future;
    } catch (_) {
      /* FutureBuilder displays the error. */
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Projects')),
    drawer: const LeftDrawer(),
    body: FutureBuilder<List<Project>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Could not load projects.'),
                ElevatedButton.icon(
                  onPressed: _reload,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        final projects = snapshot.data ?? [];
        return RefreshIndicator(
          onRefresh: _reload,
          child: projects.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 120),
                    Center(child: Text('No projects found.')),
                  ],
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return Card(
                      child: ListTile(
                        title: Text(project.title),
                        subtitle: Text(
                          '${project.techStack}\n${project.description}',
                        ),
                        isThreeLine: true,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProjectDetailScreen(project: project),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    ),
  );
}
