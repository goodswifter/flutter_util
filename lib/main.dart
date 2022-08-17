import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
    VersionUpgradeUtil.checkVersion(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('测试')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            VersionUpgradeUtil.checkVersion(context: context);
          },
          child: const Text('检测应用版本升级'),
        ),
      ),
    );
  }
}
