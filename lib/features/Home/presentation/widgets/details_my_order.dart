import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../login/presentation/widgets/build_widget_text_field.dart';
import '../../business logic/cubit/cubit/add_myorder_cubit.dart';
import '../../business logic/cubit/cubit/edit_myorder_cubit.dart';
import '../../data/models/orders_model.dart';
import 'build_add_order_cubit_widget.dart';

class DetailsMyOrder extends StatefulWidget {
  final int itemId;
  final OrdersModel? order;
  final bool isEdit;
  const DetailsMyOrder({
    super.key,
    required this.itemId,
    this.order,
    this.isEdit = false,
  });

  @override
  State<DetailsMyOrder> createState() => _DetailsMyOrderState();
}

class _DetailsMyOrderState extends State<DetailsMyOrder> {
  double currentValue = 0;
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.order != null) {
      currentValue = widget.order!.numberOfSugarSpoons?.toDouble() ?? 0;
      roomNumberController.text = widget.order!.room ?? "";
      notesController.text = widget.order!.orderNotes ?? "";
      isButtonActive = roomNumberController.text.isNotEmpty;
    }

    roomNumberController.addListener(_checkIfFilled);
  }

  @override
  void dispose() {
    roomNumberController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void _checkIfFilled() {
    final isFilled = roomNumberController.text.isNotEmpty;
    if (isFilled != isButtonActive) {
      setState(() => isButtonActive = isFilled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEdit;
    logger.d(isEdit);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("مستوى السكر", style: TextStyleManager.font15Bold),
              Text(
                "${currentValue.toStringAsFixed(1)} ملعقة",
                style: TextStyleManager.font15Bold.copyWith(
                  color: ColorManager.orangeColor,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 20,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              min: 0,
              max: 5,
              activeColor: Colors.orange,
              thumbColor: Colors.white,
              value: currentValue,
              onChanged: (value) {
                double rounded = (value * 2).round() / 2;
                setState(() => currentValue = rounded);
              },
            ),
          ),

          SizedBox(height: 20.h),
          Text("رقم الغرفة", style: TextStyleManager.font20Bold),
          buildWidgetTextFormField(
            hintText: "أدخل رقم الغرفة",
            controller: roomNumberController,
          ),

          SizedBox(height: 20.h),
          Text("ملاحظات خاصة (اختياري)", style: TextStyleManager.font20Bold),
          buildWidgetTextFormField(
            hintText: "هل لديك أي طلبات خاصة؟",
            controller: notesController,
            maxLines: 3,
          ),
          SizedBox(height: 20.h),

          BuildAddOrderCubitWidget(
            itemId: widget.itemId,
            isEdit: isEdit,
            child: (bool isLoading, providerContext) {
              return addOrEditButton(isLoading, providerContext, isEdit);
            },
          ),
        ],
      ),
    );
  }

  Widget addOrEditButton(bool isLoading, BuildContext context, bool isEdit) {
    return InkWell(
      onTap: isButtonActive && !isLoading
          ? () {
              if (isEdit && widget.order != null) {
                context.read<EditMyOrderCubit>().editOrder(
                  orderId: widget.order!.id!,
                  room: roomNumberController.text,
                  numberOfSugarSpoons: currentValue.toInt(),
                  notes: notesController.text,
                  itemId: widget.order!.itemId!,
                );
              } else {
                context.read<AddMyOrderCubit>().addOrder(
                  currentValue.toInt(),
                  roomNumberController.text,
                  notesController.text,
                  widget.itemId,
                );
              }
            }
          : null,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: isButtonActive && !isLoading
                ? [Colors.orange, Colors.yellow]
                : [
                    Colors.orange.withOpacity(.5),
                    Colors.yellow.withOpacity(.5),
                  ],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    SizedBox(width: 10.w),
                    Text(
                      isEdit ? "جاري تحديث الطلب..." : "جاري تنفيذ الطلب...",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                )
              : Text(
                  isEdit ? "تحديث الطلب" : "إرسال الطلب",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }
}
