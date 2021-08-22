import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_playgroud/common_widgets/avatar.dart';
import 'package:provider_playgroud/models/avatar_reference.dart';
import 'package:provider_playgroud/services/firebase_auth_service.dart';
import 'package:provider_playgroud/services/firebase_storage_service.dart';
import 'package:provider_playgroud/services/firestore_service.dart';
import 'package:provider_playgroud/services/image_picker_service.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAbout(BuildContext context) async {
    
    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     fullscreenDialog: true,
    //     builder: (_) => AboutPage(),
    //   ),
    // );
  }

  Future<void> _chooseAvatar(BuildContext context) async {
   try {
      final imagePicker = Provider.of<ImagePickerService>(context);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        final user = Provider.of<CurrentUser>(context, listen: false);
        final storage = Provider.of<FirebaseStorageService>(context);
        final downloadUrl =
            await storage.uploadAvatar(uid: user.uid, file: File(file.path));
        // 3. Save url to Firestore
        final database = Provider.of<FirestoreService>(context);
        await database.setAvatarReference(
          uid: user.uid,
          avatarReference: AvatarReference(downloadUrl),
        );
        // 4. (optional) delete local file as no longer needed
        await File(file.path).delete();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () => _onAbout(context),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _signOut(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(context),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final database = Provider.of<FirestoreService>(context);
    final user = Provider.of<CurrentUser>(context, listen: false);
    return StreamBuilder<AvatarReference>(
        stream: database.avatarReferenceStream(uid: user.uid),
        builder: (context, snapshot) {
          final avatarReference = snapshot.data;
          return Avatar(
            photoUrl: avatarReference?.downloadUrl,
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onPressed: () => _chooseAvatar(context),
          );
        });
  }
}
