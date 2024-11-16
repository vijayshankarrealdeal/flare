import 'package:flutter/cupertino.dart';
import 'package:radiant/routes/notification_app.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScaffold) => [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text("Home"),
                  padding: EdgeInsetsDirectional.zero,
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const NotificationApp()),
                    ),
                    child: const Icon(CupertinoIcons.bell),
                  ),
                ),
              ],
          body: Container()),
    );
  }
}
