import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/product_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLoading = false;

  Widget gridCard(
      {required String imgUrl,
      required void Function()? onTap,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  progressIndicatorBuilder: (
                    _,
                    __,
                    downloadProgress,
                  ) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.error,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          8.heightBox,
          SizedBox(
            width: 160,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
          ),
        ],
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
          "Categories",
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
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              size: 28,
              color: lightColor,
            ),
          ),
        ],
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              8.heightBox,
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1 / 1.32,
                  mainAxisSpacing: 12,
                ),
                padding: const EdgeInsets.all(12),
                children: [
                  gridCard(
                    imgUrl:
                        "https://firebasestorage.googleapis.com/v0/b/teriyaki-bowl-app.appspot.com/o/category%2FSalmon%20%26%20Shrimp%20teriyaki.jpeg?alt=media&token=aef5a4c4-f70a-4ff0-9850-4d22522b3d3d",
                    onTap: () {
                      Get.to(
                        () => const ProductsPage(
                          category: 0,
                          categoryName: "ALL ITEMS",
                        ),
                      );
                    },
                    title: "ALL ITEMS",
                  ),
                  gridCard(
                    imgUrl:
                        "https://firebasestorage.googleapis.com/v0/b/teriyaki-bowl-app.appspot.com/o/category%2Fchicken%20%26%20beef%20teriyaki.jpeg?alt=media&token=8dd9cd0f-de99-48a5-921e-94359e69b65c",
                    onTap: () {
                      Get.to(
                        () => const ProductsPage(
                          category: 1,
                          categoryName: "TERIYAKI",
                        ),
                      );
                    },
                    title: "TERIYAKI",
                  ),
                  gridCard(
                    imgUrl:
                        "https://firebasestorage.googleapis.com/v0/b/teriyaki-bowl-app.appspot.com/o/category%2FBeef%20bento.jpeg?alt=media&token=b5041d64-6ab9-480e-a998-6a7e6093e433",
                    onTap: () {
                      Get.to(
                        () => const ProductsPage(
                          category: 2,
                          categoryName: "BENTO",
                        ),
                      );
                    },
                    title: "BENTO",
                  ),
                  gridCard(
                    imgUrl:
                        "https://firebasestorage.googleapis.com/v0/b/teriyaki-bowl-app.appspot.com/o/category%2FPink%20Panther.jpeg?alt=media&token=d66c5365-48cc-4dc0-aa1c-35c838c7f6aa",
                    onTap: () {
                      Get.to(
                        () => const ProductsPage(
                          category: 3,
                          categoryName: "SIGNATURE ROLL",
                        ),
                      );
                    },
                    title: "SIGNATURE ROLL",
                  ),
                  gridCard(
                    imgUrl:
                        "https://firebasestorage.googleapis.com/v0/b/teriyaki-bowl-app.appspot.com/o/category%2FEel%20Roll2.jpeg?alt=media&token=53000bd4-8908-4969-b97b-25bee9e54cd8",
                    onTap: () {
                      Get.to(
                        () => const ProductsPage(
                          category: 4,
                          categoryName: "SUSHI ROLL",
                        ),
                      );
                    },
                    title: "SUSHI ROLL",
                  ),
                  gridCard(
                    imgUrl:
                        "https://firebasestorage.googleapis.com/v0/b/teriyaki-bowl-app.appspot.com/o/category%2FTempura%20Shrimp%202.jpeg?alt=media&token=ce903215-b7c6-48a5-a550-d48c265b3a36",
                    onTap: () {
                      Get.to(
                        () => const ProductsPage(
                          category: 5,
                          categoryName: "SIDES & SALADS",
                        ),
                      );
                    },
                    title: "SIDES & SALADS",
                  ),
                  gridCard(
                    imgUrl:
                        "https://firebasestorage.googleapis.com/v0/b/teriyaki-bowl-app.appspot.com/o/category%2FLemonade.png?alt=media&token=96d47d69-b8a0-4a47-9223-9bc97f43ca48",
                    onTap: () {
                      Get.to(
                        () => const ProductsPage(
                          category: 6,
                          categoryName: "BEVERAGES",
                        ),
                      );
                    },
                    title: "BEVERAGES",
                  ),
                ],
              ),
              62.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
