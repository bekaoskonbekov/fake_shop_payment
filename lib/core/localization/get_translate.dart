//function get current text from key
import 'package:flutter/material.dart';

import 'app_local.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocale.of(context).getTranslate(key);
}
