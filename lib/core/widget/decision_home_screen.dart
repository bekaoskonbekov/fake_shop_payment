import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/product/presentation/pages/home_page.dart';
import '../dio/cache_helper.dart';
import '../dio/dio_helper.dart';
import '../dio/end_points.dart';
import '../strings/app_string.dart';
import '../var.dart';

void decisionHomeScreen() async {
  AppString.userToken = CacheHelper.getData(key: 'uId');
  print("user token is ${AppString.userToken}");
  if (AppString.userToken != null) {
    home = const HomePage();
  } else {
    //await DioHelper.init(baseUrlAuth);
    // home =  LoginScreen();
    home = const HomePage();
  }
}
