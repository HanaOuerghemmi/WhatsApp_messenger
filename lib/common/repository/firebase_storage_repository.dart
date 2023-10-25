import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final FirebaseStorageRepositoryProvider = Provider(
  (ref) => FirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance),
  );

class FirebaseStorageRepository{
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRepository({required this.firebaseStorage});
  
  storageFileToFirebase(String ref, var file) async{
      UploadTask? uploadTask;
      if (file is File) {
          uploadTask = firebaseStorage.ref().child(ref).putFile(file);
          
      }
      if (file is Uint8List) {
          uploadTask = firebaseStorage.ref().child(ref).putData(file);
          
      }

      TaskSnapshot snapshot = await uploadTask!;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;

  }
}