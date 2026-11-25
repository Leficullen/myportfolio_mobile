import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myportfolio_mobile/screens/login_screen.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';

Future<bool> ensureLoggedIn(BuildContext context) async {
  if (context.read<AuthState>().isLoggedIn) return true;
  return await Navigator.of(context)
          .push<bool>(MaterialPageRoute(builder: (_) => const LoginScreen())) ??
      false;
}
