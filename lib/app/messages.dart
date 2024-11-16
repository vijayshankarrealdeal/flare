import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScaffold) => [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text("Messages"),
                  padding: EdgeInsetsDirectional.zero,
                ),
              ],
          body: Container()),
    );
  }
}
