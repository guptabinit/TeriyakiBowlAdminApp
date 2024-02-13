import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/models/category.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/add_item_screen.dart';
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

  Widget gridCard({
    required String imgUrl,
    required void Function()? onTap,
    required String title,
  }) {
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
            onPressed: () {
              Get.to(() => const AddItemScreen());
            },
            icon: const Icon(
              Icons.add,
              size: 28,
              color: lightColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            8.heightBox,
            StreamBuilder(
              stream: _fetchCategories(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Error",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1 / 1.32,
                        mainAxisSpacing: 12,
                      ),
                      padding: const EdgeInsets.all(12),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final category = snapshot.data?.elementAt(index);
                        return gridCard(
                          imgUrl: '${category?.thumbnail}',
                          onTap: () {
                            Get.to(
                              () => ProductsPage(
                                category: category?.category ?? 0,
                                categoryName: "${category?.name}",
                              ),
                            );
                          },
                          title: "${category?.name}",
                        );
                      },
                    );
                }
              },
            ),
            62.heightBox,
          ],
        ),
      ),
    );
  }

  Stream<List<Category>> _fetchCategories() {
    return FirebaseFirestore.instance
        .collection(
          'categories',
        )
        .orderBy(
          'category',
          descending: false,
        )
        .snapshots()
        .map(
          (snapshots) => snapshots.docs
              .map(
                (e) => Category.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
