import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myportfolio_mobile/projects_page.dart';
import 'package:myportfolio_mobile/screens/experience_form.dart';
import 'package:myportfolio_mobile/screens/login_screen.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/screens/project_form.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final auth = context.read<AuthState>();
    void replace(Widget page) =>
        navigator.pushReplacement(MaterialPageRoute(builder: (_) => page));
    return Drawer(
      width: 230,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Leficullen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Explore My Portfolio',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(indent: 20, endIndent: 20),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => replace(MyHomePage()),
          ),
          ListTile(
            leading: const Icon(Icons.folder_copy),
            title: const Text('Projects'),
            onTap: () => replace(const ProjectsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () async {
              Navigator.pop(context);
              if (await ensureLoggedIn(navigator.context) &&
                  navigator.mounted) {
                replace(const ProjectFormPage());
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Experience'),
            onTap: () => replace(const ExperienceFormPage()),
          ),
          ListTile(
            leading: Icon(isLoggedIn ? Icons.logout : Icons.login),
            title: Text(isLoggedIn ? 'Logout' : 'Login'),
            onTap: () async {
              Navigator.pop(context);
              if (!isLoggedIn) {
                await navigator.push(
                  MaterialPageRoute<bool>(builder: (_) => const LoginScreen()),
                );
              } else {
                var failed = false;
                try {
                  await auth.logout();
                } catch (_) {
                  failed = true;
                }
                if (messenger.mounted) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        failed
                            ? 'Logged out locally; server logout failed.'
                            : 'Logged out.',
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
