import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/password_login_controller.dart';

class PasswordLoginView extends GetView<PasswordLoginController> {
  const PasswordLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const h = SizedBox(
      height: 10,
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
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "One more step!",
                  style: BaseTextStyle.heading2(fontSize: 24),
                ),
                h,
                Text(
                  "You only have to enter a password in order to access our system",
                  style: BaseTextStyle.heading3(fontSize: 18),
                ),
                const SizedBox(height: 32),
                Text(
                  "Password",
                  style: BaseTextStyle.heading3(fontSize: 18),
                ),
                Form(
                  key: controller.formKey,
                  child: TextFormField(
                    obscureText: true,
                    controller: controller.passwordController,
                    validator: (value) => controller.passwordValidator(value!),
                    decoration: const InputDecoration(),
                  ),
                )
              
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              backgroundColor: Colors.grey,
              onPressed: () async {
                if (controller.check()) {
                  await controller.login();
                }
                // Get.offNamedUntil(
                //     Routes.HOME, ModalRoute.withName(Routes.HOME));
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
              ))),
    );
  }
}
