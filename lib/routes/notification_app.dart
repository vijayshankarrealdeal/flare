import 'package:flutter/cupertino.dart';

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: "Home",
        middle: const Text("Notifications"),
      ),
      child: Container(),
    );
  }
}