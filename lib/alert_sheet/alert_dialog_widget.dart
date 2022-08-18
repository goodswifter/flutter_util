import 'package:flutter/cupertino.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-05-07 09:59:35
/// Description  : 苹果风格的弹窗
///
class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    Key? key,
    this.title,
    this.content,
    this.confirmTitle = '确定',
    this.confirmPressed,
  }) : super(key: key);
  final String? title;
  final String? content;
  final String confirmTitle;
  final VoidCallback? confirmPressed;

  @override
  Widget build(BuildContext context) {
    final CupertinoDialogAction cancelAction = CupertinoDialogAction(
      textStyle: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
      onPressed: () => Navigator.pop(context),
      child: const Text('取消'),
    );

    final CupertinoDialogAction confirmAction = CupertinoDialogAction(
      child: Text(confirmTitle),
      onPressed: () {
        Navigator.pop(context);
        confirmPressed?.call();
      },
    );
    return CupertinoAlertDialog(
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
      actions: [cancelAction, confirmAction],
    );
  }
}
