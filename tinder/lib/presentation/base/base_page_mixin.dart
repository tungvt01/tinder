import 'package:tinder/presentation/utils/index.dart';
import 'package:tinder/presentation/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder/presentation/resources/index.dart';
import 'package:tinder/presentation/resources/localization/app_localization.dart';
import 'package:tinder/presentation/styles/index.dart';
export 'package:tinder/presentation/resources/icons/app_images.dart';
export 'package:tinder/presentation/styles/text_style.dart';
export 'package:tinder/presentation/styles/app_colors.dart';
export 'package:tinder/presentation/resources/icons/app_images.dart';
export 'package:tinder/presentation/resources/localization/app_localization.dart';
export 'package:flutter/material.dart';
export 'package:tinder/presentation/styles/index.dart';

mixin BasePageMixin {
  Future<void> showSnackBarMessage(String msg, BuildContext context) async {
    final snackBar = SnackBar(
      backgroundColor: AppColors.primaryColor,
      content: Container(
        height: 40,
        color: AppColors.primaryColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(msg,
              style: bodyMedium.copyWith(
                  color: Colors.red, fontWeight: FontWeight.w500)),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  hideKeyboard(context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<dynamic> showWidgetDialog(
      {required BuildContext context, required Widget child}) async {
    return AlertManager.showWidgetDialog(context: context, child: child);
  }

  Future<bool> showAlert(
      {required BuildContext context,
      String? title,
      required String message,
      String? okActionTitle,
      String? cancelTitle,
      TextStyle? titleStyle,
      TextStyle? messageStyle,
      bool? dismissWithBackPress,
      Color primaryColor = AppColors.primaryColor}) async {
    final result = await AlertManager.showAlert(
        context: context,
        message: message,
        title: title,
        okActionTitle: okActionTitle,
        cancelTitle: cancelTitle,
        titleStyle: titleStyle,
        dismissWithBackPress: dismissWithBackPress,
        messageStyle: messageStyle,
        primaryColor: primaryColor);
    return result;
  }

  buildSeparator(
      {EdgeInsets padding = const EdgeInsets.all(0),
      double height = 0.5,
      Color color = AppColors.gray}) {
    return Padding(
      padding: padding,
      child: Container(
        height: height,
        color: color,
      ),
    );
  }

  buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  buildBottomLoadMore({Color? backgroundColor}) {
    return Container(
      alignment: Alignment.center,
      color: backgroundColor ?? AppColors.gray.withAlpha(150),
      child: const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  showBottomSheetMenu<T>(
      {required Widget child,
      required BuildContext context,
      double? height,
      bool isDismissible = false}) {
    return showModalBottomSheet<T>(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.gray,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        // ),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: 60,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  )),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: Container(
                    color: Colors.white,
                    height:
                        height ?? MediaQuery.of(context).size.height * 5 / 6,
                    alignment: Alignment.center,
                    child: Center(child: child)),
              ),
            ],
          );
        });
  }

  buildHeaderPageAppBar(
      {required BuildContext context,
      Key? key,
      String? title,
      TextStyle? titleStyle,
      AssetImage? leftIcon,
      Function? leftClicked,
      Function(dynamic)? rightClicked,
      AssetImage? rightIcon,
      Color? backgroundColor,
      EdgeInsets? contentPadding,
      bool? showLeftIcon,
      // generic case
      Widget? titleWidget,
      Widget? leftWidget,
      Widget? rightWidget,
      int alpha = 160,
      Color colorIconLeft = Colors.white,
      Color colorIconRight = Colors.white}) {
    return PreferredSize(
        key: key,
        preferredSize: const Size.fromHeight(50),
        child: PageHeaderWidget(
          backgroundColor: backgroundColor ?? Colors.transparent,
          title: title,
          titleStyle: titleStyle,
          leftIcon: leftIcon,
          rightIcon: rightIcon,
          showLeftIcon: showLeftIcon,
          leftClicked: leftClicked,
          rightClicked: rightClicked,
          contentPadding: contentPadding,
          titleWidget: titleWidget,
          leftWidget: leftWidget,
          rightWidget: rightWidget,
          colorIconLeft: colorIconLeft,
          colorIconRight: colorIconRight,
        ));
  }

  Widget buildShimmer({int count = 20}) {
    final children = List.generate(count, (index) => ShimmeItemWidget());
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget buildNoDataMessage() {
    return LayoutBuilder(builder: (context, constrainst) {
      return SizedBox(
        height: constrainst.maxHeight,
        child: Center(
          child: Text(
            AppLocalizations.shared.commonMessageNoData,
            style: bodyMedium.copyWith(
              color: AppColors.primaryColor,
              fontSize: 17,
            ),
          ),
        ),
      );
    });
  }
}
