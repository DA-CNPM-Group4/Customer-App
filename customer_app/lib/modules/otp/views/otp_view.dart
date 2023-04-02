import 'package:customer_app/modules/otp/controllers/otp_controller.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);

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
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/img.png",
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You're almost there!",
                    style: BaseTextStyle.heading1(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You must enter OTP which we sent you earlier",
                    style: BaseTextStyle.body1(),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: controller.otpFormKey,
                    child: Pinput(
                      length: 6,
                      controller: controller.otpController,
                      // validator: (value) => controller.validator(),
                      errorText: controller.error.value,
                    ),
                  ),
                  const SizedBox(height: 32),
                  controller.lifeCycleController.isActiveOTP == false
                      ? SizedBox(
                          height: 160,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enter your new password",
                                style: BaseTextStyle.heading3(fontSize: 18),
                              ),
                              Form(
                                key: controller.passwordFormKey,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: controller.passwordController,
                                  validator: (value) =>
                                      controller.passwordValidator(value!),
                                  decoration: const InputDecoration(),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          await controller.startTimer();
                        },
                        child: controller.isLoading2.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Resend")),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ElevatedButton(
            onPressed: () async {
              await controller.confirmOTP();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Continue"),
                )),
          ),
        ),
      ),
    );
  }
}
