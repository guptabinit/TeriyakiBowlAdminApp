import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/custom_button.dart';
import 'package:teriyaki_bowl_admin_app/views/onboarding/login_screen.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/coupon_screen.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/promotion_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/text_field.dart';
import '../../resources/firestore_methods.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../onboarding/splash_screen.dart';
import '../screens/order_book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taxController = TextEditingController();

  late var tax;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taxController.dispose();
  }

  var adminData = {};

  bool isLoading = false;

  bool taxLoading = false;

  getTaxData() async {
    var taxData = {};

    try {
      var snap = await FirebaseFirestore.instance.collection('commons').doc('tax').get();

      taxData = snap.data()!;

      setState(() {
        tax = taxData['tax'];

        taxController.text = tax.toString();
      });
    } catch (e) {
      showSnack(e.toString());
    }
  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance.collection('commons').doc('admin').get();

      adminData = snap.data()!;
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> showSnack(res) {
    return showSnackBar(res, context);
  }

  Future<dynamic> showTaxDialogF() {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: lightColor),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Manage Tax",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              16.heightBox,
              12.heightBox,
              CustomTextField(
                controller: taxController,
                labelText: "Enter the tax (in %)",
                keyboardType: TextInputType.number,
              ),
              16.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: "Go Back",
                      onTap: () {
                        setState(() {
                          taxController.text = "";
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

                        await FirestoreMethods().updateTax(tax: double.parse(taxController.text), context: context);

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
        title: const Text(
          "Admin Dashboard",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            color: lightColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: isLoading
                ? const Center(
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: lightColor,
                          strokeWidth: 2,
                        )),
                  )
                : IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      var sharedPref = await SharedPreferences.getInstance();

                      sharedPref.setBool(SplashScreenState.KEYLOGIN, false);

                      await getData();

                      setState(() {
                        isLoading = false;
                      });

                      Get.offAll(() => LoginScreen(adminData: adminData));
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      size: 28,
                      color: lightColor,
                    )),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                8.heightBox,
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple[200],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Get.to(() => const OrderBookScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_cart_outlined),
                          8.widthBox,
                          const Expanded(
                            child: Text(
                              "Order Book",
                              style: TextStyle(fontSize: 16, color: darkColor, fontWeight: FontWeight.w600),
                            ),
                          ),
                          8.widthBox,
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                12.heightBox,
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green[200],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Get.to(() => const CouponScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.discount_outlined),
                          8.widthBox,
                          const Expanded(
                            child: Text(
                              "Manage Coupons",
                              style: TextStyle(fontSize: 16, color: darkColor, fontWeight: FontWeight.w600),
                            ),
                          ),
                          8.widthBox,
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                12.heightBox,
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange[200],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      setState(() {
                        taxLoading = true;
                      });

                      await getTaxData();

                      setState(() {
                        taxLoading = false;
                      });

                      showTaxDialogF();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.percent),
                          8.widthBox,
                          const Expanded(
                            child: Text(
                              "Manage Taxes",
                              style: TextStyle(fontSize: 16, color: darkColor, fontWeight: FontWeight.w600),
                            ),
                          ),
                          8.widthBox,
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                12.heightBox,
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.yellow[200],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Get.to(() => const PromotionScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.discount_outlined),
                          8.widthBox,
                          const Expanded(
                            child: Text(
                              "Promotions",
                              style: TextStyle(
                                fontSize: 16,
                                color: darkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          8.widthBox,
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          taxLoading ? const Center(child: CircularProgressIndicator(color: primaryColor)) : Container(),
        ],
      ),
    );
  }
}
