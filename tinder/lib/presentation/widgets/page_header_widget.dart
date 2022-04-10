import 'package:auto_size_text/auto_size_text.dart';
import 'package:tinder/presentation/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:tinder/presentation/resources/icons/app_images.dart';

class PageHeaderWidget extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;

  final AssetImage? leftIcon;
  final Function? leftClicked;

  final AssetImage? rightIcon;
  final Function(dynamic)? rightClicked;

  final Widget? titleWidget;
  final Widget? leftWidget;
  final Widget? rightWidget;

  final EdgeInsets? contentPadding;

  final Color? backgroundColor;

  final Color? colorIconLeft;
  final Color? colorIconRight;

  final GlobalKey? key;
  final bool? showLeftIcon;

  const PageHeaderWidget(
      {this.title,
      this.titleStyle,
      this.leftIcon,
      this.leftClicked,
      this.rightClicked,
      this.rightIcon,
      this.backgroundColor,
      this.showLeftIcon,
      this.contentPadding,
      // generic case
      this.titleWidget,
      this.leftWidget,
      this.rightWidget,
      this.colorIconLeft = Colors.white,
      this.colorIconRight = Colors.white,
      this.key})
      : super(key: key);

  _buildTitleView({required BuildContext context}) {
    return Positioned.fill(
      left: 30,
      right: 30,
      // alignment: Alignment.center,
      child: (titleWidget != null)
          ? titleWidget!
          : SizedBox(
              // color: Colors.red,
              child: Center(
                child: AutoSizeText(
                  title ?? '',
                  style: titleStyle ??
                      titleLarge.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
    );
  }

  _buildLeftView({required BuildContext context}) {
    return Container();
    // return Visibility(
    //   visible: showLeftIcon ?? true,
    //   child: Align(
    //     alignment: Alignment.centerLeft,
    //     child: this.leftWidget != null
    //         ? this.leftWidget
    //         : InkWell(
    //             onTap: () {
    //               if (leftClicked != null) {
    //                 leftClicked!();
    //               } else {
    //                 navigator.popBack(context: context);
    //               }
    //             },
    //             child: Image(
    //               image: this.leftIcon ?? AppImages.icBack,
    //               width: 32,
    //               height: 32,
    //               color: colorIconLeft,
    //             ),
    //           ),
    //   ),
    // );
  }

  _buildRightView({required BuildContext context}) {
    return Align(
      alignment: Alignment.centerRight,
      child: (rightWidget != null)
          ? rightWidget
          : rightIcon != null
              ? GestureDetector(
                  onTapUp: (TapUpDetails details) {
                    if (rightClicked != null) {
                      rightClicked!(details.globalPosition);
                    }
                  },
                  child: Image(
                    image: rightIcon!,
                    width: 32,
                    height: 32,
                    color: colorIconRight,
                  ),
                )
              : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: kToolbarHeight + MediaQuery.of(context).padding.top * 2,
      padding: contentPadding ??
          EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 20, right: 20),
      color: backgroundColor ?? Colors.transparent,
      // color: Colors.yellow,
      child: Stack(
        children: [
          _buildLeftView(context: context),
          _buildTitleView(context: context),
          _buildRightView(context: context),
        ],
      ),
    );
  }
}
