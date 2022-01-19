import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  Future uploadImage(String currentUserId) async {
    final _picker = ImagePicker();
    final _storage = FirebaseStorage.instance;
    PickedFile image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        var snapshot = await _storage.ref().child("profile_picture/${currentUserId}").putFile(file);
        var downloadURL = snapshot.ref.getDownloadURL();
        return [
          image.path,
          downloadURL.toString()
        ];
      } else {
        print("No path received!");
      }
    } else {
      print("Permission is not granted!");
    }
  }
}
