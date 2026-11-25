import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.apiClient});
  final ApiClient? apiClient;

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      if (apiClient == null)
        Provider<ApiClient>(
          create: (_) => ApiClient(),
          dispose: (_, client) => client.close(),
        )
      else
        Provider<ApiClient>.value(value: apiClient!),
      ChangeNotifierProvider(
        create: (context) => AuthState(context.read<ApiClient>()),
      ),
    ],
    child: MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.black,
          seedColor: Colors.black,
          secondary: Colors.amber[700],
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    ),
  );
}
