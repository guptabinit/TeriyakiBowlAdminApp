import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teriyaki_bowl_admin_app/views/home/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';

import '../../utils/colors.dart';
import '../../utils/utils.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  static const String KEYLOGIN = 'login';

  var adminData = {};

  // changeScreen() {
  //   Future.delayed(const Duration(seconds: 2), () async {
  //     await getData();
  //     Get.off(() => LoginScreen(adminData: adminData,));
  //   });
  // }

  changeScreen() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Future.delayed(const Duration(seconds: 2), () async {

      if(isLoggedIn != null){
        if(isLoggedIn){
          Get.offAll(() => const HomeScreen());
        } else {
          await getData();
          Get.offAll(() => LoginScreen(adminData: adminData,));
        }
      } else {
        await getData();
        Get.offAll(() => LoginScreen(adminData: adminData,));
      }

    });

  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('admin')
          .get();

      adminData = snap.data()!;
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> showSnack(res){
    return showSnackBar(res, context);
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/logov1.png",
                        height: 160,
                        width: 160,
                      ),
                      24.heightBox,
                      const Text(
                        "Admin/Restaurant App",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CircularProgressIndicator(
                color: darkColor,
              ),
              24.heightBox,
              const Text(
                "Powered by JP Digital Agency",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              24.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
