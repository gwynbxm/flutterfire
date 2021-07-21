import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final Reference storageRef = storage.ref();

class StorageService {
  static Future<String> uploadProfilePhoto(
      String url, File img, String userUid) async {
    String photoUid = Uuid().v4();

    UploadTask uploadTask = storageRef
        .child('images/users/$userUid/userProfile_$photoUid.jpg')
        .putFile(img);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // static Future<File> compressImage(String photoId, File image) async {
  //   final tempDirection = await getTemporaryDirectory();
  //   final path = tempDirection.path;
  //   File compressedImage = await FlutterImageCompress.compressAndGetFile(
  //     image.absolute.path,
  //     '$path/img_$photoId.jpg',
  //     quality: 70,
  //   );
  //   return compressedImage;
  // }
}
