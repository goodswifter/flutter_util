import 'package:flutter/cupertino.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-05-07 09:59:35
/// Description  : 苹果风格ActionSheet
///
class ActionSheetWidget extends StatelessWidget {
  const ActionSheetWidget({
    Key? key,
    required this.actionTitles,
    this.title = '',
    this.onPressed,
  }) : super(key: key);

  final String title;
  final List<String> actionTitles;
  final Function(BuildContext context, int index)? onPressed;

  @override
  Widget build(BuildContext context) {
    final int length = actionTitles.length;
    final List<CupertinoActionSheetAction> actions = [];

    for (var i = 0; i < length; i++) {
      final String title = actionTitles[i];
      actions.add(CupertinoActionSheetAction(
        child: Text(title),
        onPressed: () => onPressed!(context, i),
      ));
    }
    return CupertinoActionSheet(
      title: title.isNotEmpty ? Text(title) : null,
      actions: actions,
      cancelButton: CupertinoActionSheetAction(
        child: const Text('取消'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
