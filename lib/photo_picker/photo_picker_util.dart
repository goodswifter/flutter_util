import 'package:flutter/cupertino.dart';
import 'package:util/alert_sheet/action_sheet_widget.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'camera_access_util.dart';
import 'photos_access_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2022-08-17 21:03:25
/// Description  :
///
class PhotoPickerUtil {
  static Future<AssetEntity?> pickAsset({required BuildContext context}) async {
    AssetEntity? assetEntity;
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ActionSheetWidget(
        actionTitles: const ["拍照", "从手机相册选择"],
        onPressed: (ctx, index) async {
          Navigator.pop(context);
          switch (index) {
            case 0:
              assetEntity =
                  await CameraAccessUtil.cameraImage(context: context);
              break;
            case 1:
              {
                final List<AssetEntity>? assets =
                    await PhotosAccessUtil.pickerPhotoImage(context: context);
                assetEntity = assets?.first;
              }
          }
        },
      ),
    );
    return assetEntity;
  }
}
