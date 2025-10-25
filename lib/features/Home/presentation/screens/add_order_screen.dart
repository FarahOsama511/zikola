import 'package:flutter/material.dart';
import 'package:zikola/features/Home/data/models/item_model.dart';
import 'package:zikola/features/Home/presentation/widgets/build_add_order_cubit_widget.dart';
class AddOrder extends StatefulWidget {
  final ItemModel item;
  AddOrder({super.key,required this.item});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  double currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  Text("Place Order", style: TextStyle(fontSize: 30)),
                ],
              ),
              Divider(),
              SizedBox(height: 20),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 150,
                          width: 120,
                          child: Image.network(
                            widget.item.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "${widget.item.name}",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
              buildAddOrderCubitWidget(widget.item.id??1),
            ],
          ),
        ),
      ),
    );
  }
}
