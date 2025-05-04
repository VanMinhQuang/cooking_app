import 'package:cooking_project/data/model/user.dart';
import 'package:get_it/get_it.dart';

class General{
  General._();

  static LocalUser? get user =>
      GetIt.instance.isRegistered<LocalUser>() ? GetIt.instance<LocalUser>() : null;
}