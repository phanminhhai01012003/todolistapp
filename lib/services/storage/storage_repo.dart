import 'dart:io';

abstract class StorageRepo {
  Future<File?> pickImageFromGallery();
  Future<File?> pickImageFromCamera();
  Future<String?> uploadImage(File image);
}