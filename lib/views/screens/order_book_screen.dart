import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/order_tile.dart';
import 'package:teriyaki_bowl_admin_app/views/screens/search_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/colors.dart';
import '../cards/new_order_card.dart';

enum PageItem { remaining, completed, cancelled, declined, all }

class OrderBookScreen extends StatefulWidget {
  const OrderBookScreen({super.key});

  @override
  State<OrderBookScreen> createState() => _OrderBookScreenState();
}

class _OrderBookScreenState extends State<OrderBookScreen> {
  PageItem selectedMenu = PageItem.remaining;

  String titleText() {
    if (selectedMenu == PageItem.completed) {
      return "Completed Orders";
    } else if (selectedMenu == PageItem.cancelled) {
      return "Cancelled Orders";
    } else if (selectedMenu == PageItem.remaining) {
      return "Remaining Orders";
    } else if (selectedMenu == PageItem.declined) {
      return "Declined Orders";
    } else {
      return "All Orders";
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSelection() {
    if (selectedMenu == PageItem.completed) {
      return FirebaseFirestore.instance
          .collection('allOrders')
          .where('order_status', isEqualTo: 1)
          .orderBy('oid', descending: true)
          .snapshots();
    } else if (selectedMenu == PageItem.cancelled) {
      return FirebaseFirestore.instance
          .collection('allOrders')
          .where('order_status', isEqualTo: 2)
          .orderBy('oid', descending: true)
          .snapshots();
    } else if (selectedMenu == PageItem.remaining) {
      return FirebaseFirestore.instance
          .collection('allOrders')
          .where('order_status', isEqualTo: 0)
          .where('order_accepted', isNotEqualTo: 2)
          .orderBy('order_accepted')
          .orderBy('oid', descending: true)
          .snapshots();
    } else if (selectedMenu == PageItem.declined) {
      return FirebaseFirestore.instance
          .collection('allOrders')
          .where('order_accepted', isEqualTo: 2)
          .orderBy('oid', descending: true)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('allOrders')
          .orderBy('oid', descending: true)
          .snapshots();
    }
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
        title: Text(
          titleText(),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
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
          IconButton(
            onPressed: () {
              Get.to(
                () => const SearchOrderScreen(),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 28,
              color: lightColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<PageItem>(
              icon: const Icon(
                Icons.more_vert,
                size: 28,
                color: lightColor,
              ),
              initialValue: selectedMenu,
              // Callback that sets the selected popup menu item.
              onSelected: (PageItem item) {
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<PageItem>>[
                const PopupMenuItem<PageItem>(
                  value: PageItem.remaining,
                  child: Text('Remaining Orders'),
                ),
                const PopupMenuItem<PageItem>(
                  value: PageItem.completed,
                  child: Text('Completed Orders'),
                ),
                const PopupMenuItem<PageItem>(
                  value: PageItem.cancelled,
                  child: Text('Cancelled Orders'),
                ),
                const PopupMenuItem<PageItem>(
                  value: PageItem.declined,
                  child: Text('Declined Orders'),
                ),
                const PopupMenuItem<PageItem>(
                  value: PageItem.all,
                  child: Text('All Orders'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              child: StreamBuilder(
                stream: streamSelection(),
                builder: (context, var snapshot) {
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

                            if (snap['order_accepted'] == 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // OrderTile(snap: snap),
                                  NewOrderCard(snap: snap),
                                  12.heightBox,
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  OrderTile(snap: snap),
                                  // NewOrderCard(snap: snap),
                                  12.heightBox,
                                ],
                              );
                            }
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
