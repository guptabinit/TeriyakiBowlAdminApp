import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/controllers/receipt_print_controller.dart';
import 'package:teriyaki_bowl_admin_app/models/doordash/quote_response.dart';
import 'package:teriyaki_bowl_admin_app/resources/doordash_api.dart';
import 'package:teriyaki_bowl_admin_app/resources/firestore_methods.dart';
import 'package:teriyaki_bowl_admin_app/resources/payment_gateway.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/components/button.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../screens/order_detail_screen.dart';

class NewOrderCard extends StatefulWidget {
  final dynamic snap;

  const NewOrderCard({super.key, required this.snap});

  @override
  State<NewOrderCard> createState() => _NewOrderCardState();
}

class _NewOrderCardState extends State<NewOrderCard> {
  showingSnackbar(String msg) {
    return showSnackBar(msg, context);
  }

  bool _isMainLoading = false;

  bool isAccepting = false;

  Future<void> updateOrderAcceptedStatusFun(
    int orderAccepted,
  ) async {
    try {
      setState(() {
        _isMainLoading = true;
      });

      if (widget.snap['is_pickup'] == false) {
        final quote = widget.snap['quote'];
        final selectedItems = (widget.snap['selected_items'] as List)
            .map((e) => Item.fromJson(e))
            .toList();

        try {
          final res = await DoordashApiClient().createDelivery(
            pickupAddress: '${quote['pickup_address']}',
            pickupBusinessName: '${quote['pickup_business_name']}',
            pickupPhoneNumber: '${quote['pickup_phone_number']}',
            dropoffAddress: '${quote['dropoff_address']}',
            dropoffBusinessName: '${quote['dropoff_business_name']}',
            dropoffPhoneNumber: '${quote['dropoff_phone_number']}',
            dropoffContactGivenName: '${quote['dropoff_contact_given_name']}',
            orderValue: int.parse('${quote['order_value']}'),
            latitude: double.parse('${quote['dropoff_location']['lat']}'),
            longitude: double.parse('${quote['dropoff_location']['lng']}'),
            items: selectedItems,
          );

          await FirestoreMethods().updateDoorDashOrderCreated(
            oid: widget.snap['oid'],
            deliveryId: res.externalDeliveryId,
            orderStatus: res.deliveryStatus,
            trackingUrl: res.trackingUrl,
          );

          Get.snackbar(
            "Success",
            "Doordash order created",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
          );
        } catch (e) {
          Get.snackbar(
            "Error",
            "Error while creating doordash order",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
          );
          return;
        }
      }

      String message = await FirestoreMethods().updateOrderAcceptedStatus(
        oid: widget.snap['oid'],
        orderAccepted: orderAccepted,
      );

      if (message == 'success') {
        ReceiptPrintController.onPrintReceipt(widget.snap);
        _isMainLoading = false;
      } else {
        _isMainLoading = false;
      }
    } catch (_) {
      _isMainLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailScreen(snap: widget.snap));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: lightColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(1, 1),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "New",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: redColor,
                          fontSize: 14,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        widget.snap['order_time'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: textDarkGreyColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                  Text(
                    "Order No #${widget.snap['oid']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: darkColor,
                      fontSize: 20,
                    ),
                  ),
                  8.heightBox,
                  Text(
                    "Name: ${widget.snap['name']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkTextGreyColor,
                      fontSize: 16,
                    ),
                  ),
                  4.heightBox,
                  Text(
                    "Mode: ${widget.snap['is_pickup'] ? "Pickup" : "Delivery"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkTextGreyColor,
                      fontSize: 16,
                    ),
                  ),
                  4.heightBox,
                  Row(
                    children: [
                      Text(
                        "\$ ${widget.snap['order_total'].toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: darkColor,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        " • ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Total Items: ${widget.snap['cart']['items'].length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: darkTextGreyColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  4.heightBox,
                  const Text(
                    "Item Ordered: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkTextGreyColor,
                      fontSize: 16,
                    ),
                  ),
                  4.heightBox,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemCount: widget.snap['cart']['items'].length,
                    itemBuilder: (BuildContext context, index) {
                      var snap = widget.snap['cart']
                          [widget.snap['cart']['items'][index]];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${index + 1}. ${snap['item_name']} ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              " ${snap['quantity']} x ${snap['package_price'].toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  8.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          btnText: "Decline",
                          backgroundColor: redColor,
                          onTap: () {
                            showDeclineDialog(context);
                          },
                        ),
                      ),
                      8.widthBox,
                      Expanded(
                        child: isAccepting
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                btnText: "Accept",
                                backgroundColor: greenColor,
                                onTap: () async {
                                  await updateOrderAcceptedStatusFun(1);
                                  // setState(() {
                                  //   isAccepting = true;
                                  // });
                                  // try {
                                  //   await updateOrderAcceptedStatusFun(1);
                                  //   ReceiptPrintController.onPrintReceipt(
                                  //     context,
                                  //     data: widget.snap,
                                  //   );
                                  // } catch (e) {
                                  // } finally {
                                  //   setState(() {
                                  //     isAccepting = false;
                                  //   });
                                  // }
                                },
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: darkColor,
            )
          ],
        ),
      ),
    );
  }

  showDeclineDialog(context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: lightColor,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "WB Factory",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: darkColor,
                ),
              ),
              12.heightBox,
              const Text(
                "You want to decline this order?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: darkColor,
                ),
              ),
              16.heightBox,
              _isMainLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            btnText: "Yes",
                            onTap: () async {
                              // Get.back();
                              //
                              // setState(() {
                              //   _isMainLoading = true;
                              // });
                              //
                              // String message = await FirestoreMethods()
                              //     .updateOrderAcceptedStatus(
                              //   oid: widget.snap['oid'],
                              //   orderAccepted: 2,
                              // );
                              //
                              // if (message == 'success') {
                              //   // Get.back();
                              //   customToast("Order Cancelled Successfully",
                              //       greenColor, context);
                              //
                              //   _isMainLoading = false;
                              // } else {
                              //   _isMainLoading = false;
                              // }

                              Get.back();

                              setState(() {
                                _isMainLoading = true;
                              });

                              try {
                                if (widget.snap?['payment_completed'] == true &&
                                    widget.snap?['is_cod'] == false) {
                                  final transId =
                                      widget.snap?['transaction']?['transId'];
                                  final cardNumber = widget.snap?['transaction']
                                      ?['accountNumber'];
                                  final amount = widget.snap?['order_total'];

                                  final refundResult =
                                      await PaymentGateway().refund(
                                    refTransId: transId,
                                    cardNumber: cardNumber.substring(
                                      cardNumber.length - 4,
                                    ),
                                    amount: amount,
                                  );

                                  if (refundResult.messages?.resultCode
                                          ?.toLowerCase() ==
                                      'ok') {
                                    await FirebaseFirestore.instance
                                        .collection('allOrders')
                                        .doc(widget.snap['oid'])
                                        .update(
                                      {
                                        'order_accepted': 2,
                                        'payment_completed': false,
                                      },
                                    );

                                    final messages = refundResult
                                        .transactionResponse?.messages
                                        ?.map((e) => e.description)
                                        .join(' ');

                                    Get.snackbar(
                                      "Refund",
                                      messages ?? 'Refund initialized',
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.all(12.0),
                                      backgroundColor: Colors.yellow,
                                    );
                                  } else {
                                    final message = refundResult
                                        .transactionResponse?.errors
                                        ?.map((e) => e.errorText)
                                        .join(' ');
                                    Get.snackbar(
                                      "Refund",
                                      message ?? 'Refund failed',
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.all(12.0),
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                }
                              } on PaymentGatewayFailure catch (e) {
                                Get.snackbar(
                                  "Refund",
                                  e.message,
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(12.0),
                                  backgroundColor: Colors.red,
                                );
                              } catch (_) {
                                Get.snackbar(
                                  "Refund",
                                  'Refund failed',
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(12.0),
                                  backgroundColor: Colors.red,
                                );
                              }

                              String message = await FirestoreMethods()
                                  .updateOrderAcceptedStatus(
                                oid: widget.snap['oid'],
                                orderAccepted: 2,
                              );

                              if (message == 'success') {
                                // Get.back();

                                Get.snackbar(
                                  "Order cancelled",
                                  "Order Cancelled Successfully",
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(12.0),
                                  backgroundColor: Colors.red,
                                );

                                _isMainLoading = false;
                              } else {
                                _isMainLoading = false;
                              }
                              Get.back();
                            },
                          ),
                        ),
                        12.widthBox,
                        Expanded(
                          child: CustomButton(
                            btnText: "No",
                            onTap: () {
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
}
