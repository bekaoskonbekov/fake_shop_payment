import 'package:fake_shop/features/product/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/font_icon/icon_broken.dart';
import '../../../../core/routing/navigate_to.dart';
import '../../../../core/var.dart';
import '../../../auth/presentation/cubit/user_cubit.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../cubit/product_cubit.dart';
import '../widgets/home_page_widgets/center_body.dart';
import '../widgets/home_page_widgets/title_body.dart';
import '../widgets/home_page_widgets/title_popular.dart';

Color textColor = Colors.black;
Color backgroundColor = Colors.white;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetAllProductsSuccessState ||
              state is GetAllCategoriesSuccessState ||
              state is ChangeCategory) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleBody(),
                  CenterBody(
                    context: context,
                  ),
                  const TitlePopular(),
                  productsList(
                      category: categoryItems,
                      context: context,
                      products: products),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  dynamic _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          IconBroken.Setting,
          color: Colors.black,
        ),
        onPressed: () {
          UserCubit.get(context).logOutCubit();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            IconBroken.Search,
            color: Colors.black,
          ),
          onPressed: () {
            navigateTo(context, const SearchPage());
          },
        ),
        IconButton(
          icon: const Icon(
            IconBroken.Bag,
            color: Colors.black,
          ),
          onPressed: () {
            navigateTo(context, const CartPage());
          },
        ),
      ],
    );
  }
}
