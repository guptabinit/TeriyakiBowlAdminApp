import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/order_tile.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/search_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/colors.dart';

class OrderBookScreen extends StatefulWidget {
  const OrderBookScreen({super.key});

  @override
  State<OrderBookScreen> createState() => _OrderBookScreenState();
}

class _OrderBookScreenState extends State<OrderBookScreen> {
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
          "Order Book",
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
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {
                Get.to(()=> const SearchOrderScreen());
              },
              icon: const Icon(
                Icons.search,
                size: 28,
                color: lightColor,
              ),),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('allOrders').orderBy('oid', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  var listLength = snapshot.data!.docs.length;

                  return listLength == 0 ? Center(child: "No Existing Order".text.bold.make(),) : ListView.builder(
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
          Container(),
        ],
      ),
    );
  }
}
