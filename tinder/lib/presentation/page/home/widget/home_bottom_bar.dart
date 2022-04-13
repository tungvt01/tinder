import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder/presentation/resources/index.dart';
import 'package:tinder/presentation/styles/index.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  final Function(HomeBottomItemType) onTabChanged;
  const HomeBottomNavigationBar({required this.onTabChanged});

  @override
  State<StatefulWidget> createState() => HomeBottomNavigationBarState();
}

class HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: labelSmall.copyWith(color: AppColors.primaryColor),
      unselectedLabelStyle: labelSmall.copyWith(color: AppColors.gray[300]!),
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        HomeBottomItemType itemType = index == 0
            ? HomeBottomItemType.matching
            : (index == 1
                ? HomeBottomItemType.liked
                : HomeBottomItemType.disliked);
        widget.onTabChanged(itemType);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(
            AppImages.icMatchingTabSelected,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          icon: SvgPicture.asset(
            AppImages.icMatchingTab,
            fit: BoxFit.contain,
          ),
          label: 'Matching',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(
            AppImages.icLikeTabSelected,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          icon: SvgPicture.asset(
            AppImages.icLikedTab,
            fit: BoxFit.contain,
          ),
          label: 'Liked',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(
            AppImages.icDislikeTab,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
            color: AppColors.primaryColor,
          ),
          icon: SvgPicture.asset(
            AppImages.icDislikeTab,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          label: 'Passed',
        ),
      ],
    );
  }
}

enum HomeBottomItemType {
  matching,
  liked,
  disliked,
}
