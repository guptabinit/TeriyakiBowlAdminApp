import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/colors.dart';

class OrderTile extends StatefulWidget {
  final snap;

  const OrderTile({super.key, required this.snap});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  "Order Number: ",
                  style: TextStyle(fontSize: 16, color: darkColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.snap['oid'],
                  style: const TextStyle(fontSize: 16, color: darkColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            6.heightBox,
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Name: ",
                      style: TextStyle(fontSize: 14, color: darkColor),
                    ),
                    Text(
                      widget.snap['name'],
                      style: const TextStyle(fontSize: 14, color: darkColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Mobile: ",
                      style: TextStyle(fontSize: 14, color: darkColor),
                    ),
                    Text(
                      widget.snap['mobile'],
                      style: const TextStyle(fontSize: 14, color: darkColor),
                    ),
                  ],
                ),
              ],
            ),
            8.heightBox,
            Row(
              children: [
                const Text(
                  "Email Address: ",
                  style: TextStyle(fontSize: 14, color: darkColor),
                ),
                Text(
                  widget.snap['email'],
                  style: const TextStyle(fontSize: 14, color: darkColor),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Order Info",
                  style: TextStyle(fontSize: 16, color: darkColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            8.heightBox,
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.snap['cart']['items'].length,
              itemBuilder: (BuildContext context, index) {
                var itemSnap = widget.snap['cart'][widget.snap['cart']['items'][index]];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: darkColor,
                          ),
                        ),
                        Text(
                          ". ${itemSnap['item_name']} -",
                          style: const TextStyle(
                            fontSize: 14,
                            color: darkColor,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textDarkColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: ' ${itemSnap['item_price'].toStringAsFixed(2)} x ${itemSnap['quantity']}'),
                                TextSpan(
                                  text: ' = ${itemSnap['total_price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    4.heightBox,
                  ],
                );
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                const Text(
                  "Coupon Code: ",
                  style: TextStyle(
                    fontSize: 14,
                    color: darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.snap['coupon_code'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: darkColor,
                  ),
                ),
                Text(
                  " (Discount: ${widget.snap['discount']}%)",
                  style: const TextStyle(
                    fontSize: 14,
                    color: darkColor,
                  ),
                ),
              ],
            ),
            6.heightBox,
            Row(
              children: [
                const Text(
                  "Total Order Amount: ",
                  style: TextStyle(
                    fontSize: 14,
                    color: darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  color: Colors.yellowAccent,
                  child: Text(
                    "\$${widget.snap['order_total'].toStringAsFixed(2)}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                const Text(
                  "Email Address: ",
                  style: TextStyle(fontSize: 14, color: darkColor),
                ),
                Text(
                  widget.snap['email'],
                  style: const TextStyle(fontSize: 14, color: darkColor),
                ),
              ],
            ),
            6.heightBox,
            Row(
              children: [
                const Text(
                  "Email Address: ",
                  style: TextStyle(fontSize: 14, color: darkColor),
                ),
                Text(
                  widget.snap['email'],
                  style: const TextStyle(fontSize: 14, color: darkColor),
                ),
              ],
            ),
            8.heightBox,
            Row(
              children: [
                const Text(
                  "Date & Time: ",
                  style: TextStyle(fontSize: 13, color: textDarkColor),
                ),
                Text(
                  widget.snap['order_time'],
                  style: const TextStyle(fontSize: 13, color: textDarkColor),
                ),
              ],
            ),
          ],
        ));
  }
}
