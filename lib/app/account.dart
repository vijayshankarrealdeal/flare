import 'package:flutter/cupertino.dart';
import 'package:radiant/routes/settings.dart';
import 'package:radiant/widgets/sliverheading.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CupertinoSliverNavigationBar(
            largeTitle: const Text("Account"),
            padding: EdgeInsetsDirectional.zero,
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Settings(),
                ),
              ),
              child: const Icon(CupertinoIcons.settings),
            ),
          ),
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: ProfileHeader(
              imageLink:
                  "https://images.pexels.com/photos/4672559/pexels-photo-4672559.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Username"),
                  CupertinoButton(
                    child: const Text("Follow"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
        body: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: CupertinoColors.activeBlue,
                    child: Text('Item $index'),
                  );
                },
                childCount: 40, // Number of items in the grid
              ),
            ),
          ],
        ),
      ),
    );
  }
}
