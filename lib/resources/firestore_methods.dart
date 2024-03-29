import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teriyaki_bowl_admin_app/resources/storage_methods.dart';

import '../utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // PROMOTION CODE

  Future<String> updateOrderAcceptedStatus({
    required String oid,
    required int orderAccepted,
  }) async {
    String res = "some error occurred";
    try {
      await _firestore.collection('allOrders').doc(oid).update({
        'order_accepted': orderAccepted,
        'accepted_time': FieldValue.serverTimestamp(),
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> updateDoorDashOrderCreated({
    required String oid,
    String? deliveryId,
    String? orderStatus,
    String? trackingUrl,
  }) async {
    String res = "some error occurred";
    try {
      await _firestore.collection('allOrders').doc(oid).update({
        'tracking_url': trackingUrl,
        'doordash_order_status': orderStatus,
        'delivery_id': deliveryId,
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> addPromotion({
    required String promotionID,
    required String title,
    required Uint8List? file,
    required String description,
    required context,
  }) async {
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        file!,
        promotionID,
      );

      await _firestore.collection('commons').doc('promotions').set({
        promotionID: {
          'promotion_id': promotionID,
          'title': title,
          'description': description,
          'image_link': photoUrl,
        },
        'promotionNumber': promotionID,
        'promotion_list': FieldValue.arrayUnion([promotionID])
      }, SetOptions(merge: true)).then(
          (value) => showSnackBar("Promotion added successfully", context));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> updatePromotion({
    required String promotionID,
    required String title,
    required Uint8List? file,
    required String description,
    required String? imageUrl,
    required bool imagePresent,
    required context,
  }) async {
    try {
      if (imagePresent) {
        String photoUrl =
            await StorageMethods().uploadImageToStorage(file!, promotionID);

        await _firestore.collection('commons').doc('promotions').update({
          promotionID: {
            'promotion_id': promotionID,
            'title': title,
            'description': description,
            'image_link': photoUrl,
          },
        });
      } else {
        await _firestore.collection('commons').doc('promotions').update({
          promotionID: {
            'promotion_id': promotionID,
            'title': title,
            'description': description,
            'image_link': imageUrl,
          },
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> deletePromotion({
    required String promotionID,
    required context,
  }) async {
    try {
      await _firestore.collection('commons').doc('promotions').update({
        'promotion_list': FieldValue.arrayRemove([promotionID])
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // TAX CODE

  Future<void> updateTax({
    required double tax,
    required context,
  }) async {
    try {
      await _firestore.collection('commons').doc('tax').update({'tax': tax});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // COUPON CODE

  Future<void> addCoupon({
    required String cid,
    required String couponName,
    required String couponDescription,
    required double discount,
    required context,
  }) async {
    try {
      await _firestore.collection('commons').doc('coupons').set({
        cid: {
          'cid': cid,
          'coupon_name': couponName,
          'coupon_desc': couponDescription,
          'discount': discount,
        },
        'code_list': FieldValue.arrayUnion([cid])
      }, SetOptions(merge: true));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> updateCoupon({
    required String cid,
    required String couponName,
    required String couponDescription,
    required double discount,
    required context,
  }) async {
    try {
      await _firestore.collection('commons').doc('coupons').update({
        cid: {
          'cid': cid,
          'coupon_name': couponName,
          'coupon_desc': couponDescription,
          'discount': discount,
        },
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> deleteCoupon({
    required String cid,
    required context,
  }) async {
    try {
      await _firestore.collection('commons').doc('coupons').update({
        'code_list': FieldValue.arrayRemove([cid])
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // UPDATE ORDER

  Future<String> updateOrder({
    required String oid,
    required int orderStatus,
    required bool paymentCompleted,
    required String uid,
    required double orderTotal,
  }) async {
    String res = "some error occurred";
    try {
      await _firestore.collection('allOrders').doc(oid).update({
        'order_status': orderStatus,
        'payment_completed': paymentCompleted,
      });

      if (orderStatus == 1 && orderTotal != 0) {
        await _firestore.collection('coins').doc(uid).set({
          'coins': FieldValue.increment(_getDecimalPlaces(orderTotal)),
        }, SetOptions(merge: true));
      }

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  int _getDecimalPlaces(num number) {
    int decimals = 0;
    List<String> subStr = number.toString().split('.');
    if (subStr.isNotEmpty) decimals = int.tryParse(subStr.first) ?? 0;
    return decimals;
  }

  // UPDATE Read ORDER

  Future<String> updateReadOrder({
    required String oid,
  }) async {
    String res = "some error occurred";
    try {
      await _firestore.collection('allOrders').doc(oid).update({
        'read': true,
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<Map<String, dynamic>?> getOrderById(String oid) {
    return _firestore
        .collection('allOrders')
        .doc(oid)
        .get()
        .then((doc) => doc.data());
  }
}
