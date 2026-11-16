import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Projects Page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,

      body: Center(
        child: Text(
          "Projects Page",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      drawer: const LeftDrawer(),
    );
  }
}

// class
