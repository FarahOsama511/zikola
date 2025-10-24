import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../widgets/status_order_widget.dart';

class StatusOrderScreen extends StatefulWidget {
  const StatusOrderScreen({super.key});
  @override
  State<StatusOrderScreen> createState() => _StatusOrderState();
}

class _StatusOrderState extends State<StatusOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Status ", style: TextStyleManager.font24Bold),
              Text(
                "Track your coffee orders",
                style: TextStyleManager.font20RegularGrey,
              ),
              Divider(),
              SizedBox(height: 20.h),
              StatusOrderWidget(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
