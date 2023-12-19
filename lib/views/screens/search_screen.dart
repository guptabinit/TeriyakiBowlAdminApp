import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/order_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/text_field.dart';
import '../../utils/colors.dart';

class SearchOrderScreen extends StatefulWidget {
  const SearchOrderScreen({super.key});

  @override
  State<SearchOrderScreen> createState() => _SearchOrderScreenState();
}

class _SearchOrderScreenState extends State<SearchOrderScreen> {
  TextEditingController searchController = TextEditingController();

  bool isShowItem = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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
          "Search",
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
      ),
      body: Column(
        children: [
          8.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: searchController,
                    labelText: "Search",
                    keyboardType: TextInputType.number,
                  ),
                ),
                8.widthBox,
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isShowItem = true;
                    });
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          8.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
              child: !isShowItem
                  ? const Center(
                      child: Text("Search Order..."),
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('allOrders').where('oid', isGreaterThanOrEqualTo: searchController.text.toString()).orderBy('oid', descending: true).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          );
                        }

                        var listLength = snapshot.data!.docs.length;

                        return listLength == 0
                            ? Center(
                                child: "No Existing Order".text.bold.make(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(12),
                                itemCount: snapshot.data!.docs.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, index) {
                                  var snap = snapshot.data!.docs[index];

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      OrderTile(snap: snap),
                                      12.heightBox,
                                    ],
                                  );
                                },
                              );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
