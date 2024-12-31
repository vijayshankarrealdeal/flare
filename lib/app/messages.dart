import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiant/routes/chat_page.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScaffold) => [
                const CupertinoSliverNavigationBar(
                  largeTitle: Text("Messages"),
                  padding: EdgeInsetsDirectional.zero,
                ),
              ],
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, idx) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoListTile(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                builder: (context) => const ChatPage(
                                  username: "Alpha",
                                ),
                              ),
                            );
                          },
                          padding:
                            const  EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          additionalInfo: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                child: Text('2'),
                              ),
                              Text("4hr ago"),
                            ],
                          ),
                          trailing: const Icon(CupertinoIcons.chevron_forward),
                          leadingSize: MediaQuery.of(ctx).size.width * 0.15,
                          subtitle: const Text("Message"),
                          leading: const CircleAvatar(
                            radius: 38,
                            backgroundColor: CupertinoColors.systemBrown,
                          ),
                          title: const Text("Name"),
                        ),
                        const Divider(
                          thickness: 0.6,
                        ),
                      ],
                    );
                  },
                  childCount: 5,
                ),
              )
            ],
          )),
    );
  }
}
