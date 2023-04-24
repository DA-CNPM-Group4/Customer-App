import 'package:customer_app/core/utils/utils.dart';
import 'package:customer_app/modules/login/controllers/login_controller.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      height: (keyboardHeight == 0) ? heightSafeArea * 0.4 : 0,
                      child: Image.asset("assets/images/banner1.png",
                          width: safeWidth * 0.8, fit: BoxFit.fitWidth)),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Login",
                      style: BaseTextStyle.heading1(
                          fontSize: 30, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Email",
                    style: BaseTextStyle.heading3(fontSize: 20),
                  ),
                  Form(
                    key: controller.emailFormKey,
                    child: Obx(
                      () => TextFormField(
                        key: const Key("login_email_field"),
                        controller: controller.emailController,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (value) =>
                            StringValidator.emailValidator(value!),
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            errorText: controller.errorText.value,
                            hintText: 'someone@gmail.com',
                            hintStyle: BaseTextStyle.body3(color: Colors.grey),
                            suffixIcon: const Icon(Icons.email_rounded)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Phone",
                    style: BaseTextStyle.heading3(fontSize: 20),
                  ),
                  Form(
                    key: controller.phoneFormKey,
                    child: Obx(
                      () => TextFormField(
                        key: const Key("login_phone_field"),
                        controller: controller.phoneNumberController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) =>
                            StringValidator.phoneNumberValidator(value!),
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            errorText: controller.errorText.value,
                            hintText: 'Enter phone number',
                            hintStyle: BaseTextStyle.body3(color: Colors.grey),
                            suffixIcon: const Icon(Icons.phone_android)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: BaseColor.blue),
                        onPressed: () async {
                          await controller.signInWithGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Text('Sign-in with Google')
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            key: const Key("login_login_btn"),
            elevation: 0.0,
            backgroundColor: Colors.grey,
            onPressed: () async {
              await controller.validateAndSave();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
            )),
      ),
    );
  }
}
