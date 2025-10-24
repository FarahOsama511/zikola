import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';
import 'package:zikola/features/login/presentation/widgets/build_widget_text_field.dart';

import '../../../../main.dart';

class DetailsMyOrder extends StatefulWidget {
  const DetailsMyOrder({super.key});

  @override
  State<DetailsMyOrder> createState() => _DetailsMyOrderState();
}

double currentValue = 0;
TextEditingController roomNumberController = TextEditingController();
TextEditingController notesController = TextEditingController();
bool isButtonActive = false;

class _DetailsMyOrderState extends State<DetailsMyOrder> {
  @override
  void initState() {
    super.initState();
    roomNumberController.addListener(_checkIfFilled);
  }

  @override
  void dispose() {
    super.dispose();
    roomNumberController.dispose();
  }

  void _checkIfFilled() {
    final isFilled = roomNumberController.text.isNotEmpty;
    if (isFilled != isButtonActive) {
      setState(() {
        isButtonActive = isFilled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sugar Level", style: TextStyleManager.font15Bold),
            Text(
              "${currentValue.toStringAsFixed(1)} Spoons",
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
              setState(() {
                currentValue = rounded;
              });
            },
          ),
        ),
        SizedBox(height: 20.h),
        Text("Room Number", style: TextStyleManager.font20Bold),
        BuildWidgetTextFormField(
          hintText: "room number",
          controller: roomNumberController,
        ),
        SizedBox(height: 20.h),
        Text("Special notes (Optional)", style: TextStyleManager.font20Bold),
        BuildWidgetTextFormField(
          hintText: "Any Special Requstes?",
          controller: notesController,
          maxLines: 3,
        ),
        SizedBox(height: 20.h),
        InkWell(
          onTap: isButtonActive
              ? () {
                  logger.d("=========");
                }
              : null,
          child: Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.center,
                end: AlignmentGeometry.centerRight,
                colors: isButtonActive
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
            child: Text(
              "Submit Order",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
