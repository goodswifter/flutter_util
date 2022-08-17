import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-25 16:03:24
/// Description  : 无法访问图片页
///

class NoAccessPhotosPage extends StatelessWidget {
  const NoAccessPhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(primary: Colors.green);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 200,
            child: Column(
              children: [
                const Text(
                  "无法访问相册中图片",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  child: const Text(
                    "你已关闭京师OA照片访问权限，建议允许访问「所有照片」",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            child: SizedBox(
              width: 150,
              child: ElevatedButton(
                style: style,
                child: const Text(
                  "前往系统设置",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () => PhotoManager.openSetting(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
