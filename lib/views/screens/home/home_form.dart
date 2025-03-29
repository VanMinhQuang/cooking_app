import 'package:cooking_project/views/screens/home/home_cubit.dart';
import 'package:cooking_project/views/screens/home/home_screen.dart';
import 'package:cooking_project/views/screens/home/home_state.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_screen.dart';
import 'package:cooking_project/views/screens/setting/setting_screen.dart';
import 'package:cooking_project/views/widgets/bar/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  int _counter = 0;

  int selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _decrementCounter() => setState(() => _counter--);

  void _incrementCounter() => setState(() => _counter++);
  final List<Widget> _listWidget = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listWidget
        .addAll([widget1(), MainMenuSearchingScreen(), SettingScreen()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: CustomNavigationBar(
          onTapChange: (index) {
            context.read<HomeCubit>().changePageIndex(index);
          },
        ),
        body: SafeArea(
          child: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is ChangeIndexBottomBarState) {
                if (selectedIndex != state.index) {

                    selectedIndex = state.index;


                }
              }
            },

            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (BuildContext context, state) {
                return IndexedStack(
                  index: selectedIndex,
                  children: _listWidget,
                );
              },
            ),
          ),
        ));
  }

  Widget widget1() {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(translate('language.selected_message', args: {
            'language': translate(
                'language.name.${localizationDelegate.currentLocale.languageCode}')
          })),
          Padding(
              padding: EdgeInsets.only(top: 25, bottom: 160),
              child: CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 36.0),
                onPressed: () => _onActionSheetPress(context),
                child: Text(translate('button.change_language')),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(translatePlural('plural.demo', _counter))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove_circle),
                iconSize: 48,
                onPressed: _counter > 0
                    ? () => setState(() => _decrementCounter())
                    : null,
              ),
              IconButton(
                icon: Icon(Icons.add_circle),
                color: Colors.blue,
                iconSize: 48,
                onPressed: () => setState(() => _incrementCounter()),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showDemoActionSheet(
      {required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value) {
      if (value != null) changeLocale(context, value);
    });
  }

  void _onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate('language.selection.title')),
        message: Text(translate('language.selection.message')),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(translate('language.name.en')),
            onPressed: () => Navigator.pop(context, 'en_US'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.vi')),
            onPressed: () => Navigator.pop(context, 'vi'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(translate('button.cancel')),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
    );
  }
}
