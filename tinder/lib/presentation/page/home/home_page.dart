import 'package:tinder/presentation/base/index.dart';
import 'package:flutter/material.dart';
import 'package:tinder/presentation/page/history/index.dart';
import 'package:tinder/presentation/page/home/widget/home_bottom_bar.dart';
import 'package:tinder/presentation/page/matching/matching_page.dart';
import 'index.dart';

class HomePage extends BasePage {
  const HomePage({
    required PageTag pageTag,
    Key? key,
  }) : super(tag: pageTag, key: key);

  @override
  State<StatefulWidget> createState() => MatchingPageState();
}

class MatchingPageState extends BasePageState<HomeBloc, HomePage, HomeRouter> {
  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get willListenApplicationEvent => true;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void stateListenerHandler(BaseState state) async {
    super.stateListenerHandler(state);
  }

  @override
  Widget buildLayout(BuildContext context, BaseBloc bloc) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          MatchingPage(pageTag: PageTag.matching),
          HistoryPage(pageTag: PageTag.likedUser),
          HistoryPage(pageTag: PageTag.passedUser)
        ],
      ),
      bottomNavigationBar: HomeBottomNavigationBar(onTabChanged: (type) {
        if (type == HomeBottomItemType.matching) {
          _currentIndex = 0;
        }
        if (type == HomeBottomItemType.liked) {
          _currentIndex = 1;
        }

        if (type == HomeBottomItemType.disliked) {
          _currentIndex = 2;
        }
        setState(() {});
      }),
    );
  }
}
