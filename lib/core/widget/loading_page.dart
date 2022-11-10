import 'package:flutter/material.dart';

import '../localization/get_os.dart';
import 'adaptive/adaptive_indicator.dart';

Widget loadingPage() {
  return Center(
    child: AdaptiveIndicator(
      os: getOs(),
    ),
  );
}