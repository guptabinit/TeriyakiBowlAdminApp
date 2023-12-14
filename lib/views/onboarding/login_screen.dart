import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teriyaki_bowl_admin_app/views/home/home_screen.dart';
import 'package:teriyaki_bowl_admin_app/views/onboarding/splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/text_field.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  final Map<dynamic, dynamic> adminData;

  const LoginScreen({super.key, required this.adminData});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {

    setState(() {
      _isLoading = true;
    });

    var sharedPref = await SharedPreferences.getInstance();

    if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      if (RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(emailController.text)) {
        if (passwordController.text.length >= 6) {
          if (emailController.text == widget.adminData['email'] &&
              passwordController.text == widget.adminData['password']) {

            sharedPref.setBool(SplashScreenState.KEYLOGIN, true);

            setState(() {
              _isLoading = false;
            });

            Get.offAll(() => const HomeScreen());
          } else {
            setState(() {
              _isLoading = false;
            });

            showSnack("Wrong email or password");
          }
        } else {
          setState(() {
            _isLoading = false;
          });

          showSnack("Password have 6 or more characters");
        }
      } else {
        setState(() {
          _isLoading = false;
        });

        showSnack("Badly formatted email address");
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });

      showSnack("Enter all the details");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> showSnack(res) {
    return showSnackBar(res, context);
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
                child: Image.asset(
                  "assets/logov1.png",
                  height: 160,
                  width: 160,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: lightColor, borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      12.heightBox,
                      CustomTextField(
                        fontWeight: FontWeight.normal,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Admin email",
                      ),
                      12.heightBox,
                      CustomTextField(
                        fontWeight: FontWeight.normal,
                        controller: passwordController,
                        isPass: true,
                        labelText: "Admin password",
                      ),
                      16.heightBox,
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: loginUser,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: lightColor,
                                        ),
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: lightColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.heightBox,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
