import 'package:flutter/cupertino.dart';
import 'package:radiant/routes/settings.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Account"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const Settings()),
          ),
          child: const Icon(CupertinoIcons.settings),
        ),
      ), child: Container(),
    );
  }
}
