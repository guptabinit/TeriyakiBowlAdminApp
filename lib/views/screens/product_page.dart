import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../cards/grid_card.dart';
import 'item_detail_screen.dart';

class ProductsPage extends StatefulWidget {
  final int category;
  final String categoryName;

  const ProductsPage({
    super.key,
    required this.category,
    required this.categoryName,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: lightColor,
          ),
        ),
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: lightColor,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Builder(builder: (BuildContext context) {
            if (widget.category == 0) {
              return StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GridViewContent(
                    snapshot: snapshot,
                  );
                },
              );
            }
            if (widget.category == 1) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .where('item_sub_category', isEqualTo: 'TERIYAKI')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GridViewContent(
                    snapshot: snapshot,
                  );
                },
              );
            }
            if (widget.category == 2) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .where('item_sub_category', isEqualTo: 'BENTO')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GridViewContent(
                    snapshot: snapshot,
                  );
                },
              );
            }
            if (widget.category == 3) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .where('item_sub_category', isEqualTo: 'SIGNATURE ROLLS')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GridViewContent(
                    snapshot: snapshot,
                  );
                },
              );
            }
            if (widget.category == 4) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .where('item_sub_category', isEqualTo: 'SUSHI ROLLS')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GridViewContent(
                    snapshot: snapshot,
                  );
                },
              );
            }
            if (widget.category == 5) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .where('item_sub_category', isEqualTo: 'SIDES & SALAD')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GridViewContent(
                    snapshot: snapshot,
                  );
                },
              );
            }
            if (widget.category == 6) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .where('item_sub_category', isEqualTo: 'BEVERAGES')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GridViewContent(
                    snapshot: snapshot,
                  );
                },
              );
            }

            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                    'items',
                  )
                  .snapshots(),
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                if (widget.category == 0) {
                  return GridViewContent(
                    snapshot: snapshot,
                  );
                }
                if (widget.category == 1) {
                  return GridViewContent(
                    snapshot: snapshot,
                  );
                }

                return GridViewContent(
                  snapshot: snapshot,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class GridViewContent extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  const GridViewContent({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          childAspectRatio: 2 / 2.7,
          mainAxisSpacing: 12,
        ),
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12,
          top: 8,
        ),
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (BuildContext context, index) {
          var snap = snapshot.data!.docs[index].data();
          return GestureDetector(
            onTap: () {
              Get.to(() => ItemDetailScreen(
                    snap: snap,
                  ));
            },
            child: GridCard(snap: snap),
          );
        },
      ),
    );
  }
}
