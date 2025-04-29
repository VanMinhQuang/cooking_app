import 'package:cooking_project/app/pages/meal/detail_meal/cubit/detail_meal_cubit.dart';
import 'package:cooking_project/app/pages/meal/detail_meal/cubit/detail_meal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const NavigationButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLike = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailMealCubit, DetailMealState>(
      listenWhen: (previous, current) => current is DetailMealLikeMeal,
      buildWhen: (previous, current) => current is DetailMealLikeMeal,
      listener: (context, state) {
        setState(() {
          _isLike = !_isLike;
        });
      },
      builder: (context, state) {
        return NavigationButton(
          icon: _isLike ? Icons.favorite : Icons.favorite_border,
          onPressed: () {
            context.read<DetailMealCubit>().likeMeal(isLiked: _isLike);
          },
        );
      },
    );
  }
}