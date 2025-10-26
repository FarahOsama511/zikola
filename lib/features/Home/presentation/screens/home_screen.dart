import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';
import 'package:zikola/features/Home/business%20logic/cubit/item_cubit.dart';
import 'package:zikola/features/login/presentation/widgets/build_widget_text_field.dart';
import '../widgets/build_items_bloc_widget.dart';
import '../widgets/categories_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> allItems = [
    "Espresso",
    "Cappuccino",
    "Latte",
    "Americano",
    "Mocha",
  ];
  List<String> searchedItem = [];
  searchFunction(String keyWord) {
    setState(() {
      searchedItem = allItems
          .where((item) => item.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    BlocProvider.of<ItemCubit>(context).getAllItems();
    searchedItem = allItems;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning! ☕", style: TextStyleManager.font20Bold),
              Text(
                "What would you like today?",
                style: TextStyleManager.font20RegularGrey,
              ),
              SizedBox(height: 20.h),
              buildWidgetTextFormField(
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: ColorManager.greyColor,
                ),
                hintText: "Search drinks ...",
                controller: _searchController,
                onChanged: (value) => searchFunction(value),
              ),
              SizedBox(height: 20.h),
              CategoriesWidget(),
              SizedBox(height: 20.h),
              Divider(color: ColorManager.lightGrey),
              SizedBox(height: 20.h),
              BuildItemsBlocWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
