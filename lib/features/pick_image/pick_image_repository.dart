import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Pick Image Repository
class PickImageRepository {
  /// Pick, Crop and Compress in square
  Future<File?> pickCropCompressSquare(ImageSource source) async {
    try {
      final xFile = await ImagePicker().pickImage(source: source);
      if (xFile != null) {
        final cropFile = await ImageCropper().cropImage(
          sourcePath: xFile.path,
          compressFormat: ImageCompressFormat.png,
          maxWidth: 512,
          maxHeight: 512,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Recortar imágen',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
              aspectRatioPresets: const [
                CropAspectRatioPreset.square,
              ],
            ),
            IOSUiSettings(
              title: 'Recortar imágen',
              aspectRatioPresets: const [
                CropAspectRatioPreset.square,
              ],
            ),
          ],
        );
        if (cropFile != null) {
          return File(cropFile.path);
        }
      }
    } catch (e) {
      log(
        'pick_image.repository.dart on pickCropCompressSquare: $e',
      );
    }
    return null;
  }
}
