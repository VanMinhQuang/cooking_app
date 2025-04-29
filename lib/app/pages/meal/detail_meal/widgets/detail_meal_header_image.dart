import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/app/widgets/button/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealHeaderImage extends StatelessWidget {
  final String imageUrl;
  final String? heroTag;

  const MealHeaderImage({
    Key? key,
    required this.imageUrl,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.sp,
      child: Stack(
        children: [
          // Image with gradient fade
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.sp,
            left: 16.sp,
            child: NavigationButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Like button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.sp,
            right: 16.sp,
            child: LikeButton(),
          ),
        ],
      ),
    );
  }
}