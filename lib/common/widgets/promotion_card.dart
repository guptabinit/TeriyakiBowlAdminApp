import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/colors.dart';

class PromotionalCard extends StatefulWidget {
  final dynamic snap;
  const PromotionalCard({super.key, required this.snap});

  @override
  State<PromotionalCard> createState() => _PromotionalCardState();
}

class _PromotionalCardState extends State<PromotionalCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              height: 200,
              key: UniqueKey(),
              imageUrl: widget.snap['image_link'],
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.snap['title'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                4.heightBox,
                Text(widget.snap['description']),
                8.heightBox,
              ],
            ),
          )
        ],
      ),
    );
  }
}
