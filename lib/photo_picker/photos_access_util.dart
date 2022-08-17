import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:util/photo_picker/no_access_photos_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'permission_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-26 08:16:14
/// Description  :
///
class PhotosAccessUtil {
  static Future<List<AssetEntity>?> pickerPhotoImage({
    required BuildContext context,
    int maxAssetsCount = 1,
    bool mounted = true,
  }) async {
    return pickerPhoto(
        context: context,
        maxAssetsCount: maxAssetsCount,
        requestType: RequestType.image);
  }

  static Future<List<AssetEntity>?> pickerPhoto(
      {required BuildContext context,
      int maxAssetsCount = 1,
      RequestType requestType = RequestType.all}) async {
    List<AssetEntity>? assets;

    final PermissionStatus photosStatus = await Permission.photos.request();

    final bool isFirstAccessPhotos = PermissionUtil.isFirstAccessPhotos();

    if (photosStatus == PermissionStatus.granted) {
      assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: maxAssetsCount,
          requestType: requestType,
        ),
      );
    } else if (!isFirstAccessPhotos) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const NoAccessPhotosPage(),
        ),
      );
    } else {
      print(111);
    }
    return assets;
  }
}
