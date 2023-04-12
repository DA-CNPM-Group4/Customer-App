import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import 'package:get/get.dart';
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
                      controller.rxPassenger?.value?.name ?? "Unknown",
                      style: BaseTextStyle.heading2(fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.rxPassenger?.value?.email ?? "Unknown",
                          style: BaseTextStyle.body2(fontSize: 14),
                        ),
                        Text(
                          "+84 ${controller.rxPassenger?.value?.phone ?? "Unknown"}",
                          style: BaseTextStyle.body2(fontSize: 14),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.auto_fix_normal),
                      onPressed: () {
                        Get.toNamed(Routes.EDIT_PROFILE);
                      },
                    ),
                  )),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {},
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
                        bankName: controller.rxPassenger?.value?.name ?? "",
                        isHolderNameVisible: true,
                        showBackView: false,
                        onCreditCardWidgetChange:
                            (creditCardBrand) {}, //true when you want to show cvv(back) view
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
                              onTap: () async {
                                await controller.settings[index].ontap?.call();
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
}
