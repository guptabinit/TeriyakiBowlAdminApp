import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/order_detail_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../resources/firestore_methods.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';

class OrderTile extends StatefulWidget {
  final snap;

  const OrderTile({super.key, required this.snap});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {

  String orderStatus() {
    if(widget.snap['order_status'] == 0){
      return "In Process";
    } else if (widget.snap['order_status'] == 1){
      return "Completed";
    }
    return "Cancelled";
  }
  Color colorStatus() {
    if(widget.snap['order_status'] == 0){
      return redColor;
    } else if (widget.snap['order_status'] == 1){
      return greenColor;
    }
    return redColor;
  }


  // showingSnackbar(String msg){
  //   return showSnackBar(msg, context);
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailScreen(snap: widget.snap,));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: lightColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(1, 1),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.snap['read'] ? "Read" : "Unread",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: widget.snap['read'] ? greenColor : redColor,
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        " • ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        orderStatus(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colorStatus(),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  Text(
                    "Order No #${widget.snap['oid']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: darkColor,
                      fontSize: 20,
                    ),
                  ),
                  8.heightBox,
                  Text(
                    "Name: ${widget.snap['name']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkTextGreyColor,
                      fontSize: 16,
                    ),
                  ),
                  4.heightBox,
                  Text(
                    "Mode: ${widget.snap['is_pickup'] ? "Pickup" : "Delivery"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkTextGreyColor,
                      fontSize: 16,
                    ),
                  ),
                  4.heightBox,
                  Row(
                    children: [
                      Text(
                       "\$ ${widget.snap['order_total'].toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: darkColor,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        " • ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Total Items: ${widget.snap['cart']['items'].length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: darkTextGreyColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  Text(
                    "Order Time: ${widget.snap['order_time']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkTextGreyColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: darkColor,)
          ],
        ),
      ),
    );
  }
}
