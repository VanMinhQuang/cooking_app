import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/app/pages/setting/cubit/setting_cubit.dart';
import 'package:cooking_project/app/pages/setting/cubit/setting_state.dart';
import 'package:cooking_project/app/routes.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingUserCard extends StatelessWidget {
  final LocalUser? user;

  const SettingUserCard({this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = user != null;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.login);
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 50,
              width: 50,
              child: CachedNetworkImage(
                imageUrl: isLoggedIn ? user?.avatar ?? '' : '',
                placeholder: (context, url) => defaultUserEmpty,
                errorWidget: (context, url, error) => defaultUserEmpty,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
              isLoggedIn ? user?.displayName ?? '' : 'Chưa login kìa fen'),
          trailing: Icon(isLoggedIn ? Icons.logout : Icons.login),
        ),
      ),
    );
  }


}
