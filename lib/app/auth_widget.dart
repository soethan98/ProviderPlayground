import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_playgroud/app/home/home_page.dart';
import 'package:provider_playgroud/app/sign_in/sign_in_page.dart';
import 'package:provider_playgroud/services/firebase_auth_service.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<CurrentUser?>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user != null
              ? Provider<CurrentUser>.value(value: user, child: HomePage())
              : SignInPage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
