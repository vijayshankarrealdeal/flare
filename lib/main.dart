import 'package:flutter/cupertino.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:provider/provider.dart';
import 'package:radiant/main_page.dart';
import 'package:radiant/modules/settings_logic.dart';

void main() async {
  final noScreenshot = NoScreenshot.instance;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => SettingsLogic()),
  ], child: const MyApp()));
  await noScreenshot.screenshotOff();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsLogic>(builder: (context, settingsLogic, _) {
      return CupertinoApp(
        theme: CupertinoThemeData(
            textTheme: const CupertinoTextThemeData(),
            brightness:
                settingsLogic.dark ? Brightness.dark : Brightness.light),
        debugShowCheckedModeBanner: false,
        home: const StartPage(),
      );
    });
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainPage();
  }
}
