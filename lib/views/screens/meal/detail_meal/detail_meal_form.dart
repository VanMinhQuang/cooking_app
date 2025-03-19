import 'package:flutter/material.dart';
import '../../../../data/model/Food.dart';

class DetailMealForm extends StatefulWidget {
  final Food? food;

  DetailMealForm(this.food);

  @override
  State<DetailMealForm> createState() => _DetailMealFormState();
}

class _DetailMealFormState extends State<DetailMealForm> {
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
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),

              child: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.food?.foodId ?? UniqueKey().toString(),
                  child: Image.network(
                    widget.food?.image?.isNotEmpty == true
                        ? widget.food!.image!
                        : 'https://via.placeholder.com/400', // Fallback image
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: CircularProgressIndicator(
                          value: loadingProgress
                              .expectedTotalBytes !=
                          null
                          ? loadingProgress
                              .cumulativeBytesLoaded /
                          loadingProgress
                              .expectedTotalBytes!
                              : null,
                      ));
                    },
                  ),
                ),
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
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // ✅ This allows scrolling when header collapses
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(widget.food!.foodName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              ),
              Row(
                children: [
                  const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),

                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: widget.food!.category!.map((category) {
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(category),
                        backgroundColor: Colors.grey[200],
                      ),
                    );
                  }).toList()
                ),
              ),

               Text(
                widget.food!.descr!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
// ChoiceChip(label: const Text("L"), selected: false),