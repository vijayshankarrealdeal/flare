import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Feeds extends StatelessWidget {
  const Feeds({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context)
          .requestFocus(FocusNode()); // Unfocus any text field
    });
    return CupertinoPageScaffold(
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScaffold) => [
                const CupertinoSliverNavigationBar(
                  largeTitle:  Text("Feed"),
                  padding: EdgeInsetsDirectional.zero,
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CupertinoSearchTextField(
                      autofocus: false,
                      placeholder: 'Search...',
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                          alignment: Alignment.center,
                          color: CupertinoColors.activeBlue,
                          child: Text(
                            'Item $index',
                            style:
                                const TextStyle(color: CupertinoColors.white),
                          ),
                        ),
                      ),
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 4,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: const [
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(2, 2),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                        ],
                      )),
                )
              ],
          body: Container()),
    );
  }
}
