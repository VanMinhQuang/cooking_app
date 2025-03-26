import 'package:flutter/material.dart';

typedef OnClear = void Function(String text);
typedef OnSubmit = void Function (String text);
class BoxFieldSearch extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onFieldChange;
  final OnClear? onClear;
  final OnSubmit? onSubmit;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

   BoxFieldSearch({
    Key? key,
    required this.controller,
    this.hintText,
    this.onFieldChange,
    this.onClear,
     this.onSubmit,
    this.icon,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Adjust height
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black), // Customize border
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
        padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 0),
      child: TextFormField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 0,
            bottom: 0,
            left: 0,
          ),
          prefixIcon: Icon(Icons.search,
              color: Colors.grey, size: 24),
          suffixIcon: controller.text.isEmpty
              ? const SizedBox()
              : IconButton(
            onPressed: () {
              controller.clear();
              if(onClear != null){
                onClear!('');
              }
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.close,
                color: Colors.black, size: 16),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey), // Adjust hint color
          border: InputBorder.none, // Remove default border

        ),
        style: TextStyle(fontSize: 16), // Set font size
        onChanged: (value) {
          if(onFieldChange != null){
            onFieldChange!(value);
          }
        },
        onFieldSubmitted:  onSubmit,

        // Align text properly
      ),
    );
  }
}
