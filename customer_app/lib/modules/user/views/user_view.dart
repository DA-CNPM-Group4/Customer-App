import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../data/common/loading.dart';
import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  Widget userLoading() {
    return ListTile(
      leading: Container(
          margin: const EdgeInsets.only(right: 10),
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration:
              const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: Center(
              child: Image.asset(
            "assets/icons/icon_account.png",
            color: Colors.white,
            height: 20,
            width: 20,
          ))),
      title: Loading.circle(width: Get.width, height: 13, borderRadius: 13),
      horizontalTitleGap: 10,
      subtitle: Padding(
        padding: EdgeInsets.only(right: Get.width * 0.15),
        child: Loading.circle(width: Get.width, height: 13, borderRadius: 13),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.auto_fix_normal),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
          "My Profile",
          style: BaseTextStyle.heading2(fontSize: 18),
        ),
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Obx(() => controller.isLoading.value
                ? userLoading()
                : ListTile(
                    leading: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Center(
                            child: Image.asset(
                          "assets/icons/icon_account.png",
                          color: Colors.white,
                          height: 20,
                          width: 20,
                        ))),
                    title: Text(
                      controller.user?.fullName ?? "Minh Duc",
                      style: BaseTextStyle.heading4(fontSize: 18),
                    ),
                    horizontalTitleGap: 20,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.user?.email ?? "minhduc@gmail.com",
                          style: BaseTextStyle.body2(fontSize: 14),
                        ),
                        Text(
                          "+84${controller.user?.phoneNumber ?? "0987654981"}",
                          style: BaseTextStyle.body2(fontSize: 14),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.auto_fix_normal),
                      onPressed: () {},
                    ),
                  )),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Get.bottomSheet(choice(textTheme: textTheme));
              },
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CreditCardWidget(
                        isSwipeGestureEnabled: false,
                        cardNumber: "123456789123456789",
                        expiryDate: "",
                        cvvCode: "",
                        cardHolderName:
                            "Balance ${controller.wallet?.balance ?? 0}",
                        bankName: controller.user?.fullName ?? "",
                        isHolderNameVisible: true,
                        showBackView: false,
                        onCreditCardWidgetChange:
                            (CreditCardBrand) {}, //true when you want to show cvv(back) view
                      ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return StickyHeader(
                  header: Container(
                    height: 50.0,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.header[index],
                      style: BaseTextStyle.heading2(fontSize: 16),
                    ),
                  ),
                  content: ShrinkWrappingViewport(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                if (controller.settings[index].name ==
                                    "Log out") {
                                  Get.offAllNamed(
                                      controller.settings[index].page);
                                  controller.logout();
                                }
                              },
                              leading: Image.asset(
                                controller.settings[index].icons,
                                height: 30,
                              ),
                              horizontalTitleGap: 10,
                              title: Text(
                                controller.settings[index].name,
                                style: BaseTextStyle.body2(fontSize: 16),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ),
                            );
                          },
                          // 40 list items
                          childCount: controller.settings.length,
                        ),
                      )
                    ],
                    offset: ViewportOffset.zero(),
                  ),
                );
              },
              childCount: controller.header.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget choice({required TextTheme textTheme}) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: Get.height * 0.3,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        children: [
          const SizedBox(
            width: 25,
            child: Divider(
              color: Colors.black,
              thickness: 5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Which choice do you want to choose?",
            style: BaseTextStyle.heading2(fontSize: 16),
          ),
          const SizedBox(
            height: 22,
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    Get.back();
                    method(type: true, textTheme: textTheme);
                  },
                  leading: const Icon(
                    Icons.move_to_inbox,
                    color: Colors.black,
                  ),
                  title: const Text("Recharge"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.back();
                    method(type: false, textTheme: textTheme);
                  },
                  leading: const Icon(
                    Icons.outbox,
                    color: Colors.black,
                  ),
                  title: const Text("Withdraw"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void method({required bool type, required TextTheme textTheme}) async {
    TextEditingController otpController = TextEditingController();
    TextEditingController moneyController = TextEditingController();
    var check1 = false.obs;
    var check2 = false.obs;
    moneyController.addListener(() {
      if (moneyController.text.isNotEmpty) {
        check1.value = true;
      } else {
        check1.value = false;
      }
    });
    otpController.addListener(() {
      if (otpController.text.length == 6) {
        check2.value = true;
      } else {
        check2.value = false;
      }
    });
    const h = SizedBox(
      height: 10,
    );

    Get.bottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        Container(
          padding: const EdgeInsets.all(10),
          height: Get.height * 0.52,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                centerTitle: true,
                title: Text(
                  type ? "Recharge" : "Withdraw",
                  style: BaseTextStyle.heading2(fontSize: 16),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h,
                    Text(
                      "Money",
                      style: BaseTextStyle.body2(fontSize: 16),
                    ),
                    TextFormField(
                        controller: moneyController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: 'e.g 50000',
                        )),
                    h,
                    Text(
                      "OTP",
                      style: BaseTextStyle.body2(fontSize: 16),
                    ),
                    h,
                    Pinput(
                      length: 6,
                      controller: otpController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Obx(
                        () => ElevatedButton(
                            onPressed: controller.isClicked.value
                                ? null
                                : () async {
                                    await controller.startTimer();
                                  },
                            child: controller.isClicked.value
                                ? Text(
                                    "${controller.start.value}s",
                                    style: const TextStyle(fontSize: 20),
                                  )
                                : const Text("Resend")),
                      ),
                    ),
                  ],
                ),
              ),
              resizeToAvoidBottomInset: false,
              bottomSheet: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Obx(
                    () => ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: check1.value && check2.value
                            ? () async {
                                await controller.validateOTP(
                                    otpController, moneyController, type);
                              }
                            : null,
                        child: controller.buttonLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Confirm")),
                  ))),
        ));
  }
}
