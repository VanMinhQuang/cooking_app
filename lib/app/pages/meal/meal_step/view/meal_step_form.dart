
import 'package:cooking_project/app/widgets/mixin/base_mixin.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealStepForm extends StatefulWidget {
  const MealStepForm({super.key});

  @override
  State<MealStepForm> createState() => _MealStepFormState();
}

class _MealStepFormState extends State<MealStepForm> with BaseMixin{
  final PageController _controller = PageController();
  int _currentStep = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentStep = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          PageView.builder(
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(child: Divider(thickness: 2, endIndent: 10)),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: colorPrimary,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 2, indent: 10)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
