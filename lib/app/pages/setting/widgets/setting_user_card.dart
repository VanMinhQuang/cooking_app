import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/app/routes.dart';

class SettingUserCard extends StatelessWidget {
  const SettingUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.login),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 50,
              width: 50,
              child: CachedNetworkImage(
                imageUrl: '',
                placeholder: (context, url) => defaultUserEmpty,
                errorWidget: (context, url, error) => defaultUserEmpty,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: const Text('Chưa login kìa fen'),
          trailing: const Icon(Icons.login),
        ),
      ),
    );
  }
}
