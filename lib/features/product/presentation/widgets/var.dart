import 'package:fake_shop/features/product/presentation/widgets/product_page_widgets/chose_color.dart';
import 'package:fake_shop/features/product/presentation/widgets/product_page_widgets/chose_size.dart';

String? color;
String? size;
List<bool> booleanColorList =
    List<bool>.generate(colorList.length, (int index) => false, growable: true);
final booleanSizeList =
    List<bool>.generate(sizeList.length, (int index) => false, growable: true);
