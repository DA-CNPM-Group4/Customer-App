import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "Forgot Password",
            style: BaseTextStyle.heading2(fontSize: 20),
          ),
          elevation: 1,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 102),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reset Password",
                      style: BaseTextStyle.heading4(color: Colors.black),
                    ),
                    const SizedBox(height: 18),
                    RichText(
                      text: TextSpan(
                          style: BaseTextStyle.body2(color: Colors.black),
                          children: [
                            const TextSpan(text: "Please enter your "),
                            TextSpan(
                                text: "Email ",
                                style: BaseTextStyle.subtitle2(
                                    color: Colors.black)),
                            const TextSpan(text: "to reset your password."),
                          ]),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: controller.formKey,
                      child: Obx(
                        () => TextFormField(
                          controller: controller.emailController,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          validator: (value) =>
                              controller.emailValidator(value!),
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              errorText: controller.emailError.value,
                              hintText: 'someone@gmail.com',
                              hintStyle:
                                  BaseTextStyle.body3(color: Colors.grey),
                              suffixIcon: const Icon(Icons.email_rounded)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.sendResetPasswordOTP();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Continue"),
                          ),
                        ),
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 15,
                          color: BaseColor.blue,
                        ),
                        label: Text("Back to Login",
                            style: BaseTextStyle.body2(color: BaseColor.blue)))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
