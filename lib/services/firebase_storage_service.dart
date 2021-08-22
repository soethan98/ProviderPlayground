import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'firestore_path.dart';

class FirebaseStorageService {
  final String uid;

  FirebaseStorageService({required this.uid});

  /// Upload an avatar from file
  Future<String> uploadAvatar({required File file}) async => await upload(
        file: file,
        path: FirestorePath.avatar(uid) + '/avatar.png',
        contentType: 'image/png',
      );

  Future<String> upload(
      {required File file,
      required String path,
      required String contentType}) async {
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(file);

    try {
      TaskSnapshot snapshot = await uploadTask;
      print('Uploaded ${snapshot.bytesTransferred} bytes.');
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('downloadUrl: $downloadUrl');
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
