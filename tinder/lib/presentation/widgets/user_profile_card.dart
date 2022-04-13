import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/model/index.dart';
import '../styles/index.dart';
import 'index.dart';

class UserProfileCard extends StatelessWidget {
  final UserModel userModel;
  const UserProfileCard({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray[200],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserAvatarWidget(
              userModel: userModel,
            ),
            _UserInfoWidget(
              userModel: userModel,
            ),
          ],
        ),
      ),
    );
  }
}

class _UserAvatarWidget extends StatelessWidget {
  final UserModel userModel;
  const _UserAvatarWidget({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.3,
      child: SizedBox(
          width: double.infinity,
          child: (userModel.picture?.isNotEmpty ?? false)
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: userModel.picture!,
                    placeholder: (context, url) => const Center(
                      child: CircleIndication(),
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                )),
    );
  }
}

class _UserInfoWidget extends StatelessWidget {
  final UserModel userModel;
  const _UserInfoWidget({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text("${userModel.firstName}, ${userModel.age}",
              style: titleLarge.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text("I want to make new friends here",
              style: titleMedium.copyWith(fontWeight: FontWeight.w300)),
          const SizedBox(height: 10),
          (userModel.location?.fullAddress.isNotEmpty ?? false)
              ? Text("${userModel.location?.fullAddress}",
                  style: titleSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray[700],
                      fontSize: 12))
              : const SizedBox(),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
