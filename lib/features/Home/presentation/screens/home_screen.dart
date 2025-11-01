import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../login/presentation/widgets/build_widget_text_field.dart';
import '../../business logic/cubit/cubit/item_cubit.dart';
import '../../business logic/cubit/cubit/item_state.dart';
import '../widgets/categories_widget.dart';
import '../widgets/items_widget.dart' show ItemsWidget;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchKeyword = "";

  void searchFunction(String keyWord) {
    setState(() {
      searchKeyword = keyWord.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ItemCubit>(context).getAllItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("صباح الخير! ☕", style: TextStyleManager.font20Bold),
                Text(
                  "ماذا تود أن تطلب اليوم؟",
                  style: TextStyleManager.font20RegularGrey,
                ),
                SizedBox(height: 20.h),
                buildWidgetTextFormField(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: ColorManager.greyColor,
                  ),
                  hintText: "ابحث عن مشروب ...",
                  controller: _searchController,
                  onChanged: searchFunction,
                ),
                SizedBox(height: 20.h),
                CategoriesWidget(),
                SizedBox(height: 20.h),
                Divider(color: ColorManager.lightGrey),
                SizedBox(height: 20.h),
                BlocBuilder<ItemCubit, ItemState>(
                  builder: (context, state) {
                    if (state is ItemLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        ),
                      );
                    } else if (state is ItemSuccess) {
                      final filteredItems = state.items
                          .where(
                            (item) => item.name!.toLowerCase().contains(
                              searchKeyword,
                            ),
                          )
                          .toList();
                      if (filteredItems.isNotEmpty) {
                        return ItemsWidget(item: filteredItems);
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorManager.lightGrey,
                                radius: 30.r,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              Text(
                                "No drinks found",
                                style: TextStyleManager.font15MeduimBlack,
                              ),
                              Text(
                                "Try adjusting your search or filters",
                                style: TextStyleManager.font15RegularGrey,
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (state is ItemError) {
                      return Center(child: Text(state.error.message));
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
