import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});
  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '',
      _description = '',
      _techStack = '',
      _url = '',
      _image = '';
  bool _submitting = false;

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required.' : null;
  String? _validateUrl(String? value, {bool optional = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return optional ? null : 'This field is required.';
    final uri = Uri.tryParse(text);
    if (uri == null ||
        !['http', 'https'].contains(uri.scheme) ||
        uri.host.isEmpty) {
      return 'Enter a valid HTTP or HTTPS URL.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _submitting) return;
    setState(() => _submitting = true);
    try {
      if (!await ensureLoggedIn(context) || !mounted) return;
      final auth = context.read<AuthState>();
      final project = Project(
        title: _title.trim(),
        description: _description.trim(),
        techStack: _techStack.trim(),
        urlLink: _url.trim(),
        image: _image.trim(),
      );
      await context.read<ApiClient>().createProject(
        project,
        token: auth.token!,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Project added'),
          content: Text('Project "${project.title}" was created.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
      _title = _description = _techStack = _url = _image = '';
    } on ApiException catch (error) {
      if (error.statusCode == 401 && mounted) {
        try {
          await context.read<AuthState>().logout();
        } catch (_) {
          /* Local token is cleared even if revocation fails. */
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.statusCode == 401
                  ? 'Session expired. Please log in again.'
                  : 'Could not create project (${error.statusCode}).',
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not connect to the server.')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Add Project Form'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
    ),
    drawer: const LeftDrawer(),
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: _required,
              onChanged: (v) => _title = v,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: _required,
              onChanged: (v) => _description = v,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tech Stack',
                border: OutlineInputBorder(),
              ),
              validator: _required,
              onChanged: (v) => _techStack = v,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              validator: _validateUrl,
              onChanged: (v) => _url = v,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project Image URL (Optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              validator: (v) => _validateUrl(v, optional: true),
              onChanged: (v) => _image = v,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const CircularProgressIndicator()
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    ),
  );
}
