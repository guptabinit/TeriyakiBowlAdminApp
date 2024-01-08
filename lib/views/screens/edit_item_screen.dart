import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teriyaki_bowl_admin_app/common/components/button.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/text_field.dart';
import 'package:teriyaki_bowl_admin_app/models/item.dart';
import 'package:teriyaki_bowl_admin_app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class EditItemScreen extends StatefulWidget {
  const EditItemScreen({
    super.key,
    required this.itemId,
  });

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();

  final int itemId;
}

class _EditItemScreenState extends State<EditItemScreen> {
  bool isUpdating = false;
  bool isUpdated = true;
  bool isUpdateFailed = false;
  String? updateErrorMessage;

  XFile? selectedImage;

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController subCategoryController;
  late TextEditingController prepTimeController;
  late TextEditingController totalOrderController;

  var isLoading = true;
  var isError = false;
  String? errorMessage;
  Item? item;

  var isVarientAvailable = false;
  late List<Varient?> varients;

  var isAddonsAvailable = false;
  late List<Addon?> addons;

  var isRemovalsAvailable = false;
  late List<Removal?> removals;

  var isQuantityAvailable = false;
  late List<Quantity?> quantities;

  @override
  void initState() {
    varients = [];
    addons = [];
    removals = [];
    quantities = [];
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    subCategoryController = TextEditingController();
    prepTimeController = TextEditingController();
    totalOrderController = TextEditingController();

    loadItemData(widget.itemId);

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    subCategoryController.dispose();
    prepTimeController.dispose();
    totalOrderController.dispose();

    super.dispose();
  }

  Future<void> _updateItem() async {
    isUpdating = true;
    isUpdated = false;
    isUpdateFailed = false;
    updateErrorMessage = null;
    setState(() {});
    try {
      final data = <String, dynamic>{
        'item_description': descriptionController.text,
        'item_name': nameController.text,
        'item_price': double.tryParse(priceController.text) ?? 0,
        'item_sub_category': subCategoryController.text,
        'prep_time': double.tryParse(prepTimeController.text) ?? 0,
        'total_order': double.tryParse(totalOrderController.text) ?? 0,
      };

      if (isQuantityAvailable) {
        data['qty_avail'] = true;
        data['quantity'] = quantities
            .map((e) => ({
                  'quantity': e?.quantity ?? '',
                  'quantityPrice': e?.quantityPrice ?? 0,
                }))
            .toList();
      } else {
        data['qty_avail'] = false;
        data['quantity'] = [];
      }

      if (isRemovalsAvailable) {
        data['removal_avail'] = true;
        data['removals'] = removals
            .map((e) => ({
                  'removalname': e?.removalName ?? '',
                }))
            .toList();
      } else {
        data['removal_avail'] = false;
        data['removals'] = [];
      }

      if (isAddonsAvailable) {
        data['addon_avail'] = true;
        data['addons'] = addons
            .map((e) => ({
                  'addonName': e?.addonName ?? '',
                  'addonPrice': e?.addonPrice ?? 0,
                }))
            .toList();
      } else {
        data['addon_avail'] = false;
        data['addons'] = [];
      }

      if (isVarientAvailable) {
        data['varient_avail'] = true;
        data['varients'] = varients
            .map((e) => ({
                  'varientName': e?.varientName ?? '',
                  'varientPrice': e?.varientPrice ?? 0,
                }))
            .toList();
      } else {
        data['varient_avail'] = false;
        data['varients'] = [];
      }

      if (selectedImage != null) {
        final storageRef = FirebaseStorage.instance.ref();

        final itemImageRef = storageRef.child('items/${selectedImage!.name}');

        final itemImage = await itemImageRef.putFile(
          File(selectedImage!.path),
          SettableMetadata(
            contentType: selectedImage!.mimeType,
          ),
        );

        final itemImageUrl = await itemImage.ref.getDownloadURL();

        data['item_image'] = itemImageUrl;
      }

      await FirebaseFirestore.instance
          .collection('items')
          .doc('${widget.itemId}')
          .update(data);

      isUpdating = false;
      isUpdated = true;
      isUpdateFailed = false;
      updateErrorMessage = null;
      setState(() {});
    } catch (e) {
      isUpdating = false;
      isUpdated = false;
      isUpdateFailed = true;
      updateErrorMessage = 'Something went wrong!';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLoading ? '' : item?.itemName ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLoading) ...[
                const SizedBox(height: 20),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
              if (isError) ...[
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    errorMessage ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
              if (item != null && !isLoading && !isError) ...[
                20.heightBox,
                AspectRatio(
                  aspectRatio: 13 / 8,
                  child: selectedImage != null
                      ? Image.file(File(selectedImage!.path))
                      : Image.network(
                          '${item?.itemImage}',
                          isAntiAlias: true,
                          fit: BoxFit.cover,
                        ),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () async {
                    final picker = ImagePicker();
                    final file = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (file == null) return;
                    selectedImage = file;
                    setState(() {});
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Choose Image'),
                ),
                20.heightBox,
                Text(
                  'Item Name',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
                6.heightBox,
                CustomTextField(
                  controller: nameController,
                  labelText: 'Item Name',
                ),
                20.heightBox,
                Text(
                  'Item Description',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
                6.heightBox,
                CustomTextField(
                  controller: descriptionController,
                  labelText: 'Item Description',
                  maxLines: 3,
                ),
                20.heightBox,
                Text(
                  'Price',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
                6.heightBox,
                CustomTextField(
                  controller: priceController,
                  labelText: 'Price',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                ),
                20.heightBox,
                Text(
                  'Sub Category',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
                6.heightBox,
                CustomTextField(
                  controller: subCategoryController,
                  labelText: 'Sub Category',
                ),
                20.heightBox,
                Text(
                  'Prep Time',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
                6.heightBox,
                CustomTextField(
                  controller: prepTimeController,
                  labelText: 'Prep Time',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                ),
                20.heightBox,
                Text(
                  'Total Order',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
                6.heightBox,
                CustomTextField(
                  controller: totalOrderController,
                  labelText: 'Total Order',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                20.heightBox,
                CheckboxListTile(
                  value: isVarientAvailable,
                  onChanged: (value) {
                    if (value == null) return;
                    isVarientAvailable = value;
                    setState(() {});
                  },
                  title: const Text('Is varient available'),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                if (isVarientAvailable)
                  ItemVarientWidget(
                    varients: varients,
                    onNewVarientPressed: () {
                      setState(() {
                        varients.add(const Varient());
                      });
                    },
                    onVarientRemovePressed: (index) {
                      setState(() {
                        varients.removeAt(index);
                      });
                    },
                  ),
                20.heightBox,
                CheckboxListTile(
                  value: isAddonsAvailable,
                  onChanged: (value) {
                    if (value == null) return;
                    isAddonsAvailable = value;
                    setState(() {});
                  },
                  title: const Text('Is addons available'),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                if (isAddonsAvailable)
                  ItemAddonWidget(
                    addons: addons,
                    onNewAddonPressed: () {
                      setState(() {
                        addons.add(const Addon());
                      });
                    },
                    onAddonRemovePressed: (index) {
                      setState(() {
                        addons.removeAt(index);
                      });
                    },
                  ),
                20.heightBox,
                CheckboxListTile(
                  value: isRemovalsAvailable,
                  onChanged: (value) {
                    if (value == null) return;
                    isRemovalsAvailable = value;
                    setState(() {});
                  },
                  title: const Text('Is removals available'),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                if (isRemovalsAvailable)
                  ItemRemovalWidget(
                    removals: removals,
                    onNewRemovalPressed: () {
                      setState(() {
                        removals.add(const Removal());
                      });
                    },
                    onRemovalRemovePressed: (index) {
                      setState(() {
                        removals.removeAt(index);
                      });
                    },
                  ),
                20.heightBox,
                CheckboxListTile(
                  value: isQuantityAvailable,
                  onChanged: (value) {
                    if (value == null) return;
                    isQuantityAvailable = value;
                    setState(() {});
                  },
                  title: const Text('Is quantity available'),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                if (isQuantityAvailable)
                  ItemQuantityWidget(
                    quantity: quantities,
                    onNewQuantityPressed: () {
                      quantities.add(const Quantity());
                      setState(() {});
                    },
                    onQuantityRemovePressed: (index) {
                      quantities.removeAt(index);
                      setState(() {});
                    },
                  ),
                20.heightBox,
                isUpdating
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        btnText: 'Update',
                        onTap: () async {
                          await _updateItem();
                          if (isUpdated) {
                            Get.back();
                            Get.snackbar(
                              'Updated',
                              'Item updated succeed',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              margin: const EdgeInsets.all(10),
                            );
                          }
                        },
                      ),
                20.heightBox,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadItemData(int id) async {
    isLoading = true;
    isError = false;
    errorMessage = null;
    setState(() {});
    try {
      final doc = await FirebaseFirestore.instance
          .collection(
            'items',
          )
          .doc('$id')
          .get();
      final item = Item.fromJson(doc.data() ?? {});
      this.item = item;
      if (item.varients?.isNotEmpty == true) {
        varients = [...?item.varients];
      }
      if (item.quantity?.isNotEmpty == true) {
        quantities = [...?item.quantity];
      }
      if (item.removals?.isNotEmpty == true) {
        removals = [...?item.removals];
      }
      if (item.addons?.isNotEmpty == true) {
        addons = [...?item.addons];
      }
      nameController.text = item.itemName ?? '';
      descriptionController.text = item.itemDescription ?? '';
      priceController.text = '${item.itemPrice}';
      subCategoryController.text = item.itemSubCategory ?? '';
      prepTimeController.text = '${item.prepTime}';
      totalOrderController.text = '${item.totalOrder}';
      isVarientAvailable = item.varientAvail ?? false;
      isAddonsAvailable = item.addonAvail ?? false;
      isRemovalsAvailable = item.removalAvail ?? false;
      isQuantityAvailable = item.qtyAvail ?? false;
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      errorMessage = e.toString();
      setState(() {});
    }
  }
}

class DynamicVarientItem extends StatelessWidget {
  const DynamicVarientItem({
    super.key,
    required this.index,
    required this.varient,
    required this.onRemovePressed,
  });

  final int index;
  final Varient? varient;
  final void Function()? onRemovePressed;

  @override
  Widget build(BuildContext context) {
    final varientNameController = TextEditingController(
      text: varient?.varientName ?? '',
    );
    final varientPriceController = TextEditingController(
      text: '${varient?.varientPrice ?? ''}',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Varient #${index + 1}'),
                  trailing: IconButton(
                    onPressed: onRemovePressed,
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: varientNameController,
                  labelText: 'Varient name',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                8.heightBox,
                CustomTextField(
                  controller: varientPriceController,
                  labelText: 'Varient price',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                6.heightBox,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemQuantityWidget extends StatelessWidget {
  const ItemQuantityWidget({
    super.key,
    this.quantity = const [],
    required this.onNewQuantityPressed,
    required this.onQuantityRemovePressed,
  });

  final List<Quantity?> quantity;
  final void Function()? onNewQuantityPressed;
  final void Function(int index) onQuantityRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...quantity
            .mapIndexed(
              (e, index) => DynamicQuantityItem(
                quantity: e,
                index: index,
                onRemovePressed: () {
                  onQuantityRemovePressed(index);
                },
              ),
            )
            .toList(),
        TextButton.icon(
          onPressed: onNewQuantityPressed,
          icon: const Icon(Icons.add),
          label: const Text('New Quantity'),
        ),
      ],
    );
  }
}

class DynamicQuantityItem extends StatelessWidget {
  const DynamicQuantityItem({
    super.key,
    this.quantity,
    required this.index,
    required this.onRemovePressed,
  });

  final Quantity? quantity;
  final int index;
  final void Function()? onRemovePressed;

  @override
  Widget build(BuildContext context) {
    final quantityNameController = TextEditingController(
      text: quantity?.quantity ?? '',
    );
    final quantityPriceController = TextEditingController(
      text: '${quantity?.quantityPrice ?? ''}',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Quantity #${index + 1}'),
                  trailing: IconButton(
                    onPressed: onRemovePressed,
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: quantityNameController,
                  labelText: 'Quantity name',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                8.heightBox,
                CustomTextField(
                  controller: quantityPriceController,
                  labelText: 'Quantity price',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                6.heightBox,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemVarientWidget extends StatelessWidget {
  const ItemVarientWidget({
    super.key,
    this.varients = const [],
    required this.onNewVarientPressed,
    required this.onVarientRemovePressed,
  });

  final List<Varient?> varients;
  final void Function()? onNewVarientPressed;
  final void Function(int index) onVarientRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...varients
            .mapIndexed(
              (e, index) => DynamicVarientItem(
                index: index,
                varient: e,
                onRemovePressed: () {
                  onVarientRemovePressed(index);
                },
              ),
            )
            .toList(),
        TextButton.icon(
          onPressed: onNewVarientPressed,
          icon: const Icon(Icons.add),
          label: const Text('New Varient'),
        ),
      ],
    );
  }
}

class DynamicAddonItem extends StatelessWidget {
  const DynamicAddonItem({
    super.key,
    this.addon,
    required this.index,
    required this.onRemovePressed,
  });

  final Addon? addon;
  final int index;
  final void Function()? onRemovePressed;

  @override
  Widget build(BuildContext context) {
    final addonNameController = TextEditingController(
      text: addon?.addonName ?? '',
    );
    final addonPriceController = TextEditingController(
      text: '${addon?.addonPrice ?? ''}',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Addon #${index + 1}'),
                  trailing: IconButton(
                    onPressed: onRemovePressed,
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: addonNameController,
                  labelText: 'Addon name',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                8.heightBox,
                CustomTextField(
                  controller: addonPriceController,
                  labelText: 'Addon price',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                6.heightBox,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemAddonWidget extends StatelessWidget {
  const ItemAddonWidget({
    super.key,
    this.addons = const [],
    required this.onNewAddonPressed,
    required this.onAddonRemovePressed,
  });

  final List<Addon?> addons;
  final void Function()? onNewAddonPressed;
  final void Function(int index) onAddonRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...addons
            .mapIndexed(
              (e, index) => DynamicAddonItem(
                addon: e,
                index: index,
                onRemovePressed: () {
                  onAddonRemovePressed(index);
                },
              ),
            )
            .toList(),
        TextButton.icon(
          onPressed: onNewAddonPressed,
          icon: const Icon(Icons.add),
          label: const Text('New Addon'),
        ),
      ],
    );
  }
}

class DynamicRemovalItem extends StatelessWidget {
  const DynamicRemovalItem({
    super.key,
    this.removal,
    required this.index,
    required this.onRemovePressed,
  });

  final Removal? removal;
  final int index;
  final void Function()? onRemovePressed;

  @override
  Widget build(BuildContext context) {
    final removalNameController = TextEditingController(
      text: removal?.removalName ?? '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Removal #${index + 1}'),
                  trailing: IconButton(
                    onPressed: onRemovePressed,
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: removalNameController,
                  labelText: 'Removal name',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemRemovalWidget extends StatelessWidget {
  const ItemRemovalWidget({
    super.key,
    this.removals = const [],
    required this.onNewRemovalPressed,
    required this.onRemovalRemovePressed,
  });

  final List<Removal?> removals;
  final void Function()? onNewRemovalPressed;
  final void Function(int index) onRemovalRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...removals
            .mapIndexed(
              (e, index) => DynamicRemovalItem(
                removal: e,
                index: index,
                onRemovePressed: () {
                  onRemovalRemovePressed(index);
                },
              ),
            )
            .toList(),
        TextButton.icon(
          onPressed: onNewRemovalPressed,
          icon: const Icon(Icons.add),
          label: const Text('New Removal'),
        ),
      ],
    );
  }
}
