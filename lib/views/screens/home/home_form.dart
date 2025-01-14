import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';


class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  int _counter = 0;

  void _decrementCounter() => setState(() => _counter--);

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_bar.title')),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(translate('language.selected_message', args: {'language': translate('language.name.${localizationDelegate.currentLocale.languageCode}')})),
            Padding(
                padding: EdgeInsets.only(top: 25, bottom: 160),
                child: CupertinoButton.filled(
                  child: Text(translate('button.change_language')),
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 36.0),
                  onPressed: () => _onActionSheetPress(context),
                )
            ),

            Padding(padding: const EdgeInsets.only(bottom: 10),
                child: Text(translatePlural('plural.demo', _counter))
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  iconSize: 48,
                  onPressed: _counter > 0 ? () => setState(() => _decrementCounter()) : null,
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
      ),
    );
  }

  void showDemoActionSheet({required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value)
    {
      if(value != null)
        changeLocale(context, value);
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
