import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/colors.dart';

class FixedCartTile extends StatefulWidget {
  final dynamic itemSnap;

  const FixedCartTile({super.key, required this.itemSnap});

  @override
  State<FixedCartTile> createState() => _FixedCartTileState();
}

class _FixedCartTileState extends State<FixedCartTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${widget.itemSnap['item_name']}".allWordsCapitilize(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              8.widthBox,
              Text(
                "${widget.itemSnap['quantity']} x \$${widget.itemSnap['package_price'].toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.widthBox,
              Text(
                "\$${widget.itemSnap['total_price'].toStringAsFixed(2)}",
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Text(
            "with ${widget.itemSnap['selectedQuantity'] != "null" ? "${widget.itemSnap['selectedQuantity']}, " : ""}${widget.itemSnap['selectedVarient'] != "null" ? "${widget.itemSnap['selectedVarient']}, " : ""}${widget.itemSnap['selectedAddon'].length != 0 ? "${widget.itemSnap['selectedAddon']}, " : ""}${widget.itemSnap['selectedRemoval'].length != 0 ? "${widget.itemSnap['selectedRemoval']}" : ""}",
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          widget.itemSnap['specialInstruction'] != "" ? 4.heightBox : Container(),
          widget.itemSnap['specialInstruction'] != "" ? Text(
            "Sp. Instruction: ${widget.itemSnap['specialInstruction']}",
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ) : Container()
        ],
      ),
    );
  }
}
