import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportfolio_mobile/main.dart';
import 'package:myportfolio_mobile/models/project.dart';
import 'package:myportfolio_mobile/screens/project_form.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';

void main() {
  const projectJson = {
    'id': 'abc',
    'title': 'Portfolio',
    'description': 'A project',
    'tech_stack': 'Flutter',
    'url_link': 'https://example.com',
    'image': null,
  };

  test('project JSON matches the backend and omits server id', () {
    final project = Project.fromJson(projectJson);
    expect(project.image, '');
    expect(project.urlLink, 'https://example.com');
    expect(project.toJson(), {
      'title': 'Portfolio',
      'description': 'A project',
      'tech_stack': 'Flutter',
      'url_link': 'https://example.com',
      'image': '',
    });
  });

  test(
    'API client sends authenticated project and handles token endpoints',
    () async {
      final client = ApiClient(
        baseUrl: 'https://example.com',
        client: MockClient((request) async {
          switch (request.url.path) {
            case '/api/v1/auth/token/':
              expect(jsonDecode(request.body), {
                'username': 'user',
                'password': 'password',
              });
              return http.Response('{"token":"secret"}', 200);
            case '/api/v1/projects/':
              if (request.method == 'GET') {
                return http.Response(jsonEncode([projectJson]), 200);
              }
              expect(request.headers['authorization'], 'Token secret');
              expect(
                jsonDecode(request.body)['url_link'],
                'https://example.com',
              );
              return http.Response(jsonEncode(projectJson), 201);
            case '/api/v1/auth/logout/':
              expect(request.headers['authorization'], 'Token secret');
              return http.Response('', 204);
            default:
              return http.Response('', 404);
          }
        }),
      );
      expect(await client.obtainToken('user', 'password'), 'secret');
      final projects = await client.getProjects();
      expect(projects.single.title, 'Portfolio');
      expect(
        (await client.createProject(projects.single, token: 'secret')).id,
        'abc',
      );
      await client.logout(token: 'secret');
      client.close();
    },
  );

  test('logout clears local state even when revocation fails', () async {
    final client = ApiClient(
      client: MockClient((_) async => http.Response('error', 500)),
    );
    final auth = AuthState(client, initialToken: 'secret');
    await expectLater(auth.logout(), throwsA(isA<ApiException>()));
    expect(auth.isLoggedIn, isFalse);
    auth.dispose();
    client.close();
  });

  testWidgets('protected form requires login; cancel returns home', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    expect(find.text('Username'), findsOneWidget);
    expect(find.byType(ProjectFormPage), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Tambah Proyek'), findsOneWidget);
  });

  testWidgets('public project list displays API data and detail', (
    tester,
  ) async {
    final api = ApiClient(
      client: MockClient(
        (_) async => http.Response(jsonEncode([projectJson]), 200),
      ),
    );
    addTearDown(api.close);
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MyApp(apiClient: api));
    await tester.tap(find.text('Lihat Proyek'));
    await tester.pumpAndSettle();
    expect(find.text('Portfolio'), findsOneWidget);
    await tester.tap(find.text('Portfolio'));
    await tester.pumpAndSettle();
    expect(find.text('Tech stack: Flutter'), findsOneWidget);
  });
  testWidgets('drawer login opens form and submits a project', (tester) async {
    final api = ApiClient(
      client: MockClient((request) async {
        if (request.url.path.endsWith('/token/')) {
          return http.Response('{"token":"secret"}', 200);
        }
        if (request.method == 'POST' &&
            request.url.path.endsWith('/projects/')) {
          expect(request.headers['authorization'], 'Token secret');
          return http.Response(jsonEncode(projectJson), 201);
        }
        return http.Response('', 404);
      }),
    );
    addTearDown(api.close);
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MyApp(apiClient: api));
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'owner');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Portfolio');
    await tester.enterText(fields.at(1), 'A project');
    await tester.enterText(fields.at(2), 'Flutter');
    await tester.enterText(fields.at(3), 'https://example.com');
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Project added'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
  });
}
