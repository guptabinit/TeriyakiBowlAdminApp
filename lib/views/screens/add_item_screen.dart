import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teriyaki_bowl_admin_app/common/components/button.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/text_field.dart';
import 'package:teriyaki_bowl_admin_app/models/category.dart';
import 'package:teriyaki_bowl_admin_app/models/item.dart';
import 'package:teriyaki_bowl_admin_app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({
    super.key,
  });

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
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

  // late TextEditingController totalOrderController;

  Item? item;

  var isVarientAvailable = false;
  late List<Varient?> varients;

  var isAddonsAvailable = false;
  late List<Addon?> addons;

  var isRemovalsAvailable = false;
  late List<Removal?> removals;

  var isQuantityAvailable = false;
  late List<Quantity?> quantities;

  List<String> categories = [];

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
    // totalOrderController = TextEditingController();

    _fetchCategories();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    subCategoryController.dispose();
    prepTimeController.dispose();
    // totalOrderController.dispose();

    super.dispose();
  }

  Future<void> _createItem() async {
    if (descriptionController.text.isEmpty ||
        nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        prepTimeController.text.isEmpty ||
        await File(selectedImage?.path ?? '').exists() == false) {
      Get.snackbar(
        'Fields are required',
        'Please fill all the required fields',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10.0),
      );
      return;
    }

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
        // 'total_order': double.tryParse(totalOrderController.text) ?? 0,
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

      final totalItem = await FirebaseFirestore.instance
          .collection(
            'items',
          )
          .count()
          .get();

      data['iid'] = (totalItem.count ?? 0) + 1;

      await FirebaseFirestore.instance
          .collection('items')
          .doc('${(totalItem.count ?? 0) + 1}')
          .set(data);

      isUpdating = false;
      isUpdated = true;
      isUpdateFailed = false;
      updateErrorMessage = null;

      Get.back();
      Get.snackbar(
        'Created',
        'Item create succeed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(10),
      );

      setState(() {});
    } catch (e) {
      isUpdating = false;
      isUpdated = false;
      isUpdateFailed = true;
      updateErrorMessage = 'Something went wrong!';

      Get.snackbar(
        'Create failed',
        'Item create failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10),
      );

      setState(() {});
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final results = await FirebaseFirestore.instance
          .collection(
            'categories',
          )
          .orderBy(
            'category',
            descending: false,
          )
          .get();
      categories = results.docs
          .map(
            (e) =>
                Category.fromJson(
                  e.data(),
                ).name ??
                '',
          )
          .where((element) => element != 'ALL ITEMS')
          .toList();
    } catch (_) {
      await _fetchCategories();
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new item',
          style: TextStyle(color: Colors.white),
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
              20.heightBox,
              selectedImage != null
                  ? AspectRatio(
                      aspectRatio: 13 / 8,
                      child: Image.file(
                        File(selectedImage!.path),
                      ),
                    )
                  : const SizedBox.shrink(),
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
              DropdownButton(
                isExpanded: true,
                value: categories.contains(subCategoryController.text)
                    ? subCategoryController.text
                    : null,
                items: categories
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  subCategoryController.text = value;
                  setState(() {});
                },
                hint: const Text('Sub Category'),
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
              // 20.heightBox,
              // Text(
              //   'Total Order',
              //   style: Theme.of(
              //     context,
              //   ).textTheme.labelLarge?.copyWith(
              //         fontSize: 16,
              //       ),
              // ),
              // 6.heightBox,
              // CustomTextField(
              //   controller: totalOrderController,
              //   labelText: 'Total Order',
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.digitsOnly,
              //   ],
              // ),
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
                  onUpdateVarientName: (name, index) {
                    final oldValue = varients[index];
                    varients[index] = const Varient().copyWith(
                      varientName: name,
                      varientPrice: oldValue?.varientPrice ?? 0,
                    );
                  },
                  onUpdateVarientPrice: (price, index) {
                    final oldValue = varients[index];
                    varients[index] = const Varient().copyWith(
                      varientName: oldValue?.varientName ?? '',
                      varientPrice: price,
                    );
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
                  onUpdateAddonName: (name, index) {
                    final oldValue = addons[index];
                    addons[index] = const Addon().copyWith(
                      addonName: name,
                      addonPrice: oldValue?.addonPrice ?? 0,
                    );
                  },
                  onUpdateAddonPrice: (price, index) {
                    final oldValue = addons[index];
                    addons[index] = const Addon().copyWith(
                      addonName: oldValue?.addonName ?? '',
                      addonPrice: price,
                    );
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
                  onChanged: (index, value) {
                    removals[index] = const Removal().copyWith(
                      removalName: value,
                    );
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
                  onUpdateQtyName: (String name, int index) {
                    final oldValue = quantities[index];
                    quantities[index] = const Quantity().copyWith(
                      quantity: name,
                      quantityPrice: oldValue?.quantityPrice ?? 0,
                    );
                  },
                  onUpdateQtyPrice: (double price, int index) {
                    final oldValue = quantities[index];
                    quantities[index] = const Quantity().copyWith(
                      quantity: oldValue?.quantity ?? '',
                      quantityPrice: price,
                    );
                  },
                ),
              20.heightBox,
              isUpdating
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      btnText: 'Add',
                      onTap: () async {
                        await _createItem();
                      },
                    ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

class DynamicVarientItem extends StatelessWidget {
  const DynamicVarientItem({
    super.key,
    required this.index,
    required this.varient,
    required this.onRemovePressed,
    required this.onUpdateVarientName,
    required this.onUpdateVarientPrice,
  });

  final int index;
  final Varient? varient;
  final void Function()? onRemovePressed;
  final Function(String name, int index) onUpdateVarientName;
  final Function(double price, int index) onUpdateVarientPrice;

  @override
  Widget build(BuildContext context) {
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
                  // controller: varientNameController,
                  initialValue: varient?.varientName ?? '',
                  labelText: 'Varient name',
                  onChanged: (value) {
                    onUpdateVarientName(value ?? '', index);
                  },
                ),
                8.heightBox,
                CustomTextField(
                  // controller: varientPriceController,
                  initialValue: '${varient?.varientPrice ?? ''}',
                  labelText: 'Varient price',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  onChanged: (value) {
                    onUpdateVarientPrice(
                      double.tryParse(value ?? '') ?? 0,
                      index,
                    );
                  },
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
    required this.onUpdateQtyName,
    required this.onUpdateQtyPrice,
  });

  final List<Quantity?> quantity;
  final void Function()? onNewQuantityPressed;
  final void Function(int index) onQuantityRemovePressed;
  final Function(String name, int index) onUpdateQtyName;
  final Function(double price, int index) onUpdateQtyPrice;

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
                onUpdateQtyName: onUpdateQtyName,
                onUpdateQtyPrice: onUpdateQtyPrice,
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
    required this.onUpdateQtyName,
    required this.onUpdateQtyPrice,
  });

  final Quantity? quantity;
  final int index;
  final void Function()? onRemovePressed;
  final Function(String name, int index) onUpdateQtyName;
  final Function(double price, int index) onUpdateQtyPrice;

  @override
  Widget build(BuildContext context) {
    // final quantityNameController = TextEditingController(
    //   text: quantity?.quantity ?? '',
    // );
    // final quantityPriceController = TextEditingController(
    //   text: '${quantity?.quantityPrice ?? ''}',
    // );
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
                  // controller: quantityNameController,
                  initialValue: quantity?.quantity ?? '',
                  labelText: 'Quantity name',
                  onChanged: (value) {
                    onUpdateQtyName(value ?? '', index);
                  },
                ),
                8.heightBox,
                CustomTextField(
                  // controller: quantityPriceController,
                  initialValue: '${quantity?.quantityPrice ?? ''}',
                  labelText: 'Quantity price',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  onChanged: (value) {
                    onUpdateQtyPrice(
                      double.tryParse(value ?? '0') ?? 0,
                      index,
                    );
                  },
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
    required this.onUpdateVarientName,
    required this.onUpdateVarientPrice,
  });

  final List<Varient?> varients;
  final void Function()? onNewVarientPressed;
  final void Function(int index) onVarientRemovePressed;
  final Function(String name, int index) onUpdateVarientName;
  final Function(double price, int index) onUpdateVarientPrice;

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
                onUpdateVarientPrice: onUpdateVarientPrice,
                onUpdateVarientName: onUpdateVarientName,
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
    required this.onUpdateAddonName,
    required this.onUpdateAddonPrice,
  });

  final Addon? addon;
  final int index;
  final void Function()? onRemovePressed;
  final void Function(String name, int index) onUpdateAddonName;
  final void Function(double price, int index) onUpdateAddonPrice;

  @override
  Widget build(BuildContext context) {
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
                  // controller: addonNameController,
                  initialValue: addon?.addonName ?? '',
                  labelText: 'Addon name',
                  onChanged: (value) {
                    onUpdateAddonName(
                      value ?? '',
                      index,
                    );
                  },
                ),
                8.heightBox,
                CustomTextField(
                  // controller: addonPriceController,
                  initialValue: '${addon?.addonPrice ?? ''}',
                  labelText: 'Addon price',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  onChanged: (value) {
                    onUpdateAddonPrice(
                      double.tryParse(value ?? '0') ?? 0,
                      index,
                    );
                  },
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
    required this.onUpdateAddonName,
    required this.onUpdateAddonPrice,
  });

  final List<Addon?> addons;
  final void Function()? onNewAddonPressed;
  final void Function(int index) onAddonRemovePressed;
  final Function(String name, int index) onUpdateAddonName;
  final Function(double price, int index) onUpdateAddonPrice;

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
                onUpdateAddonName: onUpdateAddonName,
                onUpdateAddonPrice: onUpdateAddonPrice,
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
    this.onChanged,
  });

  final Removal? removal;
  final int index;
  final void Function()? onRemovePressed;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    // final removalNameController = TextEditingController(
    //   text: removal?.removalName ?? '',
    // );
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
                  // controller: removalNameController,
                  initialValue: removal?.removalName ?? '',
                  labelText: 'Removal name',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: onChanged,
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
    required this.onChanged,
  });

  final List<Removal?> removals;
  final void Function()? onNewRemovalPressed;
  final void Function(int index) onRemovalRemovePressed;
  final Function(int index, String value) onChanged;

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
                onChanged: (value) {
                  onChanged(index, value ?? '');
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
