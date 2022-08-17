import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'photo_picker/camera_access_util.dart';
import 'photo_picker/photo_picker_util.dart';
import 'version_upgrade/version_upgrade_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? name;
  @override
  void initState() {
    super.initState();
    // VersionUpgradeUtil.checkVersion(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('测试')),
      body: FutureBuilder<AssetEntity?>(
          future: PhotoPickerUtil.pickAsset(context: context),
          builder:
              (BuildContext context, AsyncSnapshot<AssetEntity?> snapshot) {
            // if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                final AssetEntity? asset = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     // 版本测试
                    //     // VersionUpgradeUtil.checkVersion(context: context);

                    //     name = '5';
                    //   },
                    //   child: const Text('检测应用版本升级'),
                    // ),
                    asset == null
                        ? const Text('没有选择图片')
                        : imageAssetWidget(asset),
                  ],
                );
              }
            // } else {
            //   // 请求未结束，显示loading
            //   return const Center(
            //       child: CircularProgressIndicator(color: Color(0xFF046A38)));
            // }
          }),
    );
  }

  Widget imageAssetWidget(
    AssetEntity entity, {
    double? width,
    double? height,
  }) {
    return Image(
      image: AssetEntityImageProvider(entity, isOriginal: false),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
