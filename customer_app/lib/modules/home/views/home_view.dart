import 'package:customer_app/modules/utils/fake_search.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  Widget mainIconButton({
    required String icon,
    required String title,
    Function()? onPressed,
    String? keyString,
  }) {
    return keyString != null
        ? GestureDetector(
            key: Key(keyString),
            onTap: onPressed,
            child: Column(
              children: [
                Image.asset(
                  icon,
                  height: 55,
                  width: 55,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: BaseTextStyle.heading1(fontSize: 14),
                )
              ],
            ),
          )
        : GestureDetector(
            onTap: onPressed,
            child: Column(
              children: [
                Image.asset(
                  icon,
                  height: 55,
                  width: 55,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: BaseTextStyle.heading1(fontSize: 14),
                )
              ],
            ),
          );
  }

  Widget mainBanner(
      {required String icon,
      Function()? onPressed,
      double? elevation,
      BannerTypes? e}) {
    return GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: elevation ?? 10,
          margin: EdgeInsets.symmetric(
              vertical: e == BannerTypes.vertical ? 10 : 0,
              horizontal: e == BannerTypes.horizontal ? 10 : 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Image.asset(icon),
        ));
  }

  @override
  Widget build(BuildContext context) {
    const h = SizedBox(
      height: 10,
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.green,
            title: FakeSearch(
              hint: "Find services, food, or places",
              hintStyle: BaseTextStyle.body1(fontSize: 12),
              prefixIcon: Icons.search,
              prefixIconColor: Colors.black,
              onTap: () {
                // Get.toNamed(Routes.SEARCH_PAGE);
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.USER);
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                        child: Image.asset(
                      "assets/icons/icon_account.png",
                      color: Colors.green,
                      height: 20,
                      width: 20,
                    ))),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mainIconButton(
                          keyString: "home_booking_bike",
                          icon: "assets/icons/main_icon_1.png",
                          title: "BikeHub",
                          onPressed: () {
                            Get.toNamed(Routes.FIND_TRANSPORTATION);
                          }),
                      mainIconButton(
                          icon: "assets/icons/main_icon_2.png",
                          title: "CarHub",
                          onPressed: () {
                            Get.toNamed(Routes.FIND_TRANSPORTATION);
                          }),
                      mainIconButton(
                          icon: "assets/icons/main_icon_4.png",
                          title: "FoodHub",
                          onPressed: () {
                            debugPrint("3");
                          }),
                      mainIconButton(
                          icon: "assets/icons/main_icon_3.png",
                          title: "SendHub",
                          onPressed: () {
                            debugPrint("4");
                          })
                    ],
                  ),
                  h,
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, item) {
                      return mainBanner(
                          icon: controller.banners[item],
                          e: BannerTypes.vertical,
                          elevation: 0);
                    },
                    itemCount: controller.banners.length,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

enum BannerTypes { vertical, horizontal }
