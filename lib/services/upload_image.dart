import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<bool> uploadImage(File image) async {
  print(image.path);
  final String nameFile = image.path.split('/').last;
  final Reference reference = storage.ref().child("images").child(nameFile);
  final UploadTask uploadTask = reference.putFile(image);
  print(uploadTask);

  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  print(snapshot);
  final String url = await snapshot.ref.getDownloadURL();
  print(url);

  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}
