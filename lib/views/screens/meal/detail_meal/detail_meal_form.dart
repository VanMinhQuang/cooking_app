import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/core/helper/format_number.dart';
import 'package:cooking_project/core/helper/screen_app.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:flutter/material.dart';
import '../../../../data/constant/constant_app.dart';

class DetailMealForm extends StatefulWidget {
  final Meal? food;
  String? heroTag;

  DetailMealForm(this.food, this.heroTag, {super.key});

  @override
  State<DetailMealForm> createState() => _DetailMealFormState();
}

class _DetailMealFormState extends State<DetailMealForm>
    with SingleTickerProviderStateMixin {
  bool isLike = false;
  late PageController _pageController;
  final double imageHeight = 400;
  final double overlap = 50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();

  }

  int _currentContentIndex = 0; // To track the current step

  // Example step data (replace with your actual data)
  final List<Map<String, String>> _steps = [
    {
      'title': 'Step 1: Prepare Ingredients',
      'description': 'Gather all the necessary ingredients: chicken, potatoes, carrots, and oranges.'
    },
    {
      'title': 'Step 2: Season the Chicken',
      'description': 'Rub the chicken with your favorite spices and herbs.'
    },
    {
      'title': 'Step 3: Roast the Vegetables',
      'description': 'Toss the potatoes and carrots with oil and seasoning, then place them around the chicken.'
    },
    {
      'title': 'Step 4: Bake',
      'description': 'Preheat the oven and bake the chicken and vegetables until cooked through.'
    },
    {
      'title': 'Step 5: Serve',
      'description': 'Let the chicken rest for a few minutes before carving and serving with the roasted vegetables and orange slices.'
    },
  ];


  Widget _buildDot(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.orange : Colors.grey[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double imageHeight = 300.0; // Define a fixed height for the image area
    final double overlap = 30.0; // Keep your overlap value

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Image and overlay section with a fixed height
            SizedBox(
              height: imageHeight,
              child: Stack(
                children: [
                  // Image with gradient fade
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: CachedNetworkImage(
                      imageUrl: widget.food!.image!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover, // Use BoxFit.cover for better scaling within the fixed height
                    ),
                  ),

                  // Positioned Leading Button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 16,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),

                  // Positioned Like Button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 10,
                    right: 16,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          isLike ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isLike = !isLike;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Detail Card positioned below the fixed image height
            Transform.translate(
              offset: Offset(0, -overlap), // Move the card up to overlap
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                       // offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Indicator Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDot(0 == _currentContentIndex),
                          const SizedBox(width: 8),
                          _buildDot(1 == _currentContentIndex),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Conditional Content Rendering
                      SizedBox(
                        height: 500 , // Adjust height as needed to fit your content
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentContentIndex = index;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: _buildOverView(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: _buildStepsContent(), // Start with the first step
                            ),
                            // Add more PageView children for additional content
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInfoItem({required IconData icon, required int num, required Color textColor, required String type, required Color boxColor}) {
    return  Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: boxColor),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 2,
            ),
            child: Icon(
              icon,
              size: 15,
              color: textColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1, left: 3),
            child: Text(
              type == 'TIME'
                  ? Formatter.formatTime(num)
                  : num.toString(),
              style: TextThemeStyle.textSecondaryFontSizeBold(12,
                  color:
                   textColor),
            ),
          ),

        ],
      ),
    );
  }



  Widget _buildOverView(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Roasted Chicken',
              style:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildInfoItem(icon: Icons.timer_outlined,num: 120,type: 'TIME',textColor: colorWhite, boxColor: Colors.orange),
              _buildInfoItem(icon: Icons.restaurant_menu,num: 5,type: 'STEP',textColor: colorWhite, boxColor: Colors.orange),
            ],
          ),
          SizedBox(height: 8,),
          Text(
            'Roast chicken is a well‑known oven dish. Everyone may have their own recipe for pickling, but they want to bake crispy tips.',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),

          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
                children: widget.food!.method!.map((category) {
                  return Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          category,
                          style: TextThemeStyle.textSecondaryFontSizeBold(14,
                              color: colorWhite),
                        ),
                        backgroundColor: colorPrimary,
                        shape: StadiumBorder(side: BorderSide.none),
                        visualDensity: VisualDensity.compact,
                      ));
                }).toList()),
          ),
          SizedBox(height: 16),
          Text('Materials',
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...[
            'Whole chicken - 1',
            'Potato - 500g',
            'Carrot - 300g',
            'Orange - 100g'
          ].map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(item),
          )),
          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: colorPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Start Cooking', style: TextThemeStyle.textSecondaryFontSizeBold(18,color: colorWhite)),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsContent() {
    return ListView.builder(
      itemCount: _steps.length,
      itemBuilder: (BuildContext context, int index) { final step = _steps[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              step['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              step['description']!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
      },
    );
  }
}
