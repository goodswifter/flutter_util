import 'package:flutter/material.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'photo_picker/photo_picker_util.dart';
import 'photo_picker/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化sp
  await SpUtil.getInstance();
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
  ValueNotifier<AssetEntity?> notifier = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
    SpUtil.putBool('aaa', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('测试')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await PhotoPickerUtil.pickAsset(
                  context: context,
                  success: (assets) {
                    if (assets != null) {
                      notifier.value = assets.first;
                    }
                  },
                );
              },
              child: const Text('检测应用版本升级'),
            ),
            ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, Widget? child) {
                return notifier.value != null
                    ? imageAssetWidget(notifier.value!)
                    : const Text('222');
              },
            ),
          ],
        ),
      ),
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
