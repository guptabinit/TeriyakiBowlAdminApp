import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teriyaki_bowl_admin_app/common/components/button.dart';
import 'package:teriyaki_bowl_admin_app/controllers/receipt_print_controller.dart';
import 'package:teriyaki_bowl_admin_app/main.dart';
import 'package:teriyaki_bowl_admin_app/models/doordash/quote_response.dart';
import 'package:teriyaki_bowl_admin_app/resources/doordash_api.dart';
import 'package:teriyaki_bowl_admin_app/resources/firestore_methods.dart';
import 'package:teriyaki_bowl_admin_app/resources/payment_gateway.dart';
import 'package:teriyaki_bowl_admin_app/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/fixed_cart.dart';
import '../../utils/colors.dart';

class OrderDetailScreen extends StatefulWidget {
  final dynamic snap;

  const OrderDetailScreen({super.key, required this.snap});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int? _selectedOrderOption = 0;
  bool? _selectedPaymentOption = false;

  String acceptedAt = "";

  @override
  void initState() {
    super.initState();

    widget.snap['read'] == false ? updateReadOrder() : null;

    if (widget.snap['order_accepted'] == 1) {
      try {
        acceptedAt =
            'Order accepted at ${DateFormat('dd MMM yyyy hh:mm a').format(widget.snap['accepted_time'].toDate())}';
      } catch (e) {
        e.log();
      }
    }

    setState(() {
      _selectedOrderOption = widget.snap['order_status'];
      _selectedPaymentOption = widget.snap['payment_completed'];
    });
  }

  String orderStatus() {
    if (widget.snap['order_status'] == 0) {
      return 'In Process';
    } else if (widget.snap['order_status'] == 1) {
      return 'Completed';
    }
    return 'Cancelled';
  }

  Color colorStatus() {
    if (widget.snap['order_status'] == 0) {
      return blueColor;
    } else if (widget.snap['order_status'] == 1) {
      return greenColor;
    }
    return redColor;
  }

  bool _isLoading = false;

  void updateOrder() async {
    setState(() {
      _isLoading = true;
    });

    String message = await FirestoreMethods().updateOrder(
      oid: widget.snap['oid'],
      orderStatus: _selectedOrderOption!,
      paymentCompleted: _selectedPaymentOption!,
      uid: widget.snap['uid'],
      orderTotal: widget.snap['order_total'],
    );

    if (message == 'success') {
      setState(() {
        _isLoading = false;
      });
      showingSnackbar('Order update successfully');
      Get.back();
    } else {
      setState(() {
        _isLoading = false;
      });
      showingSnackbar('Error: $message');
    }
  }

  showingSnackbar(String msg) {
    return showSnackBar(msg, context);
  }

  bool _isMainLoading = false;

  void updateReadOrder() async {
    setState(() {
      _isMainLoading = true;
    });

    String message = await FirestoreMethods().updateReadOrder(
      oid: widget.snap['oid'],
    );

    if (message == 'success') {
      setState(() {
        _isMainLoading = false;
      });
    } else {
      setState(() {
        _isMainLoading = false;
      });
    }
  }

  Future<void> updateOrderAcceptedStatusFun(
    int orderAccepted,
  ) async {
    print('Callllllled');
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
        setState(() {
          _isMainLoading = false;
        });
      } else {
        setState(() {
          _isMainLoading = false;
        });
      }
    } catch (_) {
      // _isMainLoading = false;
    } finally {
      _isMainLoading = false;
      setState(() {});
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
        title: const Text(
          'Order Details',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w500,
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
      body: _isMainLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Order No #${widget.snap['oid']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: darkColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          4.widthBox,
                          Text(
                            orderStatus(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: colorStatus(),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      4.heightBox,
                      const Divider(),

                      widget.snap['order_accepted'] == 1
                          ? Text(
                              acceptedAt,
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Container(),

                      widget.snap['order_accepted'] == 1
                          ? const Divider()
                          : Container(),

                      widget.snap['order_accepted'] == 0
                          ? Row(
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
                                  child: CustomButton(
                                    btnText: "Accept",
                                    backgroundColor: greenColor,
                                    onTap: () async {
                                      await updateOrderAcceptedStatusFun(1);
                                      Get.close(1);
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container(),

                      widget.snap['order_accepted'] == 0
                          ? const Divider()
                          : Container(),

                      widget.snap['is_pickup']
                          ? Container()
                          : Center(
                              child: SizedBox(
                                width: double
                                    .infinity, // Set width to the whole screen
                                child: TextButton(
                                  onPressed: () async {
                                    if (widget.snap['trackingUrl'] != null) {
                                      await launchUrlString(
                                          widget.snap['trackingUrl']);
                                    }
                                  },
                                  child: const Text(
                                    'Click to track your order',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      widget.snap['is_pickup'] ? Container() : const Divider(),
                      4.heightBox,
                      // Imp Info Card
                      Column(
                        children: [
                          const Text(
                            'Important Info',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: darkColor,
                              fontSize: 20,
                            ),
                          ),
                          8.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Mode: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.snap['is_pickup']
                                    ? 'Pickup'
                                    : 'Delivery',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Total Amount: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$ ${widget.snap['order_total'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          widget.snap['is_pickup']
                              ? Row(
                                  children: [
                                    const Text(
                                      'Pickup Time: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkTextGreyColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${widget.snap['pickup_time']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          widget.snap['is_pickup'] ? 6.heightBox : Container(),
                          Row(
                            children: [
                              const Text(
                                'Payment Mode: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.snap['is_cod'] ? 'COD' : 'Online',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Payment Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.snap['payment_completed']
                                    ? 'PAID'
                                    : 'UNPAID',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: widget.snap['payment_completed']
                                      ? greenColor
                                      : redColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Order Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                orderStatus(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: colorStatus(),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Order Time: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${widget.snap['order_time']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      4.heightBox,
                      const Divider(),
                      4.heightBox,
                      // Delivery Info Card
                      Column(
                        children: [
                          const Text(
                            'Order Info',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: darkColor,
                              fontSize: 20,
                            ),
                          ),
                          8.heightBox,
                          ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(12),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.snap['cart']['items'].length,
                            itemBuilder: (BuildContext context, index) {
                              var snap = widget.snap['cart']
                                  [widget.snap['cart']['items'][index]];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FixedCartTile(
                                    itemSnap: snap,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),

                      4.heightBox,
                      const Divider(),
                      4.heightBox,
                      // Personal Info Card
                      Column(
                        children: [
                          const Text(
                            'Personal Info',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: darkColor,
                              fontSize: 20,
                            ),
                          ),
                          8.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Name: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.snap['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Phone: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${widget.snap['mobile']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Email: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.snap['email'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      4.heightBox,
                      const Divider(),
                      4.heightBox,

                      // Payment Info Card
                      Column(
                        children: [
                          const Text(
                            'Payment Info',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: darkColor,
                              fontSize: 20,
                            ),
                          ),
                          8.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Price: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$ ${widget.snap['cart']['cart_amount'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              Text(
                                'Discount - ${widget.snap['coupon_code']}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '-\$ ${widget.snap['discount_amount'].toStringAsFixed(2) ?? ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Tax: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$ ${widget.snap['tax_amount'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Delivery Cost: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$ ${widget.snap['delivery_cost'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Total Amount: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$ ${widget.snap['order_total'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Payment Mode: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.snap['is_cod'] ? 'COD' : 'Online',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          6.heightBox,
                          Row(
                            children: [
                              const Text(
                                'Payment Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.snap['payment_completed']
                                    ? 'PAID'
                                    : 'UNPAID',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: widget.snap['payment_completed']
                                      ? greenColor
                                      : redColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          widget.snap['transaction'] == null
                              ? Container()
                              : 6.heightBox,
                          widget.snap['transaction'] == null
                              ? Container()
                              : Row(
                                  children: [
                                    const Text(
                                      'Transaction ID: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkTextGreyColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${widget.snap['transaction']['transId']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: darkColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),

                      4.heightBox,
                      const Divider(),
                      widget.snap['is_pickup'] ? Container() : 4.heightBox,
                      // Delivery Info Card
                      widget.snap['is_pickup']
                          ? Container()
                          : Column(
                              children: [
                                const Text(
                                  'Delivery Info',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: darkColor,
                                    fontSize: 20,
                                  ),
                                ),
                                8.heightBox,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Address: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkTextGreyColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${widget.snap['deliveryInfo']['street']}, ${widget.snap['deliveryInfo']['locality']}, ${widget.snap['deliveryInfo']['city']}, ${widget.snap['deliveryInfo']['country']} - ${widget.snap['deliveryInfo']['zip']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: darkColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                6.heightBox,
                                Row(
                                  children: [
                                    const Text(
                                      'Phone: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkTextGreyColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${widget.snap['deliveryInfo']['phone']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                6.heightBox,
                                Row(
                                  children: [
                                    const Text(
                                      'Name: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkTextGreyColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      widget.snap['deliveryInfo']['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                6.heightBox,
                                Row(
                                  children: [
                                    const Text(
                                      'Type: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkTextGreyColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      widget.snap['deliveryInfo']['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                      widget.snap['is_pickup'] ? Container() : 4.heightBox,
                      widget.snap['is_pickup'] ? Container() : const Divider(),
                      4.heightBox,
                      // Update Info Card
                      Column(
                        children: [
                          const Text(
                            'Update Info',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: darkColor,
                              fontSize: 20,
                            ),
                          ),
                          8.heightBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Update Order Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              8.heightBox,
                              RadioListTile(
                                title: const Text(
                                  'In Process',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: blueColor,
                                    fontSize: 16,
                                  ),
                                ),
                                value: 0,
                                groupValue: _selectedOrderOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOrderOption = value;
                                  });
                                },
                                activeColor: blueColor,
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Completed ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: greenColor,
                                    fontSize: 16,
                                  ),
                                ),
                                value: 1,
                                groupValue: _selectedOrderOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOrderOption = value;
                                  });
                                },
                                activeColor: greenColor,
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Cancelled',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: redColor,
                                    fontSize: 16,
                                  ),
                                ),
                                value: 2,
                                groupValue: _selectedOrderOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOrderOption = value;
                                  });
                                },
                                activeColor: redColor,
                              ),

                              16.heightBox,
                              // for payment
                              const Text(
                                'Update Payment Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkTextGreyColor,
                                  fontSize: 16,
                                ),
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Unpaid',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: redColor,
                                    fontSize: 16,
                                  ),
                                ),
                                value: false,
                                groupValue: _selectedPaymentOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPaymentOption = value;
                                  });
                                },
                                activeColor: redColor,
                              ),
                              RadioListTile(
                                title: const Text(
                                  'Paid',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: greenColor,
                                    fontSize: 16,
                                  ),
                                ),
                                value: true,
                                groupValue: _selectedPaymentOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPaymentOption = value;
                                  });
                                },
                                activeColor: greenColor,
                              ),

                              12.heightBox,
                              // button
                              !_isLoading
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            btnText: 'Update Order',
                                            onTap: updateOrder,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: CustomButton(
                                            btnText: 'Recepit Print',
                                            onTap: () {
                                              ReceiptPrintController
                                                  .onPrintReceipt(widget.snap);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                "TK Bowl",
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
                              // Get.offAll(() => const LoginPage());
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
                              Get.close(1);
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
