import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController titleController;
  late TextEditingController momentsController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addData(String name, String title, String moments) async {
    try {
      await firestore.collection('posts').add({
        'name': name,
        'title': title,
        'moments': moments,
      });

      Get.back();
      Get.snackbar(
        'Success',
        'Data added successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
      nameController.clear();
      titleController.clear();
      momentsController.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    titleController = TextEditingController();
    momentsController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    titleController.dispose();
    momentsController.dispose();
    super.onClose();
  }
}
