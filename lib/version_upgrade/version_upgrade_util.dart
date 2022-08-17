import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Author       : zhongaidong
/// Date         : 2022-08-17 15:54:16
/// Description  : 版本升级工具
///
class VersionUpgradeUtil {
  // 我们可以在APP所处服务器上建一个version.json文件，用来保存版本信息和更新信息，每次进APP去获取里面的内容，然后和手机上APP版本比较
  static void checkVersion({required BuildContext context}) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // APP的versionName
    final String currentVersion = packageInfo.version;
    // APP的versionCode
    final String buildNumber = packageInfo.buildNumber;
    // 下面进行判断，Android还是ios
    if (Platform.isAndroid) {
      const api = "你的服务器路径/version.json";
      final res = await Dio().get(api);
      if (res.statusCode == 200) {
        // 这里小编直接比较versionCode了，因为直接比较一个数字好比较
        // 如果想比较versionName也可以，思路是先把字符串通过split(".")分割成一个数组，然后分别比较两个数组对应index的两个值，只要有一个小于服务器上的值就提示更新就行了
        if (int.parse(buildNumber) < int.parse(res.data["versionCode"])) {
          showDialog(
              context: context,
              // 强制更新，不可以点击空白区域关闭，不需要可以不要
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text("重要提示！"),
                  content: const Text("检测到新版本，是否更新？"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("立即更新"),
                      onPressed: () {
                        _launcherApp();
                      },
                    ),
                    TextButton(
                      child: const Text("稍后再说"),
                      onPressed: () {
                        // exit(0);
                      },
                    ),
                  ],
                );
              });
        }
      } else {
        Fluttertoast.showToast(
            msg: "服务器错误", gravity: ToastGravity.CENTER, timeInSecForIosWeb: 3);
      }
    } else if (Platform.isIOS) {
      // 通过下面的路径获取你的APP在App Store Connect上面的版本号，截图在下面会贴上来
      // 如果感觉这个方法不靠谱的朋友也可以在version.json里配上刚刚上传审核成功的APP版本号, 然后和本地获取到的APPversion对比，需要更新跳转到App Store进行下载即可
      const iosApi = "https://itunes.apple.com/cn/lookup?id=1631943968";
      final res = await Dio().get(iosApi);
      final Map? resData = json.decode(res.data);
      final List? resResults = resData?['results'];
      if (resData == null || resResults == null || resResults.isEmpty) return;
      // 然后你就会或得一个版本号
      final String? newVersion = resResults.first["version"];
      if (newVersion != null && newVersion.compareTo(currentVersion) > 0) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text("重要提示！"),
                content: const Text("检测到新版本，是否更新？"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("立即更新"),
                    onPressed: () {
                      _launcherApp();
                    },
                  ),
                  TextButton(
                    child: const Text("稍后再说"),
                    onPressed: () {
                      // 退出程序
                      // exit(0);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      }
    }
  }

  static _launcherApp() async {
    if (Platform.isAndroid) {
      // const url = "你的Android apk服务器路径";
      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      //   Fluttertoast.showToast(
      //       msg: "无法加载", gravity: ToastGravity.CENTER, timeInSecForIosWeb: 3);
      // }
    } else if (Platform.isIOS) {
      // ios跳转appstore更新
      const String urlStr = "https://itunes.apple.com/cn/app/id1631943968";
      final Uri url = Uri.parse(urlStr);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        Fluttertoast.showToast(
            msg: "无法加载", gravity: ToastGravity.CENTER, timeInSecForIosWeb: 3);
      }
    }
  }
}
