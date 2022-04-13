import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/presentation/base/index.dart';
import 'package:flutter/material.dart';
import 'package:tinder/presentation/widgets/index.dart';
import '../../widgets/circle_indicator.dart';
import 'index.dart';

class HistoryPage extends BasePage {
  const HistoryPage({
    required PageTag pageTag,
    Key? key,
  }) : super(tag: pageTag, key: key);

  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState
    extends BasePageState<HistoryBloc, HistoryPage, HistoryRouter> {
  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get willListenApplicationEvent => true;
  final ScrollController _controller = ScrollController();
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
    return FocusDetector(
      onVisibilityGained: () async {
        if (widget.tag == PageTag.likedUser) {
          bloc.dispatchEvent(FetchLikedUsersEvent());
        }
        if (widget.tag == PageTag.passedUser) {
          bloc.dispatchEvent(FetchPassedUsersEvent());
        }
        await Future.delayed(const Duration(milliseconds: 500));
        if (_controller.hasClients) {
          _controller.animateTo(_controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear);
        }
      },
      child: BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
        return (state.loadingStatus == ExecuteStatus.loading)
            ? buildShimmer()
            : state.users.isEmpty
                ? buildNoDataMessage()
                : GridView.count(
                    controller: _controller,
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.3,
                    crossAxisCount: 2,
                    children: [
                      ...state.users.map((e) => _UserProfileItem(
                            user: e,
                          ))
                    ],
                  );
      }),
    );
  }
}

class _UserProfileItem extends StatelessWidget {
  final UserModel user;
  const _UserProfileItem({required this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColors.gray[400]!,
              blurRadius: 10,
              offset: const Offset(0, 10))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              (user.picture?.isNotEmpty ?? false)
                  ? Positioned.fill(
                      child: CachedNetworkImage(
                        // color: Colors.transparent,
                        fit: BoxFit.cover,
                        imageUrl: user.picture!,
                        placeholder: (context, url) => const Center(
                          child: CircleIndication(),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                    ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    height: 40,
                    color: AppColors.gray[600]!.withAlpha(150),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${user.firstName}, ${user.age}",
                          textAlign: TextAlign.left,
                          style: titleMedium.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ),
                    )),
              ),
              Positioned.fill(
                  child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.95,
                            builder: (BuildContext context,
                                ScrollController scrollController) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 20),
                                            child: Container(
                                              width: 60,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                  color: AppColors.gray[300],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5))),
                                            ),
                                          ),
                                          UserProfileCard(userModel: user),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
