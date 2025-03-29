import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/views/screens/logn/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({super.key});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 30),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCartItem(),
              SizedBox(height: 16),
              Text('Cài đặt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildOptionCard(Icons.text_format, "Đánh giá app"),
              _buildOptionCard(Icons.language, "Ngôn ngữ"),
            ],
          ),
        ),
      );

  }

  Widget _buildCartItem() {
    return Container(
      //padding: EdgeInsets,
      child: Card(
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),)),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                height: 50,
                width: 50,
                child: CachedNetworkImage(
                  imageUrl: '',
                  errorWidget: (context, url, error) => defaultUserEmpty,
                  placeholder: (context, url) => defaultUserEmpty,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text('Chưa login kìa fen'),
            subtitle: Text(''),
            trailing: Icon(Icons.login),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(IconData icon, String title) {
    return Card(
      color:  Colors.white,
      shape: RoundedRectangleBorder(
        side:  BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(

        onTap: () {
          print('');
        },
        child: ListTile(
          leading: Icon(icon, color: Colors.black54),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}
