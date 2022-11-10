import 'package:fake_shop/features/product/presentation/widgets/home_page_widgets/product_item.dart';
import 'package:flutter/material.dart';
import '../../../../../core/var.dart';
import '../../../domain/entities/product.dart';

final choseCategory = List<bool>.generate(
    categories.length, (int index) => false,
    growable: true);

class CenterBody extends StatefulWidget {
  final BuildContext context;
  const CenterBody({Key? key, required this.context}) : super(key: key);

  @override
  State<CenterBody> createState() => _CenterBodyState();
}

class _CenterBodyState extends State<CenterBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        categoriesList(),
        productsList(
            category: categoryItems, context: context, products: products),
      ],
    );
  }

  Widget categoriesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                //ProductCubit.get(context).emit(ChangeCategory());
                setState(() {
                  categoryItems = categories[index];
                  var temp = choseCategory.map((c) => false).toList();
                  choseCategory.replaceRange(0, choseCategory.length, temp);
                  choseCategory[index] = true;
                });
              },
              child: Container(
                height: 20,
                width: 160,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: choseCategory[index] == true
                      ? Colors.black87
                      : Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.7,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Text(
                  categories[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: choseCategory[index] == true
                          ? Colors.white
                          : Colors.black87),
                )),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 15,
          ),
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

Widget productsList(
    {required List<Product> products,
    required BuildContext context,
    required String category}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
    child: SizedBox(
      height: 400,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (category == "All") {
            return ProductItem(product: products[index]);
          }
          if (products[index].category == category) {
            return ProductItem(product: products[index]);
          }
          return Container();
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
      ),
    ),
  );
}
