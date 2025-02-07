import 'package:flutter/cupertino.dart';
import 'package:radiant/app/account.dart';
import 'package:radiant/app/feed.dart';
import 'package:radiant/app/home.dart';
import 'package:radiant/app/messages.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> mainScreens = const [
      HomePage(),
      Feeds(),
      Messages(),
      Account()
    ];
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            height: MediaQuery.of(context).size.height * 0.085,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.app,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.search,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.chat_bubble_2,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.person,
                  ),
                  label: ""),
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return CupertinoTabView(builder: (context) {
              return mainScreens[index];
            });
          }),
    );
  }
}
