import 'package:flutter/cupertino.dart';

class ChatPage extends StatelessWidget {
  final String username;
  const ChatPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    void showActionSheet(BuildContext context) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Choose an Action'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context); // Close the action sheet
              },
              child: const Text('Call'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true, // Highlights the action in red
              onPressed: () {
                Navigator.pop(context); // Close the action sheet
              },
              child: const Text('Block'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context); // Close the action sheet
            },
            child: const Text('Cancel'),
          ),
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          previousPageTitle: "Messages",
          middle: Text(username),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => showActionSheet(context),
            child: const Icon(CupertinoIcons.ellipsis_vertical),
          )),
      child: Container(),
    );
  }
}
