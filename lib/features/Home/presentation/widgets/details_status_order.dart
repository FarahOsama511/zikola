import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../data/models/orders_model.dart';

class DetailsStatusOrder extends StatefulWidget {
  final String state;
  final Color backgroundColor;
  final Widget statusOrder;
  final List<OrdersModel> myOrders;

  const DetailsStatusOrder({
    super.key,
    required this.state,
    required this.backgroundColor,
    required this.statusOrder,
    required this.myOrders,
  });

  @override
  State<DetailsStatusOrder> createState() => _DetailsStatusOrderState();
}

class _DetailsStatusOrderState extends State<DetailsStatusOrder> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(height: 20.h);
      },
      itemCount: widget.myOrders.length,
      itemBuilder: (context, index) {
        final order = widget.myOrders[index];
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.lightGrey),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: false,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: Image.network(
                      "https://tse3.mm.bing.net/th/id/OIP.XYRdLzXxxNaS_ZWH8QE2eQHaIo?cb=12ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.item?.name ?? "",
                      style: TextStyleManager.font20RegularBlack,
                    ),
                    Container(
                      height: 35.h,
                      width: 85.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: widget.backgroundColor,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.state,
                          style: TextStyleManager.font16BoldWhite.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Room 301", style: TextStyleManager.font15RegularGrey),
                    Text(
                      "${DateFormat('h:mm').format(DateTime.now())} Am  •  2 sugar spoons",
                      style: TextStyleManager.font15RegularGrey,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: widget.statusOrder,
              ),
            ],
          ),
        );
      },
    );
  }
}
