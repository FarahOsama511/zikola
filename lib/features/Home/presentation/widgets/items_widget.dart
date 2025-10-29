import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/core/constants/strings.dart';
import 'package:zikola/core/routing/approutes.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/features/Home/data/models/item_model.dart';

class ItemsWidget extends StatefulWidget {
  List<ItemModel> item = [];
  ItemsWidget({super.key, required this.item});
  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  bool isfavorite = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.item.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          childAspectRatio: 2 / 3.5,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
        ),

        itemBuilder: (context, index) {
          final item = widget.item[index];
          return InkWell(
            onTap: () {
              context.go(AppRoutes.addOrder, extra: {"item": item});
              logger.d(item);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ColorManager.lightGrey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20.r),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: Image.network(
                              item.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isfavorite = !isfavorite;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: ColorManager.lightGrey,
                                child: Icon(
                                  isfavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isfavorite
                                      ? ColorManager.orangeColor
                                      : ColorManager.greyColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "${item.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
