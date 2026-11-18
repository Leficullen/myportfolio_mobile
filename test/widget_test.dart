import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportfolio_mobile/main.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/screens/project_form.dart';

Future<void> tapSave(WidgetTester tester) async {
  final button = find.widgetWithText(ElevatedButton, 'Save');
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Project form rejects empty and whitespace-only required fields', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProjectFormPage()));
    await tapSave(tester);
    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

    await tester.enterText(find.byType(TextFormField).at(0), '   ');
    await tester.enterText(find.byType(TextFormField).at(1), '   ');
    await tapSave(tester);
    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('Submission shows every value and resets fields and category', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProjectFormPage()));
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'My Portfolio');
    await tester.enterText(fields.at(1), 'A Flutter portfolio');
    await tester.enterText(fields.at(2), 'Flutter, Django');
    await tester.enterText(fields.at(3), 'https://example.com');
    final category = find.byType(DropdownButtonFormField<String>);
    await tester.ensureVisible(category);
    await tester.tap(category);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mobile Development').last);
    await tester.pumpAndSettle();
    await tapSave(tester);
    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Nama Proyek: My Portfolio'), findsOneWidget);
    expect(find.text('Deskripsi: A Flutter portfolio'), findsOneWidget);
    expect(find.text('Kategori: Mobile Development'), findsOneWidget);
    expect(find.text('Teknologi: Flutter, Django'), findsOneWidget);
    expect(find.text('Tautan: https://example.com'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    for (final field in tester.widgetList<EditableText>(find.byType(EditableText))) {
      expect(field.controller.text, isEmpty);
    }
    expect(tester.state<FormFieldState<String>>(category).value, 'Web Development');

    await tester.enterText(fields.at(0), 'Second project');
    await tester.enterText(fields.at(1), 'Optional fields are empty');
    await tapSave(tester);
    expect(find.text('Kategori: Web Development'), findsOneWidget);
    expect(find.text('Teknologi: '), findsOneWidget);
    expect(find.text('Tautan: '), findsOneWidget);
  });

  testWidgets('Home button pushes form and back returns to home', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    final context = tester.element(find.byType(ProjectFormPage));
    expect(Navigator.of(context).canPop(), isTrue);
    Navigator.of(context).pop();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Drawer replaces route with form and can return home', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectFormPage), findsOneWidget);
    expect(Navigator.of(tester.element(find.byType(ProjectFormPage))).canPop(), isFalse);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
