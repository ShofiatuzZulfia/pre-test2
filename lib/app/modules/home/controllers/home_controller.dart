import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretest2/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    return FirebaseFirestore.instance.collection('posts').snapshots();
  }

  void deleteData(String docID) {
    try {
      Get.defaultDialog(
          title: "Delete Post",
          middleText: "Are you sure you want to delete this post?",
          onConfirm: () {
            firestore.collection('posts').doc(docID).delete();
            Get.back();
            Get.snackbar(
              'Success',
              'Data deleted successfully',
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(12),
            );
          },
          textConfirm: "Yes, I'm sure",
          textCancel: "No");
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Cannot delete this post',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    }
  }

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }
}
