import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:radiant/modules/post_logic.dart';
import 'package:radiant/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ChangeNotifierProvider(
        create: (_) => PostLogic(),
        child: Consumer<PostLogic>(
          builder: (context, provider, child) {
            final posts = provider.posts;
            return SafeArea(
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: posts.length,
                onPageChanged: (index) {
                  if (posts[index].isVideo) {
                    provider.disposeControllersNotIn([index]);
                    provider.initVideoController(posts[index]);
                  }
                },
                itemBuilder: (context, index) {
                  return PostWidget(post: posts[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
