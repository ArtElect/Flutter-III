import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(PlatformFile file) async {
    try {
      TaskSnapshot upload = await _firebaseStorage.ref('${file.name}-${DateTime.now().toIso8601String()}.${file.extension}')
        .putData(file.bytes!, SettableMetadata(contentType: 'image/${file.extension}'),);
      String url = await upload.ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      debugPrint('error in uploading image for : ${e.toString()}');
      return '';
    }
  }
}