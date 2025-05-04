import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cooking_project/app/pages/home/view/home_screen.dart';
import 'package:cooking_project/app/pages/setting/cubit/setting_cubit.dart';
import 'package:cooking_project/app/pages/setting/cubit/setting_state.dart';
import 'package:cooking_project/app/widgets/dialog/alert_dialog.dart';
import 'package:cooking_project/app/widgets/mixin/base_mixin.dart';
import 'package:cooking_project/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/setting_widgets.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({super.key});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> with ProgressDialogMixin {
  LocalUser? _user;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<SettingCubit>().isAuthenticate();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SettingCubit, SettingState>(
        listener: (BuildContext context, state) async {
          if (state is SettingIsAuthenticate) {
            _user = state.localUser;
          }

          if (state is SettingLoading) {
            showProgressDialog(message: '');
          }

          if (state is SettingLogout) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => HomeScreen(
                        key: UniqueKey(),
                      )),
              (route) => false,
            );
          }
          if (state is SettingError) {
             CustomAlertDialog.showErrorAlert(
                context: context, content: state.error);
          }
        },
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (BuildContext context, state) {
            return Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingUserCard(
                    user: _user,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cài đặt',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const SettingOptionTile(
                    icon: Icons.text_format,
                    title: "Đánh giá app",
                  ),
                  const SettingOptionTile(
                    icon: Icons.language,
                    title: "Ngôn ngữ",
                  ),
                  _user == null
                      ? SizedBox()
                      : SettingOptionTile(
                          icon: Icons.account_circle,
                          title: "Đăng xuất",
                          color: Color(0xFFFFCDD2),
                          // colorRed.shade100
                          isLogout: true,
                          onTapOption: () => CustomAlertDialog.showCustomDialog(
                              context: context,
                              type: DialogType.warning,
                              title: 'Đăng xuất',
                              content: 'Are u sure fen',
                              btnOkText: 'Sure fen',
                              btnCancelText: '',
                              onYesCb: () =>
                                  context.read<SettingCubit>().logOut(),
                              onCancelCb: null),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
