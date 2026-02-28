import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/services/storage/storage_services.dart';

Future<File?> showImagePickerModal(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Commoncolor.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))), 
    builder: (context) => ShowImagePickerModal()
  );
}

class ShowImagePickerModal extends StatefulWidget {
  const ShowImagePickerModal({super.key});

  @override
  State<ShowImagePickerModal> createState() => _ShowImagePickerModalState();
}

class _ShowImagePickerModalState extends State<ShowImagePickerModal> {
  final imageService = StorageServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 5,
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: Commoncolor.grey
            ),
          ),
          SizedBox(height: 15),
          Text("Choose your avatar",
            style: TextStyle(
              color: Commoncolor.black,
              fontWeight: FontWeight.w700,
              fontSize: 15
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Commoncolor.blue,
                foregroundColor: Commoncolor.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33))
              ),
              onPressed: () async{
                final picked = await imageService.pickImageFromCamera();
                if (picked != null) {
                  Navigator.pop(context, picked);
                }
              }, 
              child: Text("Take a photo", style: TextStyle(fontSize: 16))
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Commoncolor.blue,
                foregroundColor: Commoncolor.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33))
              ),
              onPressed: () async{
                final picked = await imageService.pickImageFromGallery();
                if (picked != null) {
                  Navigator.pop(context, picked);
                }
              }, 
              child: Text("Open from gallery", style: TextStyle(fontSize: 16))
            ),
          )
        ],
      ),
    );
  }
}