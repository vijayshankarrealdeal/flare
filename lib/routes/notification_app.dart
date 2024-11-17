import 'package:flutter/cupertino.dart';

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: "Home",
        middle:  Text("Notifications"),
      ),
      child: Container(),
    );
  }
}
