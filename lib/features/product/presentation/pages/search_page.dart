import 'package:flutter/material.dart';

import '../../../../core/font_icon/icon_broken.dart';
import '../../../../core/localization/get_os.dart';
import '../../../../core/widget/adaptive/adaptive_text_field.dart';
import '../widgets/search_page/list_products.dart';

TextEditingController searchController = TextEditingController();

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searchTextFiled(),
             const SizedBox(height: 20,),
              ListProducts(
                searchController: searchController,
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _searchTextFiled() {
    return  AdaptiveTextField(
      os: getOs(),
      inputBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),),
      controller: searchController,
      prefix: IconBroken.Search,
      onSubmit: (_){
        setState(() {

        });
      },
    );
 }
}
