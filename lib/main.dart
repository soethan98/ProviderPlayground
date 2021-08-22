import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_playgroud/app/auth_widget.dart';
import 'package:provider_playgroud/services/firebase_auth_service.dart';
import 'package:provider_playgroud/services/firebase_storage_service.dart';
import 'package:provider_playgroud/services/firestore_service.dart';
import 'package:provider_playgroud/services/image_picker_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        Provider<ImagePickerService>(create: (_) => ImagePickerService()),
        Provider<FirebaseStorageService>(create: (_) => FirebaseStorageService()),
        Provider<FirestoreService>(create: (_) => FirestoreService())
      ],
      child: MaterialApp(
        title: 'Material App',
        home: AuthWidget(),
      ),
    );
  }
}
