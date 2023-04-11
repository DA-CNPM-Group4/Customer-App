import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const h_10 = SizedBox(
      height: 10,
    );
    const h_20 = SizedBox(
      height: 20,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Update Information",
            style: BaseTextStyle.heading2(fontSize: 20),
          ),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    "Please fill required fields below to change password",
                    style: BaseTextStyle.heading2(fontSize: 16),
                  ),
                  h_10,
                  TextFormField(
                    controller: controller.oldPasswordController,
                    validator: (value) => controller.passwordValidator(value!),
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Enter your current password'),
                  ),
                  TextFormField(
                    controller: controller.newPasswordController,
                    validator: (value) => controller.passwordValidator(value!),
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Enter your new password'),
                  ),
                  h_20,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ElevatedButton(
            onPressed: () async {
              await controller.validateAndSave();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Save"),
                )),
          ),
        ),
      ),
    );
  }

  Widget titleAndText(
      {required String title,
      required String hint,
      required TextTheme textTheme,
      TextEditingController? controller,
      bool? enable,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: BaseTextStyle.heading1(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: (value) => validator != null ? validator(value) : null,
          onSaved: (value) {},
          inputFormatters: const [],
          enabled: enable ?? true,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}
