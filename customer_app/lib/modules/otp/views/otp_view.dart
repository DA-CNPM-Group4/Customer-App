import 'package:customer_app/modules/otp/controllers/otp_controller.dart';
import 'package:customer_app/modules/password/views/password_view.dart';
import 'package:customer_app/routes/app_pages.dart';
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
                      key: controller.formKey,
                      child: Pinput(
                        length: 6,
                        controller: controller.otpController,
                        // validator: (value) => controller.validator(),
                        errorText: controller.error.value,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Obx(
                        () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: controller.isClicked.value
                                ? null
                                : () {
                                    controller.startTimer();
                                  },
                            child: controller.isClicked.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${controller.start.value}s",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  )
                                : const Text("Resend")),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.grey,
            onPressed: () {
              Get.toNamed(Routes.WELCOME);
            },
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          )),
    );
  }
}
