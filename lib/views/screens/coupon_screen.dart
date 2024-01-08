import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/text_field.dart';
import 'package:teriyaki_bowl_admin_app/resources/firestore_methods.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/custom_button.dart';
import '../../utils/colors.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  TextEditingController couponIDController = TextEditingController();
  TextEditingController couponNameController = TextEditingController();
  TextEditingController couponDescController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    couponIDController.dispose();
    couponNameController.dispose();
    couponDescController.dispose();
    discountController.dispose();
  }

  Future<dynamic> showUpdateDialogF() {
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
                  "Edit Coupon",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                16.heightBox,
                CustomTextField(
                  controller: couponIDController,
                  labelText: "Enter the coupon ID",
                ),
                12.heightBox,
                CustomTextField(
                  maxLength: 24,
                  controller: couponNameController,
                  labelText: "Enter the coupon name",
                ),
                12.heightBox,
                CustomTextField(
                  controller: couponDescController,
                  labelText: "Enter the coupon description",
                  maxLines: 3,
                ),
                12.heightBox,
                CustomTextField(
                  controller: discountController,
                  labelText: "Enter the discount (in %)",
                  keyboardType: TextInputType.number,
                ),
                16.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "Delete",
                        onTap: () async {
                          await FirestoreMethods().deleteCoupon(
                            cid: couponIDController.text,
                            context: context,
                          );

                          Get.back();
                        },
                      ),
                    ),
                    8.widthBox,
                    Expanded(
                      child: CustomButton(
                        btnText: "Update",
                        onTap: () async {
                          await FirestoreMethods().updateCoupon(
                            cid: couponIDController.text,
                            couponName: couponNameController.text,
                            couponDescription: couponDescController.text,
                            discount: double.parse(discountController.text),
                            context: context,
                          );

                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "Cancel",
                        onTap: () {
                          setState(() {
                            couponIDController.text = "";
                            couponNameController.text = "";
                            couponDescController.text = "";
                            discountController.text = "";
                          });

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
                  "Add New Coupon",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                16.heightBox,
                CustomTextField(
                  controller: couponIDController,
                  labelText: "Enter the coupon ID",
                ),
                12.heightBox,
                CustomTextField(
                  maxLength: 24,
                  controller: couponNameController,
                  labelText: "Enter the coupon name",
                ),
                12.heightBox,
                CustomTextField(
                  controller: couponDescController,
                  labelText: "Enter the coupon description",
                  maxLines: 3,
                ),
                12.heightBox,
                CustomTextField(
                  controller: discountController,
                  labelText: "Enter the discount (in %)",
                  keyboardType: TextInputType.number,
                ),
                16.heightBox,
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
                          await FirestoreMethods().addCoupon(
                            cid: couponIDController.text,
                            couponName: couponNameController.text,
                            couponDescription: couponDescController.text,
                            discount: double.parse(discountController.text),
                            context: context,
                          );

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
          "Manage Coupons",
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
                couponIDController.text = "";
                couponNameController.text = "";
                couponDescController.text = "";
                discountController.text = "";
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('commons').doc('coupons').snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!["code_list"].length,
            padding: const EdgeInsets.all(12),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              var snap = snapshot.data!['${snapshot.data!['code_list'][index]}'];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
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
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Coupon ID: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    snap['cid'],
                                  ),
                                ],
                              ),
                              6.heightBox,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Coupon Title: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snap['coupon_name'],
                                    ),
                                  ),
                                ],
                              ),
                              6.heightBox,
                              Text.rich(TextSpan(children: [
                                const TextSpan(
                                  text: "Coupon Description: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: snap['coupon_desc'],
                                )
                              ])),
                              6.heightBox,
                              Row(
                                children: [
                                  const Text(
                                    "Discount: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${snap['discount']} %",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              couponIDController.text = snap['cid'];
                              couponNameController.text = snap['coupon_name'];
                              couponDescController.text = snap['coupon_desc'];
                              discountController.text = snap['discount'].toString();
                            });
                            showUpdateDialogF();
                          },
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
