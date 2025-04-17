import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/model/meal_model.dart';
import 'package:flutter/material.dart';
import '../../../../data/constant/constant_app.dart';

class DetailMealForm extends StatefulWidget  {
  final Meal? food;
  String? heroTag;

  DetailMealForm(this.food, this.heroTag, {super.key});

  @override
  State<DetailMealForm> createState() => _DetailMealFormState();
}

class _DetailMealFormState extends State<DetailMealForm>     with SingleTickerProviderStateMixin  {
  bool isLike = false;
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _pageController.animateToPage(
            _tabController.index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }
  final List<Map<String, String>> timeAndSteps = [
    {"time": "45 min", "steps": "7"},
  ];

  final List<String> stepDetails = [
    "Step 1: Prepare ingredients",
    "Step 2: Mix the ingredients",
    "Step 3: Cook on medium heat",
    "Step 4: Serve",
    "Step 5: Enjoy",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),

    );
  }

  Widget _buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            leading: Container(
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
            backgroundColor: Colors.transparent,
            expandedHeight: 300,
            elevation: 0,
            floating: false,
            pinned: true,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              child: FlexibleSpaceBar(
                background: Hero(
                    tag: widget.heroTag ?? UniqueKey().toString(),
                    child: CachedNetworkImage(
                      imageUrl: widget.food?.image ?? '',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => defaultImageEmpty,
                      errorWidget: (context, url, error) => defaultImageEmpty,
                    )),
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(isLike ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isLike = !isLike;
                    });
                  },
                ),
              ),
            ],
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  widget.food!.mealName!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Row(
                children: [
                  const Text("Category",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
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
                        style: TextThemeStyle.textSecondaryFontSizeBold(14, color: colorWhite),
                      ),
                      backgroundColor: colorPrimary,
                      shape: StadiumBorder(side: BorderSide.none),
                      visualDensity: VisualDensity.compact,
                    )
                  );
                }).toList()),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: "Tong quat"),
                    Tab(text: "Chi tiet"),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: PageView(
                
                controller: _pageController,
                  children: <Widget>[
                    // Tab 1: Grid with time and total steps
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200, // Fixed height constraint
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 3,
                              child: Text("Time: ${timeAndSteps[0]["time"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Card(
                                elevation: 3,
                                child: Text("Total Steps: ${timeAndSteps[0]["steps"]}")),
                          ],
                        )
                      ),
                    ),
                    // Tab 2: Details of each step
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200, // Fixed height constraint
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: stepDetails.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(stepDetails[index]),
                              leading: Icon(Icons.check_circle_outline),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ChoiceChip(label: const Text("L"), selected: false),
