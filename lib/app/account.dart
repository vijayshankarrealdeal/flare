import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(
                        color: CupertinoColors.activeBlue,
                        width: 0.5, // Border width
                      ),
                      minimumSize: const Size(70, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Follow",
                        style: TextStyle(
                          color: CupertinoTheme.of(context).brightness ==
                                  Brightness.dark
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        )),
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
