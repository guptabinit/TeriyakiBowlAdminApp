import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/text_field.dart';
import 'package:teriyaki_bowl_admin_app/resources/firestore_methods.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/custom_button.dart';
import '../../common/widgets/promotion_card.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Uint8List? _image;
  String bannerPic = "";
  int promotionNumber = 0;
  bool isLoading = false;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance.collection('commons').doc('promotions').get();

      setState(() {
        promotionNumber = snap.data()!['promotionNumber'];
      });
    } catch (e) {
      showSnackBar("Some error occurred", context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Promotions",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: lightColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: lightColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                titleController.text = "";
                descriptionController.text = "";
              });

              showAddDialogF();
            },
            icon: const Icon(
              Icons.add,
              size: 28,
              color: lightColor,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance.collection('commons').doc('promotions').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                var snap = snapshot.data!;

                var length = snap['promotion_list'].length;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {

                    var mainSnap = snap[snap['promotion_list'][index]];

                    return Stack(
                      children: [
                        PromotionalCard(snap: mainSnap),
                        Positioned(
                          right: -1,
                          top: 12,
                          child: IconButton(
                            color: lightColor,
                            onPressed: () {
                              setState(() {
                                titleController.text = mainSnap['title'];
                                descriptionController.text = mainSnap['description'];
                              });

                              showUpdateDialogF(mainSnap);
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: lightColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }

  Future<dynamic> showUpdateDialogF(snap) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: lightColor),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edit Promotion",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                12.heightBox,
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Image already selected click here to update",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                8.heightBox,
                CustomTextField(
                  controller: titleController,
                  labelText: "Promotional Title",
                ),
                8.heightBox,
                CustomTextField(
                  controller: descriptionController,
                  labelText: "Promotional Description",
                  maxLines: 3,
                ),
                12.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "Delete",
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });

                          await FirestoreMethods().deletePromotion(promotionID: snap['promotion_id'], context: context);

                          setState(() {
                            isLoading = false;
                          });

                          Get.back();
                        },
                      ),
                    ),
                    8.widthBox,
                    Expanded(
                      child: CustomButton(
                        btnText: "Update",
                        onTap: () async {

                          setState(() {
                            isLoading = true;
                          });

                          await FirestoreMethods().updatePromotion(
                            promotionID: snap['promotion_id'],
                            title: snap['title'],
                            file: _image,
                            description: snap['description'],
                            imageUrl: snap['image_link'],
                            imagePresent: _image == null ? false : true,
                            context: context,
                          );

                          setState(() {
                            isLoading = false;
                          });

                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
                12.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "Go Back",
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAddDialogF() {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: lightColor),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add New Promotion",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                12.heightBox,
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text(
                      _image != null ? "Image already selected click here to update" : "Click here to select an image",
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                8.heightBox,
                CustomTextField(
                  controller: titleController,
                  labelText: "Promotional Title",
                ),
                8.heightBox,
                CustomTextField(
                  controller: descriptionController,
                  labelText: "Promotional Description",
                  maxLines: 3,
                ),
                12.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "Cancel",
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    8.widthBox,
                    Expanded(
                      child: CustomButton(
                        btnText: "Add",
                        onTap: () async {
                          if (_image == null) {
                            showSnackBar("Select an image first", context);
                          } else {
                            Get.back();

                            setState(() {
                              isLoading = true;
                            });

                            await FirestoreMethods().addPromotion(
                              promotionID: (promotionNumber + 1).toString(),
                              title: titleController.text,
                              file: _image,
                              description: descriptionController.text,
                              context: context,
                            );

                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
