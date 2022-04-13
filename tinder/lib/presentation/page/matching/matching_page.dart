import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/presentation/base/index.dart';
import 'package:tinder/presentation/resources/index.dart';
import 'package:flutter/material.dart';
import 'package:tinder/presentation/widgets/index.dart';
import 'index.dart';

class MatchingPage extends BasePage {
  const MatchingPage({
    required PageTag pageTag,
    Key? key,
  }) : super(tag: pageTag, key: key);

  @override
  State<StatefulWidget> createState() => MatchingPageState();
}

class MatchingPageState
    extends BasePageState<MatchingBloc, MatchingPage, MatchingRouter> {
  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get willListenApplicationEvent => true;

  @override
  void initState() {
    super.initState();
    bloc.dispatchEvent(PageInitStateEvent(context: context));
  }

  @override
  void stateListenerHandler(BaseState state) async {
    super.stateListenerHandler(state);
  }

  @override
  Widget buildLayout(BuildContext context, BaseBloc bloc) {
    return BlocBuilder<MatchingBloc, MatchingState>(builder: (context, state) {
      return ((state.listUsers?.length ?? 0) == 0 &&
              state.loadingStatus == ExecuteStatus.loading)
          ? buildShimmer(count: 20)
          : SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: state.listUsers != null
                      ? Stack(
                          children: [
                            ...state.listUsers!.map<Widget>(
                              (entity) => Positioned.fill(
                                child: UserProfileCard(
                                  userModel: entity,
                                ),
                              ),
                            ),
                            Positioned(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _LikeButton(
                                    state: state,
                                  ),
                                  _PassButton(
                                    state: state,
                                  )
                                ],
                              ),
                              bottom: 20,
                              left: 0,
                              right: 0,
                            )
                          ],
                        )
                      : Container()),
            );
    });
  }
}

class _PassButton extends StatelessWidget {
  final MatchingState state;
  const _PassButton({required this.state});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: ElevatedButton(
          onPressed: () {
            final user = (state.listUsers?.isNotEmpty ?? false)
                ? state.listUsers?.last
                : null;
            if (user != null) {
              context
                  .read<MatchingBloc>()
                  .dispatchEvent(DislikedEvent(user: user));
            }
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.pressed)
                    ? AppColors.gray[200]
                    : null;
              },
            ),
            elevation: MaterialStateProperty.all<double>(10),
            shadowColor:
                MaterialStateProperty.all<Color>(AppColors.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: SvgPicture.asset(
            AppImages.icClose,
            fit: BoxFit.contain,
            width: 25,
            height: 25,
          )),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final MatchingState state;
  const _LikeButton({required this.state});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: ElevatedButton(
          onPressed: () {
            final user = (state.listUsers?.isNotEmpty ?? false)
                ? state.listUsers?.last
                : null;
            if (user != null) {
              context
                  .read<MatchingBloc>()
                  .dispatchEvent(LikedEvent(user: user));
            }
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(10),
            shadowColor:
                MaterialStateProperty.all<Color>(AppColors.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.primaryColor),
          ),
          child: SvgPicture.asset(
            AppImages.icWhiteHeart,
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          )),
    );
  }
}
