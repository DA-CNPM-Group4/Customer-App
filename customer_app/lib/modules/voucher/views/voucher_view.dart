import 'package:customer_app/modules/home/widgets/fake_search.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/common/voucher_ticket.dart';
import '../controllers/voucher_controller.dart';

class VoucherView extends GetView<VoucherController> {
  const VoucherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          color: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Text(
                      "Vouchers",
                      style: BaseTextStyle.heading2(
                          fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const FakeSearch(
                  prefixIcon: Icons.search,
                  hint: 'Have a promo code? Enter it here...',
                  suffixIcon: Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => AnimatedPositioned(
              top: controller.scrollPosition.value <= 0
                  ? Get.height * 0.2
                  : Get.height * 0.12,
              duration: const Duration(milliseconds: 150),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16)),
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available vouchers",
                        style: BaseTextStyle.heading2(fontSize: 15),
                      ),
                      Obx(
                        () => controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 120),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, itemBuilder) {
                                  if (controller.selectedVoucher != null) {
                                    if (controller
                                            .vouchers[itemBuilder].discountId ==
                                        controller
                                            .selectedVoucher!.discountId!) {
                                      return TicketView(
                                          voucher:
                                              controller.vouchers[itemBuilder],
                                          selected: true);
                                    }
                                  }
                                  return TicketView(
                                      voucher: controller.vouchers[itemBuilder],
                                      selected: false);
                                },
                                itemCount: controller.vouchers.length,
                              ),
                      ),
                    ],
                  ),
                ),
              )),
        )
      ],
    ));
  }
}
