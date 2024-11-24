import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_controller.dart';

class CreateView extends GetView<CreateController> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode desFocusNode = FocusNode();
  final FocusNode instructionFocusNode = FocusNode();

  void dispose() {
    desFocusNode.dispose();
    instructionFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70.0,
                decoration: BoxDecoration(
                  color: Colors.purple[200],
                ),
                padding: const EdgeInsets.only(top: 12, left: 18),
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's make a moments!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),
              _buildTextFormField(
                controller.nameController,
                "Name",
                "Enter your name",
              ),
              _buildTextFormField(
                controller.titleController,
                "Title",
                "Enter title",
              ),
              _buildScrollableTextFormField(
                controller.momentsController,
                "Moments",
                "Enter moments",
                height: 100,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.addData(
                          controller.nameController.text,
                          controller.titleController.text,
                          controller.momentsController.text,
                        );
                      }
                    },
                    child: const Text(
                      "Add Moments",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Padding _buildTextFormField(
  TextEditingController controller,
  String label,
  String hint,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16, left: 18, right: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    ),
  );
}

Padding _buildScrollableTextFormField(
    TextEditingController controller, String label, String hint,
    {required double height}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16, left: 18, right: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Container(
          height: height,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
            ),
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      ],
    ),
  );
}
