import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  Widget mainIconButton(
      {required String icon, required String title, Function()? onPressed}) {
    return GestureDetector(
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
            style: BaseTextStyle.heading2(),
          )
        ],
      ),
    );
  }

  Widget mainBanner(
      {required String icon,
      Function()? onPressed,
      double? elevation,
      TYPES? e}) {
    return GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: elevation ?? 10,
          margin: EdgeInsets.symmetric(
              vertical: e == TYPES.VERTICAL ? 10 : 0,
              horizontal: e == TYPES.HORIZONTAL ? 10 : 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Image.asset(icon),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const h = SizedBox(
      height: 10,
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.green,
            title: Text(
              "Home Page",
              style: BaseTextStyle.heading2(),
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
                      "assets/icon_account.png",
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
                          icon: "assets/main_icon/main_icon_1.png",
                          title: "GoRide",
                          onPressed: () {
                            Get.toNamed(Routes.FIND_TRANSPORTATION);
                          }),
                      mainIconButton(
                          icon: "assets/main_icon/main_icon_2.png",
                          title: "GoCar Protect",
                          onPressed: () {
                            Get.toNamed(Routes.FIND_TRANSPORTATION);
                          }),
                      mainIconButton(
                          icon: "assets/main_icon/main_icon_4.png",
                          title: "GoFood",
                          onPressed: () {
                            print("3");
                          }),
                      mainIconButton(
                          icon: "assets/main_icon/main_icon_3.png",
                          title: "GoSend",
                          onPressed: () {
                            print("4");
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
                          icon: controller.banners[item], e: TYPES.VERTICAL);
                    },
                    itemCount: controller.banners.length,
                  ),
                  Image.asset("assets/go_food_logo.png", height: 60, width: 60),
                  Text(
                    "Get your favourite dishes here!",
                    style: textTheme.bodyText1,
                  ),
                  h,
                  const Text("Choose from a wide range of restaurants"),
                  h,
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, item) {
                        return mainBanner(
                            icon: controller.banners_2[item],
                            e: TYPES.HORIZONTAL,
                            elevation: 0);
                      },
                      itemCount: controller.banners_2.length,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

enum TYPES { VERTICAL, HORIZONTAL }
