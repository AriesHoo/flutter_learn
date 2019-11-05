import 'package:flutter_learn/view_model/locale_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
List<SingleChildCloneableWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
  ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
];
