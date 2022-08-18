import 'package:flutter/cupertino.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../alert_sheet/action_sheet_widget.dart';
import 'camera_access_util.dart';
import 'photos_access_util.dart';

typedef Success = void Function(List<AssetEntity>? assets);

///
/// Author       : zhongaidong
/// Date         : 2022-08-17 21:03:25
/// Description  : 相册选择工具
///
mixin PhotoPickerUtil {
  static Future<void> pickAsset({
    required BuildContext context,
    Success? success,
  }) async {
    showCupertinoModalPopup<AssetEntity?>(
      context: context,
      builder: (ctx) => ActionSheetWidget(
        actionTitles: const ['拍照', '从手机相册选择'],
        onPressed: (ctx, index) async {
          Navigator.pop(ctx);
          switch (index) {
            case 0:
              final AssetEntity? asset =
                  await CameraAccessUtil.cameraImage(context: context);
              success?.call(asset != null ? [asset] : []);
              break;
            case 1:
              {
                final List<AssetEntity>? assets =
                    await PhotosAccessUtil.pickerPhotoImage(context: context);
                success?.call(assets);
              }
          }
        },
      ),
    );
  }
}
