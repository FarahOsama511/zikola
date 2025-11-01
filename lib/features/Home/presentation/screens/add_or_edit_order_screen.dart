import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routing/approutes.dart';
import '../../data/models/item_model.dart';
import '../../data/models/orders_model.dart';
import '../widgets/details_my_order.dart';

// ignore: must_be_immutable
class AddorEditOrderScreen extends StatefulWidget {
  final ItemModel? item;
  final OrdersModel? order;
  final bool isEdit;

  const AddorEditOrderScreen({
    super.key,
    this.item,
    this.order,
    this.isEdit = false,
  });

  @override
  State<AddorEditOrderScreen> createState() => _AddorEditOrderScreenState();
}

class _AddorEditOrderScreenState extends State<AddorEditOrderScreen> {
  double numberOfSugar = 0;
  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.isEdit;
    final item = widget.item;
    final order = widget.order;

    final imageUrl = isEdit
        ? order?.item?.imageUrl ?? ''
        : item?.imageUrl ?? '';
    final name = isEdit ? order?.item?.name ?? '' : item?.name ?? '';
    logger.d(isEdit);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.go(AppRoutes.userHome);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    isEdit ? "تعديل الأوردر" : "طلب أوردر",
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),

              const Divider(),
              const SizedBox(height: 20),

              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 25,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 150,
                          width: 120,
                          child: imageUrl.isNotEmpty
                              ? Image.network(imageUrl, fit: BoxFit.cover)
                              : const Icon(Icons.image_not_supported, size: 80),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          name.isNotEmpty ? name : "اسم غير متوفر",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              DetailsMyOrder(
                itemId: isEdit ? order?.item?.id ?? 0 : item?.id ?? 0,
                order: order,
                isEdit: isEdit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
