import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/edit_item_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/components/button.dart';
import '../../utils/colors.dart';

class ItemDetailScreen extends StatefulWidget {
  final dynamic snap;

  const ItemDetailScreen({super.key, required this.snap});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool isLoading = false;

  TextEditingController specialInstruction = TextEditingController();

  String? selectedQuantity;
  double selectedQuantityPrice = 0.00;

  String? selectedVarient;
  double selectedVarientPrice = 0.00;

  List<bool?> selectedAddOn = [];

  List<bool?> selectedRemoval = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.snap['qty_avail']) {
        selectedQuantity = widget.snap['quantity'][0]['quantity'];
        selectedQuantityPrice =
            widget.snap['quantity'][0]['quantityPrice'].toDouble();
      }
      if (widget.snap['varient_avail']) {
        selectedVarient = widget.snap['varients'][0]['varientName'];
        selectedQuantityPrice =
            widget.snap['varients'][0]['varientPrice'].toDouble();
      }
      if (widget.snap['addon_avail']) {
        for (int i = 0; i < widget.snap['addons'].length; i++) {
          selectedAddOn.add(false);
        }
      }
      if (widget.snap['removal_avail']) {
        for (int i = 0; i < widget.snap['removals'].length; i++) {
          selectedRemoval.add(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        backgroundColor: primaryColor,
        title: Text(
          '${widget.snap['item_name']}'.allWordsCapitilize(),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: lightColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: lightColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final itemId = widget.snap['iid'] as int?;
              if (itemId != null) {
                Get.to(
                  () => EditItemScreen(
                    itemId: itemId,
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: widget.snap['item_image'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
                12.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(0, 1),
                            blurRadius: 1,
                            spreadRadius: 2,
                          )
                        ]),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.snap['item_name']}'
                                    .allWordsCapitilize(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              '\$${widget.snap['item_price']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.snap['item_sub_category']}'
                                    .allWordsCapitilize(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: textDarkColor,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.access_time,
                              color: primaryColor,
                            ),
                            4.widthBox,
                            Text(
                              '${widget.snap['prep_time']} mnt',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                12.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(0, 1),
                            blurRadius: 1,
                            spreadRadius: 2,
                          )
                        ]),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail & Ingredients',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        8.heightBox,
                        Text(
                          '${widget.snap['item_description']}'
                              .allWordsCapitilize(),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                // Quantity -- if any
                widget.snap['qty_avail'] ? 12.heightBox : Container(),
                widget.snap['qty_avail']
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: lightColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                )
                              ]),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choose your Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.snap['quantity'].length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  var docSnap = widget.snap['quantity'][index];

                                  return RadioListTile<String>(
                                    title: Text(docSnap['quantity']),
                                    subtitle: Text(
                                        'Price: +\$ ${docSnap['quantityPrice'].toDouble().toStringAsFixed(2)}'),
                                    value: docSnap['quantity'],
                                    groupValue: selectedQuantity,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedQuantity = value;
                                        selectedQuantityPrice =
                                            docSnap['quantityPrice'].toDouble();
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),

                // varient -- if any
                widget.snap['varient_avail'] ? 12.heightBox : Container(),
                widget.snap['varient_avail']
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: lightColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                )
                              ]),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choose your Varient',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.snap['varients'].length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  var docSnap = widget.snap['varients'][index];

                                  return RadioListTile<String>(
                                    title: Text(docSnap['varientName']),
                                    subtitle: Text(
                                        'Price: +\$ ${docSnap['varientPrice'].toDouble().toStringAsFixed(2)}'),
                                    value: docSnap['varientName'],
                                    groupValue: selectedVarient,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedVarient = value;
                                        selectedVarientPrice =
                                            docSnap['varientPrice'].toDouble();
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                // add-ons -- if any
                widget.snap['addon_avail'] ? 12.heightBox : Container(),
                widget.snap['addon_avail']
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: lightColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                )
                              ]),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choose your Add-On',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.snap['addons'].length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  var docSnap = widget.snap['addons'][index];

                                  return CheckboxListTile(
                                    title: Text(docSnap['addonName']),
                                    subtitle: Text(
                                        'Price : +\$ ${docSnap['addonPrice'].toDouble().toStringAsFixed(2)}'),
                                    value: selectedAddOn[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        selectedAddOn[index] = value;
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                // removal -- if any
                widget.snap['removal_avail'] ? 12.heightBox : Container(),
                widget.snap['removal_avail']
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: lightColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                )
                              ]),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Do you want to remove?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.snap['removals'].length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  var docSnap = widget.snap['removals'][index];

                                  return CheckboxListTile(
                                    title: Text(docSnap['removalname']),
                                    value: selectedRemoval[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        selectedRemoval[index] = value;
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),

                12.heightBox,
                Container(
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(0, 1),
                        blurRadius: 1,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),
                72.heightBox,
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(btnText: 'Add to Cart', onTap: () {}),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showDialog({
    required String message,
    VoidCallback? onOk,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: lightColor),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Teriyaki Bowl',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              12.heightBox,
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              16.heightBox,
              CustomButton(
                btnText: 'Ok',
                onTap: () {
                  Navigator.of(context).pop('OK');
                  if (onOk != null) onOk();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
