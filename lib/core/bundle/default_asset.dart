import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class TestAssetBundle extends CachingAssetBundle{
  @override
  Future<ByteData> load(String key) async {
    return await rootBundle.load(key);

  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    // TODO: implement loadString
    ByteData data = await  load(key);
    if(data == null) throw FlutterError('Can not load asset');

    return utf8.decode(data.buffer.asInt8List());
  }


  
}