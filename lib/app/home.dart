import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, idx) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Username"),
                                        Text("Location"),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(CupertinoIcons.ellipsis),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          decoration: BoxDecoration(
                                            color: CupertinoColors.activeBlue,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.heart),
                                      const SizedBox(width: 2),
                                      Text("204")
                                    ],
                                  ),
                                  const SizedBox(width: 18),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.chat_bubble),
                                      const SizedBox(width: 2),
                                      Text("450")
                                    ],
                                  ),
                                  const SizedBox(width: 18),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.triangle),
                                      const SizedBox(width: 2),
                                      Text("204")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
          body: Container()),
    );
  }
}
