import 'dart:io';

import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todolistapp/services/storage/storage_repo.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';

class StorageServices extends StorageRepo{
  @override
  Future<File?> pickImageFromGallery() async{
    // TODO: implement pickImage
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;
    return File(pickedImage.path);
  }

  @override
  Future<String?> uploadImage(File image) async{
    // TODO: implement uploadImage
    try {
      File file = File(image.path);
      var cloudinary = Cloudinary.fromStringUrl('cloudinary://${dotenv.env['API_KEY']}:${dotenv.env['API_SECRET']}@${dotenv.env['CLOUD_NAME']}');
      var response = await cloudinary.uploader().upload(file, params: UploadParams(folder: dotenv.env['FOLDER']));
      return response?.data?.url ?? "";
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
  
  @override
  Future<File?> pickImageFromCamera() async{
    // TODO: implement pickImageFromCamera
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) return null;
    return File(pickedImage.path);
  }

}