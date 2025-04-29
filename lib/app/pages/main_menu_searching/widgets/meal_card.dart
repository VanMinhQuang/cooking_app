import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double cardBorderRadius = 15.0; // Adjust corner rounding


    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      elevation: 5.0,
      margin: const EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(

          fit: StackFit.expand,
          children: <Widget>[

            CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => defaultImageEmpty,
              errorWidget: (context, url, error) => defaultImageEmpty,
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100, // Adjust gradient height (e.g., percentage of card height)
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      // Adjust opacity and color for desired darkness
                      Colors.black.withOpacity(0.85),
                      Colors.black.withOpacity(0.0), // Fade to transparent
                    ],
                    // Adjust stops to control where the fade starts/ends
                    stops: const [0.0, 0.9],
                  ),
                ),
              ),
            ),




            Positioned(
              bottom: 15.0,
              left: 15.0,
              right: 15.0,
              child: Text(
                title,
                style: const TextStyle(
                    color: colorWhite,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,

                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3.0,
                        color: Colors.black87,
                      ),
                    ]
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}