import 'dart:io';

import 'package:flutter/material.dart';

String serverFailureMessage = Platform.localeName.contains("ar")
    ? ' ربما هنالك مشكله في الخادم. الرجاء المحاولة مرة أخرى أو حدث الصفحه'
    : "Maybe there is a problem with the server,please try it again or refresh the page";
String emptyCacheFailureMessage = Platform.localeName.contains("ar")
    ? "لا توجد بيانات بعد ، يرجى إضافة بيانات جديدة"
    : 'No data yet,please add new data';
String offlineFailureMessage = Platform.localeName.contains("ar")
    ? "الرجاء التأكد من اتصالك بالشبكه"
    : 'Please Check your Internet Connection';
