import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_playgroud/app/home/home_page.dart';
import 'package:provider_playgroud/app/sign_in/sign_in_page.dart';
import 'package:provider_playgroud/services/firebase_auth_service.dart';


/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<CurrentUser?> snapshot;

  AuthWidget({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.active) {
      return snapshot.hasData ? HomePage() : SignInPage();
    }

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // final authService =
    //     Provider.of<FirebaseAuthService>(context, listen: false);
    // return StreamBuilder<CurrentUser?>(
    //   stream: authService.onAuthStateChanged,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       final user = snapshot.data;
    //       return user != null
    //           ? Provider<CurrentUser>.value(value: user, child: HomePage())
    //           : SignInPage();
    //     }
    //     return Scaffold(
    //       body: Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //     );
    //   },
    // );
  }
}
